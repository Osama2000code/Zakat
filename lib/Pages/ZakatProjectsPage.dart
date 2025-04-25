import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zakat_app/Components/my_Button.dart';
import 'package:zakat_app/Components/my_TextField.dart';
import 'package:zakat_app/DataBase/Models/projects%20_Model.dart';
import 'package:zakat_app/Pages/paymentPage.dart';
import 'package:zakat_app/Services/user_provider.dart';

class ZakatProjectsPage extends StatefulWidget {
  late ProjectModel projectList;
  ZakatProjectsPage({
    super.key,
    required this.projectList,
  });

  @override
  State<ZakatProjectsPage> createState() => _ZakatProjectsPageState();
}

class _ZakatProjectsPageState extends State<ZakatProjectsPage> {
  TextEditingController _monatDonController = TextEditingController();
  String zakatDtata = '';
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.currentUser;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Zakat Info"),
        foregroundColor: Theme.of(context).colorScheme.inverseSurface,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(3.0),
                          topRight: Radius.circular(3.0),
                        ),
                        child: Image.memory(
                          widget.projectList
                              .projectImage!, // Replace with your image URL
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.projectList.projectName,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: 0.2,
                              minHeight: 6,
                              backgroundColor:
                                  Theme.of(context).colorScheme.inversePrimary,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Rp ${widget.projectList.projectTargetAmount}',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Raised ${widget.projectList.projectTargetRaised}',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Divider(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                            Text(
                              'ُEnd At : ${widget.projectList.projectEndDate}',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Divider(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                            Text(
                              widget.projectList.projectDescription,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            MyButton(
                                label: "تبرع الان ",
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("ادخل المبلغ"),
                                      content: MyTextField(
                                        icon: Icons.money,
                                        textInputType: TextInputType.number,
                                        obscureText: false,
                                        controller: _monatDonController,
                                        label: "المبلغ",
                                      ),
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "الغاء",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                if (_monatDonController.text !=
                                                    '') {
                                                  setState(() {
                                                    zakatDtata =
                                                        " { ${_monatDonController.text} ريال للمشروع ${widget.projectList.projectName} } ";
                                                  });
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            PaymentPage(
                                                          user: user,
                                                          projectModel: widget
                                                              .projectList,
                                                          zakatDate: zakatDtata,
                                                          display: true,
                                                          monay:
                                                              _monatDonController
                                                                  .text,
                                                        ),
                                                      ));
                                                  setState(() {});
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        " يجب ادخال بيانات في الحقل"),
                                                  ));
                                                }
                                              },
                                              child: Text(
                                                "استمرار",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
