import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zakat_app/Components/my_Button.dart';
import 'package:zakat_app/Components/my_TextField.dart';
import 'package:zakat_app/DataBase/Helpers/dbConnction.dart';
import 'package:zakat_app/DataBase/Models/users_model.dart';
import 'package:zakat_app/Services/user_provider.dart';
import 'package:zakat_app/app.dart';

class EditUser extends StatefulWidget {
  late UsersModel? usersModel;
  EditUser({
    super.key,
    this.usersModel,
  });

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  late var db;
  late UsersModel updatedUser;
  int res = 0;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  Future<void> _updatedData(int? userId) async {
    updatedUser = UsersModel(
        id: userId,
        username: username.text,
        password: password.text,
        email: email.text,
        phone: phone.text,
        image: 'N',
        role: "0");
    res = await db.updataUser(updatedUser);
    if (res == 0) {
      showSnak("خطاء");
    }
  }

  showSnak(String ms) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ms == "خطاء " ? Colors.red : Colors.green,
        content: Text(
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
  void initState() {
    db = DBMatser();
    username.text = widget.usersModel!.username;
    password.text = widget.usersModel!.password;
    email.text = widget.usersModel!.email;
    phone.text = widget.usersModel!.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.currentUser;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.inverseSurface,
        title: Text(
          "تعديل البيانات الشخصية  ",
          style: TextStyle(color: Theme.of(context).colorScheme.inverseSurface),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(height: 8),
                Text(
                  user!.username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: Column(
                    children: [
                      MyTextField(
                        icon: Icons.person,
                        textInputType: TextInputType.text,
                        obscureText: false,
                        controller: username,
                        label: "Username",
                      ),
                      MyTextField(
                        icon: Icons.key,
                        textInputType: TextInputType.text,
                        obscureText: true,
                        controller: password,
                        label: "Password",
                      ),
                      MyTextField(
                        icon: Icons.phone,
                        textInputType: TextInputType.number,
                        obscureText: false,
                        controller: phone,
                        label: "phone",
                      ),
                      MyTextField(
                        icon: Icons.email,
                        textInputType: TextInputType.emailAddress,
                        obscureText: false,
                        controller: email,
                        label: "Email",
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          MyButton(
            label: "حفظ البيانات ",
            onTap: () async {
              await Future.delayed(
                Duration(seconds: 1),
                () {
                  showSnak('تمت العملية ');
                  _updatedData(widget.usersModel!.id);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => App(),
                      ));
                },
              );
              // After Data Updated Stor In User Sesstion Proveder
              userProvider.setUser(updatedUser);
            },
          )
        ],
      ),
    );
  }
}
