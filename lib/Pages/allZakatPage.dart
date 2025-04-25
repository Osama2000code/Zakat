import 'package:flutter/material.dart';
import 'package:zakat_app/DataBase/Helpers/dbConnction.dart';
import 'package:zakat_app/DataBase/Models/projects%20_Model.dart';
import 'package:zakat_app/Pages/ZakatProjectsPage.dart';

class AllZakatPage extends StatefulWidget {
  const AllZakatPage({super.key});

  @override
  State<AllZakatPage> createState() => _AllZakatPageState();
}

class _AllZakatPageState extends State<AllZakatPage> {
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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('المشاريع '),
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.inverseSurface,
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(8.0),
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          children: [
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
                                  height: 150,
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
                                            builder: (context) =>
                                                ZakatProjectsPage(
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
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        LinearProgressIndicator(
                                          value: 0.1,
                                          minHeight: 5,
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        SizedBox(
                                          height: 20,
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
                            return Center(
                                child: const CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
