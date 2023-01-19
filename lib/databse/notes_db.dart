import 'dart:async';

import 'package:path/path.dart' as pt;
import 'package:sqflite/sqflite.dart';

import 'db_helper.dart';

class NotesDatabase {
  static Database? _db;
  Future<Database?> get db async {
    _db ??= await initDatabse();
    return _db;
  }

  Future<Database> initDatabse() async {
    String path = pt.join(await getDatabasesPath(), "notes.db");
    Database myDB = await openDatabase(path, version: 1, onCreate: onCreateDB);
    return myDB;
  }

  Future<void> deleteDB() async {
    String path = pt.join(await getDatabasesPath(), "notes.db");
    await deleteDatabase(path);
  }

  Future<void> onCreateDB(Database db, int version) async {
    await db.execute("""
    CREATE TABLE ${ColumnNotes.tableName}(
      ${ColumnNotes.idColumn} ${DatabaseTypes.idType},
      ${ColumnNotes.titleColumn} ${DatabaseTypes.stringType},
      ${ColumnNotes.descriptionColumn} ${DatabaseTypes.stringType},
      ${ColumnNotes.dateColumn} ${DatabaseTypes.integerType}
        )
 """);
  }

  Future<List<Map>> readData(String sql) async {
    Database? myDB = await db;
    List<Map<String, Object?>> results = await myDB!.rawQuery(sql);
    return results;
  }

  Future<int> insertData(String sql) async {
    Database? myDB = await db;
    int results = await myDB!.rawInsert(sql);
    return results;
  }

  Future<int> updateData(String sql) async {
    Database? myDB = await db;
    int results = await myDB!.rawUpdate(sql);
    return results;
  }

  Future<int> deleteData(String sql) async {
    Database? myDB = await db;
    int results = await myDB!.rawDelete(sql);
    return results;
  }
}
