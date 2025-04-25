import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zakat_app/Components/my_Button.dart';
import 'package:zakat_app/DataBase/Helpers/dbConnction.dart';
import 'package:zakat_app/Pages/paymentPage.dart';
import 'package:zakat_app/Services/user_provider.dart';

class CalculatorZakatPage extends StatefulWidget {
  const CalculatorZakatPage({super.key});

  @override
  State<CalculatorZakatPage> createState() => _CalculatorZakatPageState();
}

class _CalculatorZakatPageState extends State<CalculatorZakatPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DBMatser db = DBMatser();
  final TextEditingController _moneyController = TextEditingController();
  final TextEditingController _peopleController = TextEditingController();
  final TextEditingController _camelsController = TextEditingController();
  final TextEditingController _cowsController = TextEditingController();
  final TextEditingController _sheepController = TextEditingController();

  double nisab = 10085.0; // نصاب زكاة المال
  double zakatMoney = 0.0;
  double zakatFitra = 0.0;
  String zakatLivestock = '';
  String zakatData = '';

  final double fitraAmount = 25.0;

  void calculateMoneyZakat() {
    double money = double.tryParse(_moneyController.text) ?? 0.0;
    if (money >= nisab) {
      setState(() {
        zakatMoney = money * 0.025;
      });
    } else {
      setState(() {
        zakatMoney = 0.0;
      });
    }
  }

  void calculateFitraZakat() {
    int people = int.tryParse(_peopleController.text) ?? 0;
    setState(() {
      zakatFitra = people * fitraAmount;
    });
  }

  void calculateLivestockZakat() {
    int camels = int.tryParse(_camelsController.text) ?? 0;
    int cows = int.tryParse(_cowsController.text) ?? 0;
    int sheep = int.tryParse(_sheepController.text) ?? 0;

    String result = '';

    // زكاة الإبل (مثال مبسط)
    if (camels >= 5 && camels < 10) {
      result += 'زكاة الإبل: شاة واحدة\n';
    } else if (camels >= 10) {
      result += 'زكاة الإبل: ${camels ~/ 5} شياه\n';
    }

    // زكاة البقر (مثال مبسط)
    if (cows >= 30 && cows < 40) {
      result += 'زكاة البقر: تبيع أو تبيعة (عجل عمره سنة)\n';
    } else if (cows >= 40) {
      result += 'زكاة البقر: مسنة (عجل عمره سنتان)\n';
    }

    // زكاة الغنم (مثال مبسط)
    if (sheep >= 40 && sheep < 121) {
      result += 'زكاة الغنم: شاة واحدة\n';
    } else if (sheep >= 121 && sheep < 201) {
      result += 'زكاة الغنم: شاتان\n';
    } else if (sheep >= 201) {
      result += 'زكاة الغنم: ثلاث شياه أو أكثر حسب العدد\n';
    }

    if (result.isEmpty) result = 'لا زكاة مستحقة على الأنعام المدخلة.';

    setState(() {
      zakatLivestock = result;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.currentUser;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("الحاسبة "),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0.0,
        bottom: TabBar(
          indicatorColor: Theme.of(context).colorScheme.primary,
          labelColor: Theme.of(context).colorScheme.inverseSurface,
          controller: _tabController,
          tabs: [
            Tab(text: 'زكاة المال'),
            Tab(text: 'زكاة الفطرة'),
            Tab(text: 'زكاة الأنعام'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // زكاة المال
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('أدخل مقدار المال:', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                TextField(
                  controller: _moneyController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'المبلغ (بالريال)',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                MyButton(
                  label: "احسب",
                  onTap: calculateMoneyZakat,
                ),
                Spacer(),
                MyButton(
                  label: 'استمرار',
                  onTap: () {
                    if (_moneyController.text != '') {
                      zakatData =
                          " زكاة مالية قدرة {${_moneyController.text}} وناتج الحسبة تساوي {${zakatMoney}}";
                      // select payment type
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentPage(
                              zakatDate: zakatData,
                              user: user,
                              display: false,
                            ),
                          ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(" يجب ادخال بيانات في الحقل"),
                      ));
                    }
                  },
                ),
                SizedBox(height: 20),
                Text(
                  zakatMoney == 0
                      ? 'لا زكاة مستحقة (لم يبلغ المال النصاب)'
                      : 'الزكاة المستحقة: ${zakatMoney.toStringAsFixed(2)} ريال',
                  style: TextStyle(fontSize: 18),
                ),
                Spacer(),
                Text('النصاب الحالي: ${nisab.toStringAsFixed(2)} ريال'),
              ],
            ),
          ),

          // زكاة الفطرة
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('أدخل عدد أفراد الأسرة:', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                TextField(
                  controller: _peopleController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'عدد الأفراد',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                MyButton(
                  label: 'احسب زكاة الفطرة',
                  onTap: calculateFitraZakat,
                ),
                Spacer(),
                MyButton(
                  label: 'استمرار',
                  onTap: () {
                    if (_peopleController.text != '') {
                      zakatData =
                          " زكاة الفطر  قدرة {${_peopleController.text}} وناتج الحسبة تساوي {${zakatFitra}}";
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentPage(
                              zakatDate: zakatData,
                              user: user,
                              display: false,
                            ),
                          ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(" يجب ادخال بيانات في الحقل"),
                      ));
                    }
                  },
                ),
                // ElevatedButton(
                //   onPressed: calculateFitraZakat,
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.green[700],
                //   ),
                //   child: const Text('احسب زكاة الفطرة'),
                // ),
                SizedBox(height: 20),
                Text(
                  'زكاة الفطرة المستحقة: ${zakatFitra.toStringAsFixed(2)} ريال',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),

          // زكاة الأنعام
          Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('أدخل عدد الأنعام:', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  TextField(
                    controller: _camelsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'عدد الإبل',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _cowsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'عدد البقر',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _sheepController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'عدد الغنم',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: MyButton(
                      label: 'احسب زكاة الأنعام',
                      onTap: calculateLivestockZakat,
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: MyButton(
                      label: 'استمرار',
                      onTap: () {
                        if (_camelsController.text != '' &&
                            _cowsController.text != '' &&
                            _sheepController.text != '') {
                          zakatData = """ 
                          زكاة الانعام  للابل عدد  {${_camelsController.text}}
                          زكاة الانهام للبقر عدد {${_cowsController.text}}
                          زكاة النعام للماعز عدد {${_sheepController.text}}
                          وناتج الحسبة تساوي {${zakatLivestock}}
                          """;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentPage(
                                  zakatDate: zakatData,
                                  user: user,
                                  display: false,
                                ),
                              ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(" يجب ادخال بيانات في الحقل"),
                          ));
                        }
                      },
                    ),
                  ),

                  // child: ElevatedButton(
                  //   onPressed: calculateLivestockZakat,
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.green[700],
                  //   ),
                  //   child: const Text('احسب زكاة الأنعام'),
                  // ),

                  SizedBox(height: 20),
                  Text(
                    zakatLivestock,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
