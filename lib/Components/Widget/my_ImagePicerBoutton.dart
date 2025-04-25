import 'package:flutter/material.dart';

class MyImagePicerBoutton extends StatelessWidget {
  final Function()? pickImageGlareyAction;
  const MyImagePicerBoutton({
    super.key,
    required this.pickImageGlareyAction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 200,
              width: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onBackground,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    height: 2,
                    width: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Center(
                    child: Text("Pick Image From "),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: 150,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: IconButton(
                      onPressed: pickImageGlareyAction,
                      icon: Icon(
                        Icons.image,
                        color: Theme.of(context).colorScheme.primary,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.image,
                color: Theme.of(context).colorScheme.primary,
              ),
              Text("اختار صورة "),
            ],
          ),
        ),
      ),
    );
  }
}
