import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:weight_tracker/models/user.dart';

class DBService {
  static final DBService _instance = new DBService.internal();

  factory DBService() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DBService.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'main.db');
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
      'CREATE TABLE User(id INTEGER PRIMARY KEY, name TEXT, age INTEGER, gender INTEGER, height REAL, targetWeight REAL, initialWeight REAL)',
    );
    print('[INFO] => DB => Tables created');
  }

  Future<int> saveUser(User user) async {
    final Database dbClient = await db;
    int res = await dbClient.insert('User', user.toMap());
    return res;
  }

  Future<bool> isLoggedIn() async {
    final Database dbClient = await db;
    final res = await dbClient.query('User');
    return res.length > 0 ? true : false;
  }

  Future<Map> currentUser() async {
    final Database dbClient = await db;
    final res = await dbClient.query('User');
    return res[0];
  }
}
