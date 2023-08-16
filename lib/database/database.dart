import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class SqliteDatabase {
  static Database? _db;
  static Map<int, String> scripts = {
    1: ''' CREATE TABLE pesquisas ( 
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      cep TEXT,
      logradouro TEXT,
      bairro TEXT,
      localidade TEXT,
      uf TEXT
      ) '''
  };

  static Future<Database> getDatabase() async {
    if (_db == null) {
      return await startDatabase();
    }
    return _db!;
  }

  static Future startDatabase() async {
    var db = await openDatabase(
        path.join(await getDatabasesPath(), 'database.db'),
        version: scripts.length, onCreate: (Database db, int version) async {
      for (var i = 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
        debugPrint(scripts[i]!);
      }
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      for (var i = oldVersion + 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
        debugPrint(scripts[i]!);
      }
    });
    return db;
  }
}
