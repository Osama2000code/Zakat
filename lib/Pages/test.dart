import 'package:flutter/material.dart';
import 'package:zakat_app/Components/Widget/my_DonationGrid.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text"),
      ),
      body: const MyDonationGrid(),
    );
  }
}
