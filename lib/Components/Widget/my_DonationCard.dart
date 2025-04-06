import 'package:flutter/material.dart';

class MyDonationCard extends StatelessWidget {
  final String title;
  final String raisedAmount;
  final int daysLeft;
  final double progress;

  const MyDonationCard({
    super.key,
    required this.title,
    required this.raisedAmount,
    required this.daysLeft,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      // margin: const EdgeInsets.all(5.0),
      // height: 100,
      // width: 180,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.inversePrimary,
            blurRadius: 5,
          ),
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        ),
      ),
      width: 250,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              "assets/images/First-Logog-In-Login-Ragster.jpg",
              fit: BoxFit.cover,
              height: 40,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Raised: $raisedAmount',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 5,
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 8),
                Text(
                  'Days left: $daysLeft',
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
