import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zakat_app/Components/Widget/my_ImagePicerBoutton.dart';
import 'package:zakat_app/Components/my_Button.dart';
import 'package:zakat_app/Components/my_TextField.dart';
import 'package:zakat_app/DataBase/Helpers/dbConnction.dart';
import 'package:zakat_app/DataBase/Models/projects%20_Model.dart';

class AddProject extends StatefulWidget {
  const AddProject({super.key});

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  DBMatser db = DBMatser();
  late Uint8List? projectImageGallery = null;
  TextEditingController projectNameController = TextEditingController(); //
  TextEditingController projectDescriptionController =
      TextEditingController(); //
  TextEditingController projectImageController = TextEditingController(); //
  TextEditingController projectTargetAmountController =
      TextEditingController(); //
  TextEditingController projectTargetRaisedController =
      TextEditingController(); //
  TextEditingController projectStatusController = TextEditingController();
  DateTime projectEndDate = DateTime.now();
  DateTime projectStartdDate = DateTime.now();
  final imagePicker = ImagePicker();
// To Load Image From Gallery
  Future<Uint8List?> uploadImageFromGallery() async {
    final imagePicker =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicker != null) {
      return await XFile(imagePicker.path).readAsBytes();
    }
    return null;
  }

//To Add InTo DataBase
  saveData() async {
    ProjectModel projectmodel = ProjectModel(
      projectID: null,
      projectName: projectNameController.text,
      projectDescription: projectDescriptionController.text,
      projectTargetAmount: projectTargetAmountController.text,
      projectTargetRaised: projectTargetRaisedController.text,
      projectStartDate: projectStartdDate.toString(),
      projectEndDate: projectEndDate.toString(),
      projectStatus: "p",
      projectImage: projectImageGallery,
    );
    if (projectEndDate != DateTime.now()) {
      int res = await db.saveprojects(projectmodel);
      print(res);
      print(projectmodel.toMap());
      if (res > 0) {
        showSnak("تمتة العملية ");

        Navigator.pop(context);
      } else {
        showSnak("خطاء");
      }
    }
  }

  showSnak(String ms) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ms == "خطاء " ? Colors.red : Colors.green,
        content: Text(
          textAlign: TextAlign.center,
          ms,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

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
            icon: Icons.description,
            textInputType: TextInputType.text,
            obscureText: false,
            controller: projectDescriptionController,
            label: "Project Description",
          ),
          MyTextField(
            icon: Icons.monetization_on_sharp,
            textInputType: TextInputType.number,
            obscureText: false,
            controller: projectTargetAmountController,
            label: "Project Target Amount",
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            height: 90,
            width: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("اختار متى ينتهي المشروع"),
                  TextButton(
                    onPressed: () async {
                      final DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: projectStartdDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(3000),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          projectEndDate = selectedDate;
                        });
                        print(projectEndDate);
                      }
                    },
                    child: Text(
                      "${projectEndDate.year} -- ${projectEndDate.month} -- ${projectEndDate.day}",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: projectImageGallery == null
                ? Text("No image Selected ")
                : Image.memory(
                    projectImageGallery!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.fill,
                  ),
          ),
          MyImagePicerBoutton(
            pickImageGlareyAction: () async {
              projectImageGallery = await uploadImageFromGallery();
              setState(() {});
            },
          ),
          SizedBox(
            height: 25,
          ),
          MyButton(
            label: "Save Date",
            onTap: () async {
              // print("${projectEndDate} \n ${projectImageGallery}");
              saveData();
            },
          )
        ],
      ),
    );
  }
}
