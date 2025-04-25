import 'package:flutter/material.dart';
import 'package:zakat_app/DataBase/Helpers/dbConnction.dart';
import 'package:zakat_app/DataBase/Models/payment_model.dart';
import 'package:zakat_app/DataBase/Models/projects%20_Model.dart';
import 'package:zakat_app/DataBase/Models/users_model.dart';
import 'package:zakat_app/DataBase/Models/zkata_model.dart';

class PaymentPage extends StatefulWidget {
  late bool? display;
  late ProjectModel? projectModel;
  late UsersModel? user;
  late String? zakatDate;
  late String? monay;
  PaymentPage({
    super.key,
    this.projectModel,
    this.zakatDate,
    this.user,
    this.display,
    this.monay,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Future<List<PaymentModel>> payList;
  DBMatser db = DBMatser();
  getAllPyamentType() async {
    setState(() {
      payList = db.getAllPayment();
    });
  }

  showSnak(String ms) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ms == "خطاء " ? Colors.red : Colors.green,
        content: Text(
          textAlign: TextAlign.center,
          ms,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  viewPymwnt(List<PaymentModel> paymentModel) {
    return ListView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(5),
      children: paymentModel
          .map((e) => Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.secondary),
                child: ListTile(
                  leading: Image.memory(
                    e.paymentImage!,
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                  title: Text(e.paymentName),
                  onLongPress: () async {
                    if (widget.display!) {
                      ZakatModel zakatModel = ZakatModel(
                        zakatDetels: widget.zakatDate,
                        zakatDate: DateTime.now().toString(),
                        userID: widget.user!.id,
                      );
                      int res = await db.savaZakat(zakatModel);
                      if (res > 0) {
                        await db.updateProjectsMonay(
                            widget.monay!, widget.projectModel!.projectID);
                        showSnak("تمت العملية ");

                        Navigator.pop(context);
                      } else {
                        showSnak("خطاء");
                      }
                    } else {
                      if (widget.zakatDate != null) {
                        ZakatModel zakatModel = ZakatModel(
                          zakatDetels: widget.zakatDate,
                          zakatDate: DateTime.now().toString(),
                          userID: widget.user!.id,
                        );
                        int res = await db.savaZakat(zakatModel);
                        if (res > 0) {
                          showSnak("تمت العملية ");

                          Navigator.pop(context);
                        } else {
                          showSnak("خطاء");
                        }
                      }
                    }
                  },
                ),
              ))
          .toList(),
    );
  }

  @override
  void initState() {
    getAllPyamentType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(" الدفع"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.inverseSurface,
      ),
      body: ListView(
        children: [
          Center(
            child: Text(widget.zakatDate!),
          ),
          Divider(),
          Container(
            height: 400,
            width: 200,
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
            child: FutureBuilder(
              future: payList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return viewPymwnt(snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return Center(child: const CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
