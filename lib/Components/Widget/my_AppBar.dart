import 'package:flutter/material.dart';
import 'package:zakat_app/Pages/ProfilePage.dart';
import 'package:zakat_app/Pages/settingsPage.dart';

class Header extends StatelessWidget {
  final String userName;
  final String subtitle;
  final String profileImageUrl;

  const Header({
    super.key,
    required this.userName,
    required this.subtitle,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                },
                child: ClipOval(
                  child: Image.asset(
                    profileImageUrl,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, $userName',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.notification_important_sharp,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  // Notification action
                },
                padding: EdgeInsets.zero,
              ),
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  // Notification action
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingPage(),
                      ));
                },
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
