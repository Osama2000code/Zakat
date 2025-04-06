import 'package:flutter/material.dart';

class MyCustomCardInfo extends StatelessWidget {
  final Widget subTitle;
  final Widget mainTitle;
  final IconData leftIcon;
  final IconData rghteIcon;
  final Color? backRoundColor;
  const MyCustomCardInfo({
    super.key,
    required this.backRoundColor,
    required this.leftIcon,
    required this.mainTitle,
    required this.rghteIcon,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: backRoundColor,
      ),
      // Coustm Card Info
      child: Row(
        children: [
          // Icon Part
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              leftIcon,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          // Acount Infoo
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: mainTitle,
              ),
              Expanded(
                child: subTitle,
              ),
            ],
          ),
          // Add icons
          const Spacer(),
          IconButton(
              onPressed: null,
              icon: Icon(
                rghteIcon,
                color: Theme.of(context).colorScheme.primary,
                size: 30,
              ))
        ],
      ),
    );
  }
}
