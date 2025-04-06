import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBMatser {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initial();
      return _db;
    } else {
      return _db;
    }
  }

  initial() async {
    String pathDatabase = await getDatabasesPath();
    String path = join(pathDatabase, 'ZakatDB.db');
    Database myDb = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE 'Users' (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT UNIQUE NOT NULL,
      password TEXT NOT NULL,
      email TEXT UNIQUE NOT NULL,
      phone TEXT,
      role TEXT DEFAULT 'user'
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
}
