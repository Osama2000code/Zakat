import 'package:flutter/material.dart';

class MyDrawerTile extends StatelessWidget {
  final String title;
  final IconData iconData;
  final void Function()? onTap;
  const MyDrawerTile({
    super.key,
    required this.iconData,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontSize: 20,
          ),
        ),
        onTap: onTap,
        leading: Icon(iconData),
      ),
    );
  }
}
