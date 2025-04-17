import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:zakat_app/Components/my_Button.dart';
import 'package:zakat_app/Components/my_TextField.dart';
import 'package:zakat_app/DataBase/Helpers/DBConnction.dart';
import 'package:zakat_app/DataBase/Models/users_model.dart';
import 'package:zakat_app/Pages/Auth/Login.dart';

class RagsterPage extends StatefulWidget {
  const RagsterPage({super.key});

  @override
  State<RagsterPage> createState() => _RagsterPageState();
}

class _RagsterPageState extends State<RagsterPage> {
  final _formkey = GlobalKey<FormBuilderState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController conformPassword = TextEditingController();
  DBMatser db = DBMatser();
  String _message = '';
  String _messageEx = '';
  bool isfound = false;

  void reagster() async {
    UsersModel? usersModel = UsersModel(
      username: username.text,
      password: password.text,
      email: email.text,
      phone: phone.text,
      image: 'N',
      role: '0',
    );
    if (password.text == conformPassword.text) {
      UsersModel? ifuserFounded;
      ifuserFounded = await db.userIsExists(username.text, password.text);
      if (usersModel != ifuserFounded) {
        await db.savaUser(usersModel);
        isfound = true;
      } else {
        _messageEx = "موجود هاذا الحساب بل فعل ";
      }
    } else {
      _message = "لا يوجد تطابقفي كلمة المرور ";
    }
    if (isfound) {
      Navigator.push(context,
          MaterialPageRoute(builder: ((context) => const LoginPage())));
    } else {
      errorShow(_messageEx);
    }
  }

  errorShow(String me) {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(5.0),
          child: AlertDialog(
            title: const Text("تنبية"),
            content: Text(
              me,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            icon: const Icon(
              Icons.error,
              color: Colors.red,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 5.0),
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image.asset(
                "assets/images/logo.png",
                height: 150,
                width: 150,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SingleChildScrollView(
            child: FormBuilder(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    MyTextField(
                      textInputType: TextInputType.text,
                      icon: Icons.person,
                      obscureText: false,
                      controller: username,
                      label: "Username",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                      textInputType: TextInputType.emailAddress,
                      icon: Icons.email,
                      obscureText: false,
                      controller: email,
                      label: "Email ",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                      textInputType: TextInputType.phone,
                      icon: Icons.phone,
                      obscureText: false,
                      controller: phone,
                      label: "Phone Number",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                      textInputType: TextInputType.text,
                      icon: Icons.password,
                      obscureText: true,
                      controller: password,
                      label: " Password",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                      error: _message,
                      textInputType: TextInputType.text,
                      icon: Icons.check,
                      obscureText: true,
                      controller: conformPassword,
                      label: "Conform Password",
                    ),
                  ],
                ),
              ),
            ),
          ),
          MyButton(
            label: "تسجيل الدخول ",
            onTap: () {
              setState(() {
                reagster();
              });
            },
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "لدي حساب بلفعل  ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                TextButton(
                  onPressed: (() => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      )),
                  child: Text(
                    "من هنا ..",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
