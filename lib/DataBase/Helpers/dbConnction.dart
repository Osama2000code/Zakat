import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:zakat_app/DataBase/Models/applicants_model.dart';
import 'package:zakat_app/DataBase/Models/payment_model.dart';
import 'package:zakat_app/DataBase/Models/projects%20_Model.dart';
import 'package:zakat_app/DataBase/Models/users_model.dart';
import 'package:zakat_app/DataBase/Models/zkata_model.dart';

class DBMatser {
  static Database? database;
  static const databaseName = 'ZakatDB.db';
  static const tableName = 'Users';
  static const columnID = 'id';
  static const columnUsername = 'username';
  static const columnPassword = 'password';
  static const columnImage = 'image';
  static const columnEmail = 'email';
  static const columnPhone = 'phone';
  static const columnRole = 'role';

  Future<Database?> get db async {
    if (database == null) {
      database = await initial();
      return database;
    } else {
      return database;
    }
  }

  initial() async {
    String pathDatabase = await getDatabasesPath();
    String path = join(pathDatabase, databaseName);
    Database mydb = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 2,
      onUpgrade: _onUpgrade,
    );
    return mydb;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE $tableName (
      $columnID INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnUsername TEXT UNIQUE NOT NULL,
      $columnPassword TEXT NOT NULL,
      $columnEmail TEXT UNIQUE NOT NULL,
      $columnPhone TEXT,
      $columnImage BLOB DEFAULT NULL,
      $columnRole TEXT DEFAULT '0'
  );

    """);
    await db.execute("""
    CREATE TABLE projects (
    project_id INTEGER PRIMARY KEY AUTOINCREMENT,
    project_name TEXT NOT NULL,
    project_description TEXT,
    project_image BLOB  DEFAULT NULL,
    project_arget_amount TEXT,
    project_target_raised TEXT,
    project_start_date TEXT,
    project_end_date TEXT,
    project_status TEXT DEFAULT 'p'
);

 

    """);
    await db.execute("""
CREATE TABLE applicants (
    applicants_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    applicants_name TEXT NOT NULL,
    user_national_Image BLOB  DEFAULT NULL,
    user_address TEXT,
    user_phone TEXT,
    user_email TEXT,
    application_date TEXT,
    applicants_status TEXT DEFAULT 'p',
    FOREIGN KEY (user_id) REFERENCES $tableName($columnID)
);

 

