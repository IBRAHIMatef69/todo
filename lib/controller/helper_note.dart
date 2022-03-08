import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import 'package:todo/model/todo_model.dart';

class Note {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDB();
      return _db;
    } else {
      return _db;
    }
  }

  initialDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "tododb.db");
    var myDb = await openDatabase(path, version: 8, onCreate: _onCreate);
    return myDb;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE todo1(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, description TEXT NOT NULL,title TEXT NOT NULL,date TEXT NOT NULL,done TEXT NOT NULL )');
  }

  Future<int> insertdb(Map<String, dynamic> data) async {
    Database? db_Clint = await db;
    var result = db_Clint!.insert('todo1', data);
    return result;
  }

  Future<int> deletedb(int id) async {
    Database? db_Clint = await db;
    var result = db_Clint!.rawUpdate('DELETE FROM todo1 WHERE id="$id"');
    return result;
  }

  Future<int> Updatedb(String description, int id) async {
    Database? db_Clint = await db;
    var result = db_Clint!.rawUpdate(
        'UPDATE todo1 SET description="description" WHERE id ="$id"');
    return result;
  }

  Future<List<TodoModel>> getdb() async {
    List<TodoModel> list = [];
    Database? db_Clint = await db;
    var result = await db_Clint!.query('todo1');
    for (var i in result) {
      list.add(
        TodoModel(
            id: i["id"],
            description: i["description"],
            title: i["title"],
            date: i["date"],
            done: i["done"]),
      );
    }
    return list;
  }

  Future<int> updateCheck(String done, int id) async {
    Database? db_Clint = await db;
    var result = await db_Clint!.rawUpdate(
      'UPDATE todo1 SET done = ? WHERE id = ?',
      ['$done', id],
    );

    return result;
  }
}
