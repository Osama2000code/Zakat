import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zakat_app/Components/my_Button.dart';
import 'package:zakat_app/Components/my_TextField.dart';
import 'package:zakat_app/DataBase/Helpers/dbConnction.dart';
import 'package:zakat_app/DataBase/Models/payment_model.dart';

class AddPayment extends StatefulWidget {
  const AddPayment({super.key});

  @override
  State<AddPayment> createState() => _AddPaymentState();
}

class _AddPaymentState extends State<AddPayment> {
  late Uint8List? payMentImageGallery = null;
  DateTime paymentDate = DateTime.now();
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

  saveDate() async {
    DBMatser db = DBMatser();
    PaymentModel paymentModel = PaymentModel(
      paymentDate: paymentDate.toString(),
      paymentName: _payName.text,
      paymentImage: payMentImageGallery,
      userID: null,
    );
    int res = await db.savaPayment(paymentModel);
    if (res > 0) {
      showSnak("تمتة العملية ");
      Navigator.pop(context);
    } else {
      showSnak("خطاء");
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

  TextEditingController _payName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.inverseSurface,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text("Add Payment"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            MyTextField(
              icon: Icons.payment,
              textInputType: TextInputType.text,
              obscureText: false,
              controller: _payName,
              label: "اسم المحفظة ",
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: GestureDetector(
                onTap: () async {
                  payMentImageGallery = await uploadImageFromGallery();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("ارفع صورة للمحفطة "),
                    Icon(
                      Icons.payment_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            MyButton(
              label: "Save",
              onTap: () {
                saveDate();
              },
            )
          ],
        ),
      ),
    );
  }
}
