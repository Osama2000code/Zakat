import 'package:flutter/material.dart';
import 'package:zakat_app/Pages/Admin/projectMange/addProject.dart';

class ProjctsView extends StatefulWidget {
  const ProjctsView({super.key});

  @override
  State<ProjctsView> createState() => _ProjctsViewState();
}

class _ProjctsViewState extends State<ProjctsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("المشاريع "),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.inverseSurface,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddProject(),
              ));
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: Center(
        child: Text("لأا يودد حاليا ..."),
      ),
    );
  }
}
