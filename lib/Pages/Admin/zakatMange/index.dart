import 'package:flutter/material.dart';
import 'package:zakat_app/DataBase/Helpers/dbConnction.dart';
import 'package:zakat_app/DataBase/Models/zkata_model.dart';

class ZakatAdminView extends StatefulWidget {
  const ZakatAdminView({super.key});

  @override
  State<ZakatAdminView> createState() => _ZakatAdminViewState();
}

class _ZakatAdminViewState extends State<ZakatAdminView> {
  DBMatser db = DBMatser();
  late Future<List<ZakatModel>> zakatList;
  getData() async {
    setState(() {
      zakatList = db.getAllZakat();
    });
  }

  SingleChildScrollView listProjctView(List<ZakatModel> zakatlist) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text("ID"),
          ),
          DataColumn(
            label: Text("بيانات الزكاة"),
          ),
          DataColumn(
            label: Text("تاريخ"),
          ),
          DataColumn(
            label: Text("Actions"),
          )
        ],
        rows: zakatlist
            .map(
              (e) => DataRow(
                cells: [
                  DataCell(
                    Text(
                      e.zakatID.toString(),
                    ),
                  ),
                  DataCell(
                    Text(
                      e.zakatDetels!,
                    ),
                  ),
                  DataCell(
                    Text(e.zakatDate!),
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
                            //           // EditUserAdmin(usersModel: element),
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
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("زكاة "),
        centerTitle: true,
        elevation: 0.0,
        foregroundColor: Theme.of(context).colorScheme.inverseSurface,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            height: double.infinity,
            child: FutureBuilder(
              future: zakatList,
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
