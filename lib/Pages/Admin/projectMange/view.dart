import 'package:flutter/material.dart';
import 'package:zakat_app/DataBase/Helpers/dbConnction.dart';
import 'package:zakat_app/DataBase/Models/projects%20_Model.dart';
import 'package:zakat_app/Pages/Admin/projectMange/addProject.dart';

class ProjctsView extends StatefulWidget {
  const ProjctsView({super.key});

  @override
  State<ProjctsView> createState() => _ProjctsViewState();
}

class _ProjctsViewState extends State<ProjctsView> {
  late Future<List<ProjectModel>> projctsList;
  getData() {
    DBMatser db = DBMatser();
    setState(() {
      projctsList = db.getAllProjects();
    });
  }

  SingleChildScrollView listProjctView(List<ProjectModel> projectList) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text("ID"),
          ),
          DataColumn(
            label: Text("Projct Name"),
          ),
          DataColumn(
            label: Text("Image"),
          ),
          DataColumn(
            label: Text("Actions"),
          ),
        ],
        rows: projectList
            .map(
              (e) => DataRow(
                cells: [
                  DataCell(
                    Text(
                      e.projectID.toString(),
                    ),
                  ),
                  DataCell(
                    Text(
                      e.projectName,
                    ),
                  ),
                  DataCell(
                    Image.memory(
                      e.projectImage!,
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
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("المشاريع "),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.inverseSurface,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddProject(),
              ));
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            height: double.infinity,
            child: FutureBuilder(
              future: projctsList,
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
