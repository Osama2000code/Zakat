import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zakat_app/Components/my_Button.dart';
import 'package:zakat_app/Components/my_TextField.dart';
import 'package:zakat_app/DataBase/Helpers/dbConnction.dart';
import 'package:zakat_app/DataBase/Models/applicants_model.dart';
import 'package:zakat_app/DataBase/Models/users_model.dart';
import 'package:zakat_app/app.dart';

class AddApplicants extends StatefulWidget {
  final UsersModel user;
  const AddApplicants({super.key, required this.user});

  @override
  State<AddApplicants> createState() => _AddApplicantsState();
}

class _AddApplicantsState extends State<AddApplicants> {
  late Uint8List? userNationalImage = null;
  TextEditingController applicantsNameController = TextEditingController();
  TextEditingController applicantsDescriptionController =
      TextEditingController();
  TextEditingController userAddresController = TextEditingController();
  String applicantsDate =
      "${DateTime.now().month.toString()}--${DateTime.now().day.toString()}--${DateTime.now().year.toString()}";
  final imagePicker = ImagePicker();
// To Load Image From Gallery
  Future<Uint8List?> uploadImageFromCamera() async {
    final imagePicker =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imagePicker != null) {
      return await XFile(imagePicker.path).readAsBytes();
    }
    return null;
  }

  Future<void> inserttData() async {
    DBMatser db = DBMatser();
    ApplicantsModel applicantsModel = ApplicantsModel(
      userId: widget.user.id!,
      userAddres: userAddresController.text,
      userNationalImage: userNationalImage,
      applicantsDescription: applicantsDescriptionController.text,
      userPhone: widget.user.phone,
      applicantsName: applicantsNameController.text,
      applicantsDate: applicantsDate,
      applicantsStatus: 'p',
    );
    int res = await db.savaApplicants(applicantsModel);
    if (res > 0) {
      showSnak("تم أرسال ألطلب بنجاح");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => App(),
          ));
    } else {
      showSnak('خطاء');
    }
  }

  showSnak(String ms) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ms == "خطاء " ? Colors.red : Colors.green,
        content: Text(
          ms,
          textAlign: TextAlign.center,
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
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0.0,
        title: Text("تقديم الطلب "),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    width: 200,
                    height: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Text("معلومات الطلب  ")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: MyTextField(
                        icon: Icons.add,
                        textInputType: TextInputType.text,
                        obscureText: false,
                        controller: applicantsNameController,
                        label: "اسم  الطلب"),
                  ),
                  Expanded(
                    child: MyTextField(
                        icon: Icons.location_on_outlined,
                        textInputType: TextInputType.text,
                        obscureText: false,
                        controller: userAddresController,
                        label: "عنوان السكن "),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    width: 200,
                    height: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Text("معلومات شخصية ")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: userNationalImage == null
                        ? GestureDetector(
                            onLongPress: () async {
                              userNationalImage = await uploadImageFromCamera();
                              setState(() {});
                            },
                            child: Container(
                              height: 60,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.camera_alt_outlined,
                                    size: 25,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  Text("رفع البطاقة الشخصية "),
                                ],
                              ),
                            ),
                          )
                        : Center(
                            child: Image.memory(
                              userNationalImage!,
                              height: 80,
                              width: 80,
                              fit: BoxFit.fill,
                            ),
                          ),
                  ),
                  Expanded(
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.date_range_rounded,
                            size: 25,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          Text(
                              "${DateTime.now().month.toString()}--${DateTime.now().day.toString()}--${DateTime.now().year.toString()}"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              MyTextField(
                icon: Icons.description,
                textInputType: TextInputType.text,
                obscureText: false,
                maxHieght: 8,
                controller: applicantsDescriptionController,
                label: "اكتب الوصف ",
              ),
              SizedBox(
                height: 10,
              ),
              MyButton(
                label: "تقديم الطلب",
                onTap: () {
                  setState(() {
                    inserttData();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
