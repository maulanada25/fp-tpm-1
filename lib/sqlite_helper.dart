import 'package:projecttpm/model_agents.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper{

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
      }
    );
  }

  //tambah data
  static Future<int> tambahUser(String username, String password) async {
    final db = await SQLHelper.db();
    final data = {'username': username, 'password': password};
    return await db.insert('user', data);
  }

  //ambil data
  static Future<List<Map<String, dynamic>>> getUser() async {
    final db = await SQLHelper.db();
    return db.query('user');
  }
}