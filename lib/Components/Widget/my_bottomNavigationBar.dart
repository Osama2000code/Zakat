import 'package:flutter/material.dart';
import 'package:zakat_app/Pages/HomePage.dart';
import 'package:zakat_app/Pages/ZakatPage.dart';
import 'package:zakat_app/Pages/settingsPage.dart';

class MybottomNavigationBar extends StatefulWidget {
  const MybottomNavigationBar({super.key});

  @override
  State<MybottomNavigationBar> createState() => _MybottomNavigationBarState();
}

class _MybottomNavigationBarState extends State<MybottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    final List pages = [
      const HomePage(),
      const ZakatPage(),
      const SettingPage()
    ];
    return Scaffold(
        body: pages[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wallet),
              label: "Zakat",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ));
  }
}
