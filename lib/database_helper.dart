import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'login.db');

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS login_credentials (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        password TEXT
      )
    ''');
  }

  Future<int> insertLoginCredentials(String username, String password) async {
    final db = await database;
    return await db!.insert('login_credentials', {
      'username': username,
      'password': password,
    });
  }

  Future<List<Map<String, dynamic>>> getAllLoginCredentials() async {
    final db = await database;
    return await db!.query('login_credentials');
  }

  Future<void> deleteAllLoginCredentials() async {
    final db = await database;
    await db!.delete('login_credentials');
  }

  Future<void> setLoginCredentials(String username, String password) async {
  final db = await database;
  await db?.insert(
    'login_credentials',
    {'username': username, 'password': password},
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
}
