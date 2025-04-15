import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zakat_app/Components/my_Button.dart';
import 'package:zakat_app/Components/my_TextField.dart';
import 'package:zakat_app/DataBase/Helpers/dbConnction.dart';
import 'package:zakat_app/DataBase/Models/users_model.dart';
import 'package:zakat_app/Pages/Auth/Ragster.dart';
import 'package:zakat_app/Services/user_provider.dart';
import 'package:zakat_app/app.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  String _message = '';
  late bool checked = false;

  @override
  Future<List<Map>> readData() async {
    DBMatser db = DBMatser();
    List<Map> respones = await db.readData('Users');
    return respones;
  }

  void _checkUsers() async {
    DBMatser db = DBMatser();
    bool exists = await db.userExists(username.text, password.text);
    setState(() {
      checked = exists;
      _message = exists ? "user exists" : 'user is Not exists';
    });
  }

  cleartUser(BuildContext context) async {
    DBMatser db = DBMatser();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.clearUser();
  }

  void login() {
    // Auth Code
    _checkUsers();
    //nav
    if (checked) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const App(),
          ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_message),
          action: SnackBarAction(
            label: "Sing Up",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RagsterPage(),
                  ));
            },
          ),
        ),
      );
    }
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
            controller: username,
            label: "Username",
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
            onTap: () {
              setState(() {
                login();
              });
            },
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
