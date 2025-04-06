import 'package:flutter/material.dart';
import 'package:zakat_app/Components/Widget/my_AppBar.dart';
import 'package:zakat_app/Components/Widget/my_CustomCardAds.dart';
import 'package:zakat_app/Components/Widget/my_CustomCardInfo.dart';
import 'package:zakat_app/Components/Widget/my_DonationGrid.dart';
import 'package:zakat_app/Components/Widget/my_bottomNavigationBar.dart';
import 'package:zakat_app/Pages/ZakatPage.dart';
import 'package:zakat_app/Pages/ZakatProjectsPage.dart';
import 'package:zakat_app/Pages/settingsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const Header(
              userName: "Osama",
              subtitle: "OsamaSimer",
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Card info Start
                  Expanded(
                    child: MyCustomCardInfo(
                      backRoundColor: Theme.of(context).colorScheme.background,
                      leftIcon: Icons.wallet,
                      rghteIcon: Icons.add,
                      subTitle: Text(
                        'Dn: \$254.46.8',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.inverseSurface,
                        ),
                      ),
                      mainTitle: Text(
                        'Zkat',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                  ),
                  // Tow 222
                  Expanded(
                    child: MyCustomCardInfo(
                      backRoundColor: Theme.of(context).colorScheme.secondary,
                      leftIcon: Icons.person,
                      mainTitle: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'More Indo More IndoMore',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      rghteIcon: Icons.arrow_forward,
                      subTitle: Text(
                        'ghjjt',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                  ),
                  //Card info End
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
                          builder: (context) => const ZakatProjectsPage(),
                        ));
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     Container(
            //       padding: const EdgeInsets.all(10.0),
            //       margin: const EdgeInsets.symmetric(horizontal: 5.0),
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10),
            //           border: Border.all(
            //             color: Theme.of(context).colorScheme.inversePrimary,
            //           )),
            //       child: const Text("Data"),
            //     ),
            //     Container(
            //       width: 80,
            //       padding: const EdgeInsets.all(8.0),
            //       decoration: BoxDecoration(
            //         color: Theme.of(context).colorScheme.primary,
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       child: const Text("Data"),
            //     ),
            //   ],
            // ),
            const SizedBox(
              height: 10,
            ),
            const MyDonationGrid(),
         
          ],
        ),
      ),
    
    );
  }
}
