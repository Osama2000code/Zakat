import 'package:flutter/material.dart';

class MyCustomCardAds extends StatelessWidget {
  final String title;
  final String subTitle;
  final String bouttmText;
  final void Function()? onTap;
  const MyCustomCardAds({
    super.key,
    required this.title,
    required this.subTitle,
    required this.bouttmText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(9.0),
      height: 150,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.background,
          ],
          begin: Alignment.centerLeft,
        ),
        borderRadius: BorderRadius.circular(15.0),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            textAlign: TextAlign.center,
            title,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Text(
            textAlign: TextAlign.center,
            subTitle,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: TextButton.icon(
              onPressed: onTap,
              icon: Icon(
                Icons.arrow_forward,
                size: 22,
                color: Theme.of(context).colorScheme.primary,
              ),
              style: const ButtonStyle(
                alignment: Alignment.centerRight,
              ),
              label: Text(
                bouttmText,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
