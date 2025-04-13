import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:zakat_app/Components/my_Button.dart';
import 'package:zakat_app/Components/my_TextField.dart';
import 'package:zakat_app/DataBase/Helpers/DBConnction.dart';
import 'package:zakat_app/DataBase/Models/users_model.dart';
import 'package:zakat_app/Pages/Auth/Login.dart';

// class RagsterPage extends StatefulWidget {
//   const RagsterPage({super.key});

//   @override
//   State<RagsterPage> createState() => _RagsterPageState();
// }

// class _RagsterPageState extends State<RagsterPage> {
//   TextEditingController phoneNmuber = TextEditingController();
//   TextEditingController password = TextEditingController();
//   TextEditingController conformPassword = TextEditingController();

//   void ragster() {
// // Auth Code

// // Nav
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const HomePage(),
//         ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       body: Container(
//         padding: const EdgeInsets.all(15),
//         margin: const EdgeInsets.all(7),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Image Logog
//             ClipRRect(
//               borderRadius: BorderRadius.circular(6.0),
//               child: Image.asset(
//                 "assets/images/First-Logog-In-Login-Ragster.jpg",
//                 height: 150,
//                 width: 150,
//               ),
//             ),

//             MyTextField(
//               controller: phoneNmuber,
//               label: "Phone Number",
//               obscureText: false,
//               icon: Icons.person,
//             ),
//             //textfild -2
//             MyTextField(
//               icon: Icons.key,
//               controller: password,
//               label: "Password",
//               obscureText: true,
//             ),
//             //textfild -1

//             MyTextField(
//               icon: Icons.key,
//               controller: conformPassword,
//               label: "Conform Password",
//               obscureText: true,
//             ),
//             const SizedBox(
//               height: 22.0,
//             ),
//             // MyBouttom
//             MyButton(
//               label: "Ragster",
//               onTap: ragster,
//             ),
//             Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("You Have Orady Acounnt "),
//                   TextButton(
//                       onPressed: (() => Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const LoginPage(),
//                             ),
//                           )),
//                       child: Text(
//                         "Login Now ..",
//                         style: TextStyle(
//                           color: Theme.of(context).colorScheme.tertiary,
//                         ),
//                       ))
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
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
  bool isfound = false;

  void reagster() async {
    UsersModel usersModel = UsersModel(
      id: null,
      username: username.text,
      password: password.text,
      email: email.text,
      phone: phone.text,
      role: 'ADMIN',
    );
    isfound = await db.userExists(username.text, password.text);
    if (isfound) {
      print("It IS Founded\n\n\n");
    } else if (!isfound) {
      await db.savaUser(usersModel);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } else {
      print("Erorrrr-------------------------------------\n\n\n");
    }
    // int respones = await db.insertData('Users', {
    //   'username': username.text,
    //   'password': password.text,
    //   'email': email.text,
    //   'phone': phone.text,
    // });
    // if (respones > 0) {
    //   print("----------------------------------------------add");
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => const Test(),
    //       ));
    // } else {
    //   print("it Was Erorrr---------------------------------");
    // }
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
                  "You Have not Acounnt ",
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
