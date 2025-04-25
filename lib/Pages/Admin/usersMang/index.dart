import 'package:flutter/material.dart';
import 'package:zakat_app/DataBase/Helpers/dbConnction.dart';
import 'package:zakat_app/DataBase/Models/users_model.dart';
import 'package:zakat_app/Pages/Admin/usersMang/editUser.dart';

class UsersViwe extends StatefulWidget {
  const UsersViwe({super.key});

  @override
  State<UsersViwe> createState() => _UsersViweState();
}

class _UsersViweState extends State<UsersViwe> {
  late Future<List<UsersModel>> usersList;
  var dbHelper;
  getData() async {
    DBMatser db = DBMatser();
    setState(() {
      usersList = db.getAllUsers();
    });
  }

  SingleChildScrollView listview(List<UsersModel> usersModel) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: const [
          DataColumn(
            label: Text("ID"),
          ),
          DataColumn(
            label: Text("Username"),
          ),
          DataColumn(
            label: Text("Phone"),
          ),
          DataColumn(
            label: Text("Role"),
          ),
          DataColumn(
            label: Text("Action"),
          ),
        ],
        rows: usersModel
            .map(
              (element) => DataRow(
                cells: [
                  DataCell(
                    Text(element.id.toString()),
                  ),
                  DataCell(
                    Text(element.username),
                  ),
                  DataCell(
                    Text(element.phone),
                  ),
                  DataCell(
                    Text(element.role.toString()),
                  ),
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditUserAdmin(usersModel: element),
                                ));
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
    dbHelper = DBMatser();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.inverseSurface,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text("All Users"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            height: double.infinity,
            child: FutureBuilder(
              future: usersList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return listview(snapshot.data!);
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
