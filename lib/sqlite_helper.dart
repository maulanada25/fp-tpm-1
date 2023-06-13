import 'dart:convert';

import 'package:projecttpm/model_agents.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:crypto/crypto.dart';

  String enkripsi(String pw){
    var key = utf8.encode(pw);
    var digest = sha256.convert(key);
    return digest.toString();
  }
class SQLHelper {

  //buat database
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
    CREATE TABLE user(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      username TEXT,
      password TEXT
    )
    """);
  }


  static Future<sql.Database> db() async {
    return sql.openDatabase('user.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  //tambah data
  static Future<int> tambahUser(String username, String password) async {
    final db = await SQLHelper.db();
    String enkrip = enkripsi(password);
    print(enkrip);
    final data = {'username': username, 'password': enkrip};
    return await db.insert('user', data);
  }

  //ambil data
  static Future<List<Map<String, dynamic>>> getUser() async {
    final db = await SQLHelper.db();
    return db.query('user');
  }

  static Future<List<Map<String, dynamic>>> getUserByLogin(
      String username, String password) async {
    final db = await SQLHelper.db();
    String enkrip = enkripsi(password);
    return await db.query('user',
        where: "username = ? AND password = ?",
        whereArgs: [username, enkrip]);
  }
}
