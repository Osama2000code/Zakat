import 'package:flutter/material.dart';

class MyZkataIconButton extends StatelessWidget {
  final Icon icon;
  final String title;
  const MyZkataIconButton({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Theme.of(context).colorScheme.onBackground,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon:icon,
                           
                        ),
                        Text(
                        title,
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                        )
                      ],
                    ),
                  ),
                );
  }
}
