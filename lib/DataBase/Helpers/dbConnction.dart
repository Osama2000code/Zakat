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
      $columnRole TEXT DEFAULT 'USER'
  );

    """);
    print("DataBasw Created--------------------------------------------");
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("DATABASE Upgraded  ---------------\n");
  }

  readData(String table) async {
    Database? mydb = await db;
    Future<List<Map>> respones = mydb!.query(table);
    return respones;
  }

  // Insert Data Function
  insertData(String table, Map<String, Object?> values) async {
    Database? mydb = await db;
    Future<int> respones = mydb!.insert(table, values);
    return respones;
  }

  // UpData Data Function
  updataData(String table, Map<String, Object?> values, String? where) async {
    Database? mydb = await db;
    Future<int> respones = mydb!.update(table, values, where: where);
    return respones;
  }

  // Delete Data Function
  deleteData(String table, String? where) async {
    Database? mydb = await db;
    Future<int> respones = mydb!.delete(table, where: where);
    return respones;
  }

// Insert Users
  Future<UsersModel> savaUser(UsersModel usersModel) async {
    Database? mydb = await db;
    usersModel.id = await mydb!.insert(tableName, usersModel.toMAp());
    await mydb.transaction((txn) async {
      var sql = '''
          INSERT INTO $tableName 
          (
          $columnUsername,
          $columnPassword,
          $columnEmail,
          $columnPhone,
          $columnRole
          )
          VALUES
          (
          "${usersModel.username}",
          "${usersModel.password}",
          "${usersModel.email}",
          "${usersModel.phone}",
          "${usersModel.role}"
          );
          ''';
      return await txn.rawInsert(sql);
    });
    return usersModel;
  }

// Updata Users
  Future<int> updataUser(UsersModel usersModel) async {
    Database? mydb = await db;
    return await mydb!.update(tableName, usersModel.toMAp(),
        where: '$columnID=?', whereArgs: [usersModel.id]);
  }

// Delete Users
  Future<int> deleteUser(UsersModel usersModel) async {
    Database? mydb = await db;
    return await mydb!
        .delete(tableName, where: '$columnID=?', whereArgs: [usersModel.id]);
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
      ],
    );
    if (maps.isNotEmpty) {
      for (var element in maps) {
        usersList.add(UsersModel.fromMap(element));
      }
    }
    return usersList;
  }

// Get User Aftoer Logined in
  Future<UsersModel?> getUser(int id) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> maps =
        await mydb!.query(tableName, where: "$columnID=?", whereArgs: [id]);
    if (maps.isNotEmpty) {
      return UsersModel.fromMap(maps.first);
    }
    return null;
  }

// User Exists Function
  Future<bool> userExists(String username, String password) async {
    Database? mydb = await db;
    final res = await mydb!.query(tableName,
        where: '$columnUsername LIKE ? AND $columnPassword LIKE  ?',
        whereArgs: [
          username,
          password,
        ]);
    return res.isNotEmpty;
  }
}
