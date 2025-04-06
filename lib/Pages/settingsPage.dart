import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zakat_app/Themes/Theme_providers.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Setting",
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
      body: Column(
        children: [
          // Theme Toggle
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: SwitchListTile(
              value:
                  Provider.of<ThemeProviders>(context, listen: true).isDarkMood,
              onChanged: (value) {
                Provider.of<ThemeProviders>(context, listen: false)
                    .toggleTheme();
              },
              subtitle: Provider.of<ThemeProviders>(context).isDarkMood
                  ? const Text("Dark Mood")
                  : const Text("Light Mood"),
              title: Text(
                "Theme",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              tileColor: Theme.of(context).colorScheme.secondary,
            ),
          )
        ],
      ),
    );
  }
}
