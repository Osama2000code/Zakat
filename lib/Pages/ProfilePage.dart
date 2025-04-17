import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zakat_app/DataBase/Helpers/dbConnction.dart';
import 'package:zakat_app/Pages/ZakatProjectsPage.dart';
import 'package:zakat_app/Pages/settingsPage.dart';
import 'package:zakat_app/Pages/user/view.dart';
import 'package:zakat_app/Services/user_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DBMatser db = DBMatser();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    final user = userProvider.currentUser;
    showUser() {
      if (user == null) {
        return const Text("Not Loggged in ");
      } else if (user.role == "1") {
        return ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  // go to Admin dashboard
                  builder: (context) => const ZakatScreen(),
                ));
          },
          leading: const Icon(Icons.dashboard),
          title: const Text("لوحة التحكم "),
        );
      } else {
        return ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  // go to Edite User Info
                  builder: (context) => const ProfileView(),
                ));
          },
          leading: const Icon(Icons.info),
          title: const Text("البيانات الشخصية   "),
        );
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(color: Theme.of(context).colorScheme.inverseSurface),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),

      //

      body: ListView(
        children: [
          Container(
            height: 150,
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Image.asset(
                    "assets/images/First-Logog-In-Login-Ragster.jpg",
                    height: 50,
                    width: 50,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcom ${user!.username} Back . ".toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Email : ${user.email}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          showUser(),
          ListTile(
            title: const Text("Seeting"),
            leading: const Icon(Icons.settings_ethernet),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingPage(),
                  ));
            },
          ),
          ListTile(
            title: const Text("تسجيل الخروج "),
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            onTap: () async {
              await userProvider.outUser();
              Future.delayed(
                const Duration(seconds: 2),
                () => SystemNavigator.pop(),
              );
            },
          ),
        ],
      ),
    );
  }
}