    """);
    await db.execute("""
CREATE TABLE zakat (
    zakat_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    zakat_detels TEXT NOT NULL,
    zakat_date TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES $tableName($columnID)
);
    """);
    await db.execute("""
    CREATE TABLE payment (
    payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    payment_Date TEXT NOT NULL,
    payment_Name TEXT NOT NULL,
    payment_Image BLOB  DEFAULT NULL,
    FOREIGN KEY (user_id) REFERENCES $tableName($columnID)
);
    """);
    print("DataBasw Created--------------------------------------------");
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("DATABASE Upgraded  ---------------\n");
  }

// Insert Users
  Future<int> savaUser(UsersModel usersModel) async {
    Database? mydb = await db;
    return await mydb!.insert(tableName, usersModel.toMAp());
  }

// Updata Users
  Future<int> updataUser(UsersModel usersModel) async {
    Database? mydb = await db;
    return mydb!.update(
      "Users",
      usersModel.toMAp(),
      where: 'id=?',
      whereArgs: [usersModel.id],
    );
  }

// Delete Users
  Future<int> deleteUser(UsersModel usersModel) async {
    Database? mydb = await db;
    return await mydb!
        .delete(tableName, where: 'id=?', whereArgs: [usersModel.id]);
  }

// Get All Users
  Future<List<UsersModel>> getAllUsers() async {
    Database? mydb = await db;
    List<UsersModel> usersList = [];
    List<Map<String, dynamic>> maps = await mydb!.query(
      tableName,
      columns: [
        columnID,
        columnUsername,
        columnPassword,
        columnEmail,
        columnPhone,
        columnRole,
        columnImage
      ],
    );
    if (maps.isNotEmpty) {
      for (var element in maps) {
        usersList.add(UsersModel.fromMap(element));
      }
    }
    return usersList;
  }

// get Admin in user
  Future<UsersModel?> getLoggedInUser() async {
    Database? mydb = await db;
    final List<Map<String, dynamic>> maps =
        await mydb!.query(tableName, where: "$columnRole= ?", limit: 1);
    if (maps.isNotEmpty) {
      return UsersModel.fromMap(maps.first);
    }
    return null;
  }

// Get User Aftoer Logined in
  Future<UsersModel?> getUser(int? id) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> maps =
        await mydb!.query(tableName, where: "$columnID=?", whereArgs: [id]);

    return maps.isNotEmpty ? UsersModel.fromMap(maps.first) : null;
  }

// User Exists Function
  Future<UsersModel?> userIsExists(String username, String password) async {
    Database? mydb = await db;
    final List<Map<String, dynamic>> maps = await mydb!.query(tableName,
        where: '$columnUsername = ? AND $columnPassword =  ?',
        whereArgs: [
          username,
          password,
        ]);
    return maps.isNotEmpty ? UsersModel.fromMap(maps.first) : null;
  }
  // =======================For project Functions============================

  // First Add project
  Future<int> saveprojects(ProjectModel projectModel) async {
    Database? mydb = await db;
    return await mydb!.insert(
      "projects",
      projectModel.toMap(),
    );
  }

  // Sava Chang updateProjectsMonay
  Future<int> updateProjectsMonay(String monay,int? id) async {
    Database? mydb = await db;
    return await mydb!.update('projects', {"project_target_raised": monay},
        where: 'project_id=$id');
  }

//  Update Projects
  Future<int> updateProjects(ProjectModel projectModel) async {
    Database? mydb = await db;
    return await mydb!.update(
      "projects",
      projectModel.toMap(),
      where: "project_id = ?",
      whereArgs: [projectModel.projectID],
    );
  }

// Delete Projects
  Future<int> deleteProjects(ProjectModel projectModel) async {
    Database? mydb = await db;
    return await mydb!.delete(
      "projects",
      where: "project_id=?",
      whereArgs: [projectModel.projectID],
    );
  }

// Get All Projects
  Future<List<ProjectModel>> getAllProjects() async {
    Database? mydb = await db;
    List<ProjectModel> projectsList = [];
    List<Map<String, dynamic>> maps = await mydb!.query("projects");
    if (maps.isNotEmpty) {
      for (var element in maps) {
        projectsList.add(ProjectModel.fromMap(element));
      }
    }
    return projectsList;
  }

  // =======================For Applicants Functions============================
  Future<int> savaApplicants(ApplicantsModel applicantsModel) async {
    Database? mydb = await db;
    return await mydb!.insert("applicants", applicantsModel.toMap());
  }

  Future<int> updataApplicants(ApplicantsModel applicantsModel) async {
    Database? mydb = await db;
    return await mydb!.update("applicants", applicantsModel.toMap(),
        where: 'applicants_id=?', whereArgs: [applicantsModel.applicantsID]);
  }

  Future<int> deleteApplicants(ApplicantsModel applicantsModel) async {
    Database? mydb = await db;
    return await mydb!.delete("applicants",
        where: 'applicants_id=?', whereArgs: [applicantsModel.applicantsID]);
  }

  Future<List<ApplicantsModel>> getAllApplicants() async {
    Database? mydb = await db;
    List<ApplicantsModel> applicantsList = [];
    List<Map<String, dynamic>> maps = await mydb!.query("applicants");
    if (maps.isNotEmpty) {
      for (var element in maps) {
        applicantsList.add(ApplicantsModel.fromMap(element));
      }
    }
    return applicantsList;
  }

  // =======================For Zakat Functions============================
  Future<int> savaZakat(ZakatModel zakatModel) async {
    Database? mydb = await db;
    return await mydb!.insert("zakat", zakatModel.toMap());
  }

  Future<int> updateZakat(ZakatModel zakatModel) async {
    Database? mydb = await db;
    return await mydb!.update("zakat", zakatModel.toMap(),
        where: 'zakat_id=/', whereArgs: [zakatModel.zakatID]);
  }

  Future<int> deleteZakat(ZakatModel zakatModel) async {
    Database? mydb = await db;
    return await mydb!
        .delete("zakat", where: 'zakat_id=/', whereArgs: [zakatModel.zakatID]);
  }

  Future<List<ZakatModel>> getAllZakat() async {
    Database? mydb = await db;
    List<ZakatModel> zakatList = [];
    List<Map<String, dynamic>> maps = await mydb!.query('zakat');
    if (maps.isNotEmpty)
      for (var element in maps) {
        zakatList.add(ZakatModel.fromMap(element));
      }
    return zakatList;
  }

  // =======================For pymatn Functions============================
  Future<int> savaPayment(PaymentModel paymentModel) async {
    Database? mydb = await db;
    return await mydb!.insert('payment', paymentModel.toMap());
  }

  Future<int> updataPayment(PaymentModel paymentModel) async {
    Database? mydb = await db;
    return await mydb!.update('payment', paymentModel.toMap(),
        where: 'payment_id=?', whereArgs: [paymentModel.payID]);
  }

  Future<int> deletePayment(PaymentModel paymentModel) async {
    Database? mydb = await db;
    return await mydb!.delete("payment",
        where: 'payment_id=?', whereArgs: [paymentModel.payID]);
  }

  Future<List<PaymentModel>> getAllPayment() async {
    Database? mydb = await db;
    List<PaymentModel> paymeList = [];
    List<Map<String, dynamic>> maps = await mydb!.query('payment');
    if (maps.isNotEmpty)
      for (var element in maps) {
        paymeList.add(PaymentModel.fromMap(element));
      }
    return paymeList;
  }
}
