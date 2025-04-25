import 'package:flutter/material.dart';
import 'package:zakat_app/DataBase/Helpers/dbConnction.dart';
import 'package:zakat_app/DataBase/Models/applicants_model.dart';

class ViewApplicants extends StatefulWidget {
  const ViewApplicants({super.key});

  @override
  State<ViewApplicants> createState() => _ViewApplicantsState();
}

class _ViewApplicantsState extends State<ViewApplicants> {
  late Future<List<ApplicantsModel>> _applicantsList;

  Future<void> getData() async {
    DBMatser db = DBMatser();
    setState(() {
      _applicantsList = db.getAllApplicants();
    });
  }

  SingleChildScrollView listview(List<ApplicantsModel> applicantsModel) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: const [
          DataColumn(
            label: Text("ID"),
          ),
          DataColumn(
            label: Text("Applicants Name"),
          ),
          DataColumn(
            label: Text("Phone"),
          ),
          DataColumn(
            label: Text("Action"),
          ),
        ],
        rows: applicantsModel
            .map(
              (element) => DataRow(
                cells: [
                  DataCell(
                    Text(element.applicantsID.toString()),
                  ),
                  DataCell(
                    Text(element.applicantsName),
                  ),
                  DataCell(
                    Text(element.userPhone),
                  ),
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ),
                        IconButton(
                          onPressed: null,
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
        title: Text("الطلابات "),
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
              future: _applicantsList,
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
