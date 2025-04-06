import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final IconData icon;
  final TextInputType textInputType;
  final TextEditingController controller;

  const MyTextField({
    super.key,
    required this.icon,
    required this.textInputType,
    required this.obscureText,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: FormBuilderTextField(
        name: label,
        controller: controller,
        obscureText: obscureText,
        keyboardType: textInputType,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary, width: 5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.secondary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.secondary),
          ),
          label: Text(
            label,
          ),
          prefixIcon: Icon(
            icon,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }
}
