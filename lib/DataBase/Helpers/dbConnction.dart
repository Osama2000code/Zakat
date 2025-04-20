import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:zakat_app/DataBase/Models/users_model.dart';

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
      $columnImage TEXT DEFAULT 'N',
      $columnRole TEXT DEFAULT '0'
  );

    """);
    await db.execute("""
    CREATE TABLE projects (
    project_id INTEGER PRIMARY KEY AUTOINCREMENT,
    project_name TEXT NOT NULL,
    project_description TEXT,
    project_image TEXT,
    project_arget_amount TEXT,
    project_target_raised TEXT,
    project_start_date TEXT,
    project_end_date TEXT,
    project_status TEXT DEFAULT 'pending'
);

 

    """);
    await db.execute("""
 
CREATE TABLE applicants (
    applicants_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    applicants_name TEXT NOT NULL,
    user_national_id TEXT UNIQUE NOT NULL,
    user_address TEXT,
    user_phone TEXT,
    user_email TEXT,
    application_date TEXT,
    applicants_status TEXT DEFAULT 'p',
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
  Future<int> updataUser(UsersModel usersModel ) async {
    Database? mydb = await db;
    return  mydb!.update(
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
}
