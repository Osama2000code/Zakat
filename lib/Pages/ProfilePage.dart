import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(color: Theme.of(context).colorScheme.inverseSurface),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
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
                      "Osmaa Samier",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                    Text(
                      "osamasamier@gmail.com",
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
          const ListTile(
            title: Text("data"),
          ),
          const ListTile(
            title: Text("data"),
          ),
          const ListTile(
            title: Text("data"),
          ),
          const ListTile(
            title: Text("data"),
          ),
        ],
      ),
    );
  }
}
