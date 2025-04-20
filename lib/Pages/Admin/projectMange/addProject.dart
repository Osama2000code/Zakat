import 'package:flutter/material.dart';
import 'package:zakat_app/Components/my_TextField.dart';

class AddProject extends StatefulWidget {
  const AddProject({super.key});

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  TextEditingController projectNameController = TextEditingController(); //
  TextEditingController projectDescriptionController =
      TextEditingController(); //
  TextEditingController projectImageController = TextEditingController(); //
  TextEditingController projectTargetAmountController =
      TextEditingController(); //
  TextEditingController projectTargetRaisedController =
      TextEditingController(); //
  TextEditingController projectStartDateController = TextEditingController();
  TextEditingController projectEndDateController = TextEditingController(); //
  TextEditingController projectStatusController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("انشاء مشروع "),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.inverseSurface,
      ),
      body: ListView(
        children: [
          MyTextField(
            icon: Icons.pan_tool_outlined,
            textInputType: TextInputType.text,
            obscureText: false,
            controller: projectNameController,
            label: "Project Name",
          ),
          MyTextField(
            icon: Icons.pan_tool_outlined,
            textInputType: TextInputType.text,
            obscureText: false,
            controller: projectDescriptionController,
            label: "Project Description",
          ),
          MyTextField(
            icon: Icons.monetization_on_sharp,
            textInputType: TextInputType.text,
            obscureText: false,
            controller: projectTargetAmountController,
            label: "Project Target Amount",
          ),
          MyTextField(
            icon: Icons.pan_tool_outlined,
            textInputType: TextInputType.text,
            obscureText: false,
            controller: projectEndDateController,
            label: "Project End Date",
          ),
          MyTextField(
            icon: Icons.pan_tool_outlined,
            textInputType: TextInputType.text,
            obscureText: false,
            controller: projectImageController,
            label: "Project Image",
          ),
        ],
      ),
    );
  }
}
