import 'package:flutter/material.dart';
import 'package:zakat_app/DataBase/Helpers/dbConnction.dart';
import 'package:zakat_app/DataBase/Models/payment_model.dart';
import 'package:zakat_app/Pages/Admin/paymentMange/addPayment.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  late Future<List<PaymentModel>> payList;
  getDate() async {
    DBMatser db = DBMatser();
    setState(() {
      payList = db.getAllPayment();
    });
  }

  SingleChildScrollView listProjctView(List<PaymentModel> paymentmodel) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text("ID"),
          ),
          DataColumn(
            label: Text("Pyment Name"),
          ),
          DataColumn(
            label: Text("Image"),
          ),
          DataColumn(label: Text("Actions"))
        ],
        rows: paymentmodel
            .map(
              (e) => DataRow(
                cells: [
                  DataCell(
                    Text(
                      e.payID.toString(),
                    ),
                  ),
                  DataCell(
                    Text(
                      e.paymentName,
                    ),
                  ),
                  DataCell(
                    Image.memory(
                      e.paymentImage!,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) =>
                            //           EditUserAdmin(usersModel: element),
                            //     ));
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Center(
                                  child: Text("عملية حذف "),
                                ),
                                content: Text("هل انت متاكد في عملية الحذف "),
                                actions: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.cancel,
                                          color: Colors.red,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.save,
                                          color: Colors.green,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.delete_forever_rounded,
                            color: Color.fromARGB(255, 245, 160, 154),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  void initState() {
    getDate();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.inverseSurface,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text("Payment"),
        centerTitle: true,
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPayment(),
              ));
        },
        child: Icon(Icons.add),
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            height: double.infinity,
            child: FutureBuilder(
              future: payList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return listProjctView(snapshot.data!);
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
