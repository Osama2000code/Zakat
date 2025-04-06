import 'package:flutter/material.dart';
import 'package:zakat_app/Components/my_DrawerTile.dart';
import 'package:zakat_app/Pages/settingsPage.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // logo
          Padding(
            padding: const EdgeInsets.only(top: 88.0),
            child: Image.asset("assets/images/logo.png"),
          ),
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Divider(
              color: Theme.of(context).colorScheme.primary,
              indent: 20.0,
              endIndent: 20.0,
            ),
          ),
          MyDrawerTile(
            iconData: Icons.home,
            onTap: (() => Navigator.pop(context)),
            title: "Home",
          ),
          MyDrawerTile(
            iconData: Icons.settings,
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingPage(),
                ),
              );
            },
            title: "Settings",
          ),
          const Spacer(),
          MyDrawerTile(
            iconData: Icons.exit_to_app,
            onTap: (() => Navigator.pop(context)),
            title: "Exit",
          ),
          const SizedBox(
            height: 55.0,
          )
        ],
      ),
    );
  }
}
