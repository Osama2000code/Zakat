import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zakat_app/Pages/user/editUser.dart';
import 'package:zakat_app/Services/user_provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.currentUser;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditUser(
                      usersModel: user,
                    ),
                  ));
            },
            child: const Text('EDIT'),
          )
        ],
        title: Text(
          "البيانات الشخصية ",
          style: TextStyle(color: Theme.of(context).colorScheme.inverseSurface),
        ),
        centerTitle: true,
        elevation: 0.0,
        foregroundColor: Theme.of(context).colorScheme.inverseSurface,

        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(radius: 40, backgroundColor: Colors.grey),
            const SizedBox(height: 8),
            Text(
              user!.username,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('I love Zakat App'),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('FULL NAME'),
                      subtitle: Text(user.username),
                    ),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text('EMAIL'),
                      subtitle: Text(user.email),
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: const Text('PHONE NUMBER'),
                      subtitle: Text(user.phone),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
