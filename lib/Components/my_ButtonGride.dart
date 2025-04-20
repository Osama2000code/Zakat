import 'package:flutter/material.dart';

class MyButtonGride extends StatelessWidget {
  final IconData iconB;
  final String title;
  final Function()? onTapB;
  const MyButtonGride({
    super.key,
    required this.onTapB,
    required this.title,
    required this.iconB,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapB,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(15),
        ),
        width: 500,
        height: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title),
            Icon(
              iconB,
              color: Theme.of(context).colorScheme.primary,
              size: 60,
            ),
          ],
        ),
      ),
    );
  }
}
