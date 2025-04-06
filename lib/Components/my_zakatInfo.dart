import 'package:flutter/material.dart';

class MyzakatInfo extends StatelessWidget {
  final String title;
  final String info;
  const MyzakatInfo({super.key, required this.info, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            info,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
