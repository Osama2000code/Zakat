import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zakat_app/Components/my_Button.dart';
import 'package:zakat_app/Components/my_TextField.dart';
import 'package:zakat_app/DataBase/Helpers/dbConnction.dart';
import 'package:zakat_app/DataBase/Models/users_model.dart';
import 'package:zakat_app/Services/user_provider.dart';

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
  DBMatser db = DBMatser();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  late UsersModel userUpdata = widget.usersModel!;
  void editUser() async {
    userUpdata = UsersModel(
      id: null,
      username: username.text,
      password: password.text,
      image: 'N',
      email: email.text,
      phone: phone.text,
      role: widget.usersModel!.role == '1' ? '1' : '0',
    );
    int res = await db.updataUser(userUpdata, widget.usersModel!.id);
    if (res > 0) {
      showAlert("Done");
      Future.delayed(
        const Duration(seconds: 2),
      );
      Navigator.pop(context);
    } else {
      showAlert("Erorr");
      Future.delayed(
        const Duration(seconds: 3),
      );
    }
  }

  showAlert(String ms) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(ms),
          content: Icon(
            Icons.done,
            size: 100,
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      },
    );
  }

  @override
  void initState() {
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
                        label: "Emial",
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      RadioListTile(
                        title: const Text("User Is USER"),
                        subtitle: Text(user.role),
                        selected: user.role == '0' ? true : false,
                        value: '0',
                        groupValue: user.role,
                        onChanged: (value) {
                          setState(() {
                            user.role = value!;
                          });
                        },
                      ),
                      RadioListTile(
                        title: const Text("User Is Admin"),
                        subtitle: Text(user.role),
                        selected: user.role == '1' ? true : false,
                        value: '1',
                        groupValue: user.role,
                        onChanged: (value) {
                          setState(() {
                            user.role = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          MyButton(
            label: "حفظ البيانات ",
            onTap: () async {
              // print(widget.usersModel!.id);

              print(userUpdata.toMAp());

              // editUser();
              setState(() {
                editUser();
              });
            },
          )
        ],
      ),
    );
  }
}
