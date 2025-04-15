import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zakat_app/Components/my_TextField.dart';
import 'package:zakat_app/DataBase/Helpers/dbConnction.dart';
import 'package:zakat_app/DataBase/Models/users_model.dart';
import 'package:zakat_app/Services/user_provider.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late Future<List<UsersModel>> userList;
  late UsersModel usersModell;
  TextEditingController testControler = TextEditingController();
  var dbHelper;
  DBMatser db = DBMatser();

  @override
  void initState() {
    dbHelper = DBMatser();
    super.initState();

    reafr();
  }

  reafr() {
    setState(() {
      userList = db.getAllUsers();
    });
    print(userList);
    // db.updataData("Users", {"loggedIn": 1}, "id=3");
  }

  Future<List<Map>> readDAta() async {
    List<Map> respones = await db.readData('Users');
    return respones;
  }

  SingleChildScrollView listview(List<UsersModel> usersModel) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: const [
          DataColumn(
            label: Text("ID"),
          ),
          DataColumn(
            label: Text("Username"),
          ),
          DataColumn(
            label: Text("Role"),
          ),
        ],
        rows: usersModel
            .map(
              (element) => DataRow(
                cells: [
                  DataCell(
                    Text(element.id.toString()),
                  ),
                  DataCell(
                    Text(element.username),
                  ),
                  DataCell(
                    Text(element.role),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context,listen: true);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text"),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const TextButton(
                onPressed: null,
                child: Text("Read Data"),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("inseert Data"),
              ),
              const TextButton(
                onPressed: null,
                child: Text("delete Data"),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          MyTextField(
            controller: testControler,
            icon: Icons.textsms,
            label: "Test",
            obscureText: false,
            textInputType: TextInputType.text,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
            color: Colors.grey,
            child: FutureBuilder(
              future: readDAta(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data![index];
                      return ListTile(
                        title: Text(item['username'].toString()),
                        subtitle: Text(item['email'].toString()),
                        leading: Text(item['id'].toString()),
                      );
                    },
                  );
                } else {
                  return const Text("No DAta");
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            color: Colors.white,
            height: 200,
            child: FutureBuilder(
              future: userList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return listview(snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
