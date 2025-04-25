import 'package:flutter/material.dart';
import 'package:zakat_app/Components/my_ButtonGride.dart';
import 'package:zakat_app/Pages/Admin/applicantsMange/index.dart';
import 'package:zakat_app/Pages/Admin/paymentMange/index.dart';
import 'package:zakat_app/Pages/Admin/projectMange/view.dart';
import 'package:zakat_app/Pages/Admin/usersMang/index.dart';
import 'package:zakat_app/Pages/Admin/zakatMange/index.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("DashBord"),
        centerTitle: true,
        elevation: 0.0,
        foregroundColor: Theme.of(context).colorScheme.inverseSurface,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(8.0),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
          ),
          children: [
            MyButtonGride(
              onTapB: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UsersViwe()));
              },
              title: "مستخدمين",
              iconB: Icons.verified_user_sharp,
            ),
            MyButtonGride(
              onTapB: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProjctsView()));
              },
              title: "انشاء مشروع",
              iconB: Icons.work_outline_sharp,
            ),
            MyButtonGride(
              onTapB: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewApplicants(),
                    ));
              },
              title: "الطلبات",
              iconB: Icons.people_alt_rounded,
            ),
            MyButtonGride(
              onTapB: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentView(),
                    ));
              },
              title: "المحافظ الاكترونية ",
              iconB: Icons.payment,
            ),
            MyButtonGride(
              onTapB: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ZakatAdminView(),
                    ));
              },
              title: "محصل الزكاة  ",
              iconB: Icons.mosque,
            ),
          ],
        ),
      ),
    );
  }
}
