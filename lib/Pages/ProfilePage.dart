import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zakat_app/DataBase/Helpers/dbConnction.dart';
import 'package:zakat_app/DataBase/Models/users_model.dart';
import 'package:zakat_app/Services/user_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DBMatser db = DBMatser();
  late Future<UsersModel?> usersModel;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: true,
    );
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
      body: FutureBuilder<UsersModel?>(
        future: userProvider.getCurrentUserID(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = snapshot.data!;
          print(items.toMAp());
          if (snapshot.hasData) {
            if (items.role == "user") {
              //
              return Center(
                child: Text("This is User ${items.role}"),
              );
              //
            } else {
              return Text("This is ${items.role}");
            }

            //
          } else {
            return Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("User Id = ${items.username}"),
                    Text("User Id = ${items.role}"),
                  ],
                ),
              ),
            );
            //
          }
        },
      ),
      // body: ListView(
      //   children: [
      //     Container(
      //       height: 150,
      //       margin: const EdgeInsets.all(8.0),
      //       padding: const EdgeInsets.all(10.0),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           ClipRRect(
      //             borderRadius: BorderRadius.circular(6.0),
      //             child: Image.asset(
      //               "assets/images/First-Logog-In-Login-Ragster.jpg",
      //               height: 50,
      //               width: 50,
      //             ),
      //           ),
      //           Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Text(
      //                 "Welcom ${userProvider.currentUser?.id} no ",
      //                 style: TextStyle(
      //                   fontSize: 16,
      //                   fontWeight: FontWeight.bold,
      //                   color: Theme.of(context).colorScheme.inverseSurface,
      //                 ),
      //               ),
      //               Text(
      //                 "${userProvider.currentUser?.email}",
      //                 style: TextStyle(
      //                   fontSize: 12,
      //                   color: Theme.of(context).colorScheme.inversePrimary,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),

      //     const Divider(),
      //     ListTile(
      //       title: Text("Your Are $isadmin"),
      //     ),
      //     const ListTile(
      //       title: Text("data"),
      //     ),
      //     const ListTile(
      //       title: Text("data"),
      //     ),
      //     const ListTile(
      //       title: Text("data"),
      //     ),
      //   ],
      // ),
    );
  }
}
