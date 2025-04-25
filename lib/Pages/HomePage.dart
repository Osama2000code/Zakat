import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zakat_app/Components/Widget/my_AppBar.dart';
import 'package:zakat_app/Components/Widget/my_CustomCardAds.dart';
import 'package:zakat_app/Components/Widget/my_CustomCardInfo.dart';
import 'package:zakat_app/DataBase/Helpers/dbConnction.dart';
import 'package:zakat_app/DataBase/Models/projects%20_Model.dart';
import 'package:zakat_app/Pages/ZakatProjectsPage.dart';
import 'package:zakat_app/Pages/allZakatPage.dart';
import 'package:zakat_app/Pages/calculatorZakatPage.dart';
import 'package:zakat_app/Pages/user/addApplicants.dart';
import 'package:zakat_app/Services/user_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.currentUser;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Header(
              userName: user!.username,
              subtitle: user.email,
              profileImageUrl: 'assets/images/First-Logog-In-Login-Ragster.jpg',
            ),

            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 150,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5.0,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  )
                ],
                color: Theme.of(context).colorScheme.background,
              ),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  //Card info End
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddApplicants(user: user),
                          ));
                    },
                    child: MyCustomCardInfo(
                      icon: Icons.document_scanner,
                      title: "تقديم الطلب ",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllZakatPage(),
                        ),
                      );
                    },
                    child: MyCustomCardInfo(
                      icon: Icons.work_outline,
                      title: " المشاريع  ",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CalculatorZakatPage(),
                        ),
                      );
                    },
                    child: MyCustomCardInfo(
                      icon: Icons.calculate,
                      title: " حاسبة الزكاة  ",
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // For Card Ads
            MyCustomCardAds(
              title: "This Is Ads",
              subTitle:
                  "To Donted in Zakat App To  in Zakat App To Donted in Zakat App To Donted in Zakat App",
              bouttmText: "Moree",
              onTap: () => debugPrint("This Is For Ads Detels"),
            ),
            const SizedBox(
              height: 10,
            ),
            // Title Diveder
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Donteds Cards",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inverseSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllZakatPage(),
                      ),
                    );
                  }),
                  child: Text(
                    "View More",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 6,
            ),

            const SizedBox(
              height: 10,
            ),
            Container(
              height: 500,
              width: 300,
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
                              color: Theme.of(context).colorScheme.onBackground,
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
                                        ZakatProjectsPage(projectList: items),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                LinearProgressIndicator(
                                  value: 0.1,
                                  minHeight: 5,
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  color: Theme.of(context).colorScheme.primary,
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
    );
  }
}
