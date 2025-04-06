import 'package:flutter/material.dart';
import 'package:zakat_app/Components/my_Button.dart';
import 'package:zakat_app/Components/my_TextField.dart';
import 'package:zakat_app/Pages/Auth/Ragster.dart';
import 'package:zakat_app/app.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void login() {
    // Auth Code

    //nav
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const App(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: [
          // Image Logog
          Container(
            padding: const EdgeInsets.only(top: 10.0),
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

          //textfild -1
          MyTextField(
            textInputType: TextInputType.text,
            controller: phoneNumber,
            label: "Phone Number",
            obscureText: false,
            icon: Icons.person,
          ),
          //textfild -2
          MyTextField(
            textInputType: TextInputType.text,
            icon: Icons.key,
            controller: password,
            label: "Password",
            obscureText: true,
          ),
          const SizedBox(
            height: 18.0,
          ),
          // MyBouttom
          MyButton(
            label: "تسجيل الدخول ",
            onTap: login,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You Have not Acounnt ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                TextButton(
                  onPressed: (() => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RagsterPage(),
                        ),
                      )),
                  child: Text(
                    "Ragster Now ..",
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
