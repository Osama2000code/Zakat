import 'package:flutter/material.dart';
import 'package:zakat_app/Components/Widget/my_ZkataIconButton.dart';
import 'package:zakat_app/Components/my_zakatInfo.dart';
import 'package:zakat_app/DataBase/Helpers/dbConnction.dart';
import 'package:zakat_app/DataBase/Models/projects%20_Model.dart';
import 'package:zakat_app/Pages/ZakatProjectsPage.dart';
import 'package:zakat_app/Pages/calculatorZakatPage.dart';

class ZakatPage extends StatefulWidget {
  const ZakatPage({super.key});

  @override
  State<ZakatPage> createState() => _ZakatPageState();
}

class _ZakatPageState extends State<ZakatPage> {
  late Future<List<ProjectModel>> projectList;
  getData() async {
    DBMatser db = DBMatser();
    setState(() {
      projectList = db.getAllProjects();
    });
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
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Zakat",
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            height: 100,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const MyzakatInfo(info: "2025", title: "Time"),
                VerticalDivider(
                  color: Theme.of(context).colorScheme.primary,
                  indent: 5,
                  endIndent: 5,
                  width: 2.0,
                  thickness: 2.0,
                ),
                const MyzakatInfo(info: "5360.00", title: "Gold Time"),
                VerticalDivider(
                  color: Theme.of(context).colorScheme.primary,
                  indent: 5,
                  endIndent: 5,
                  width: 2.0,
                  thickness: 2.0,
                ),
                const MyzakatInfo(info: "1250.00", title: "Finshed"),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(16.0),
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                MyZkataIconButton(
                  onprees: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CalculatorZakatPage(),
                        ));
                  },
                  icon: Icon(
                    Icons.calculate,
                    size: 40,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: "Calculator",
                ),
              ],
            ),
          ),
          Divider(
            thickness: 0.8,
            endIndent: 5,
            indent: 5,
            color: Theme.of(context).colorScheme.primary,
          ),
          Container(
            height: 500,
            child: ListView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  height: 500,
                  width: double.infinity,
                  child: FutureBuilder(
                    future: projectList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final items = snapshot.data![index];
                            return Container(
                              height: 100,
                              width: 200,
                              margin: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 2,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                    )
                                  ]),
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ZakatProjectsPage(
                                            projectList: items),
                                      ));
                                },
                                leading: Image.memory(
                                  items.projectImage!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.fill,
                                ),
                                title: Text(
                                  textAlign: TextAlign.right,
                                  items.projectName,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    LinearProgressIndicator(
                                      value: 0.1,
                                      minHeight: 5,
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      items.projectEndDate,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else {
                        return Center(child: const CircularProgressIndicator());
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
