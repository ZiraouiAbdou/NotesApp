// ignore_for_file: unnecessary_new

import 'package:flutter/cupertino.dart';
import 'package:notes_app/databse/notes_db.dart';
import '../databse/db_helper.dart';

class NoteData extends ChangeNotifier {
  NotesDatabase myDB = new NotesDatabase();
  late int len;
  Future<List<Map<dynamic, dynamic>>> readData() async {
    List<Map<dynamic, dynamic>> results =
        await myDB.readData("SELECT * FROM ${ColumnNotes.tableName}");
    len = results.length;
    notifyListeners();
    return results;
  }

  Future<List<Map<dynamic, dynamic>>> readDataRow(int id) async {
    List<Map> result = await myDB
        .readData("SELECT * FROM ${ColumnNotes.tableName} WHERE _id=$id");
    Map<String, Object?> mp = {"title": "N/A", "description": "N/A"};
    /* Database usually returns an immutable data so we had to make another list that contains 
    the data from the DB in addition to an empty map because without doing so, the futurebuilder
    in the note_screen will cause an error when a note is deleted
    */

    List<Map> finalResult = [...result, mp];
    return finalResult;
  }

  Future<List<Map<dynamic, dynamic>>> readDataSortedByDate() async {
    List<Map<dynamic, dynamic>> results = await myDB
        .readData("SELECT * FROM ${ColumnNotes.tableName} ORDER BY date ASC");
    len = results.length;
    notifyListeners();
    return results;
  }

  Future<int> updateNote(
      String title, String description, int date, int id) async {
    int response = await myDB.updateData("""
           UPDATE  ${ColumnNotes.tableName}
           SET ${ColumnNotes.titleColumn}="$title",
               ${ColumnNotes.descriptionColumn}="$description",
               ${ColumnNotes.dateColumn}="$date"
           WHERE (_id="$id");
           """);
    print(response);
    notifyListeners();
    return response;
  }

  Future<int> deleteNote(int id) async {
    int response = await myDB.deleteData("""DELETE FROM ${ColumnNotes.tableName}
                               WHERE _id=$id
                    """);
    notifyListeners();
    return response;
  }

  Future<int> insertNote(String title, String description, int date) async {
    int response = await myDB.insertData("""
                            INSERT INTO ${ColumnNotes.tableName}
                            (
                              ${ColumnNotes.titleColumn},${ColumnNotes.descriptionColumn},${ColumnNotes.dateColumn}
                              )
                            VALUES (
                             "$title","$description","$date"
                            )
                            """);
    print(response);
    return response;
  }

  // DROPDOWN BUTTON
  final List menuItems = ["Default", "Sort by Date"];
  String selectedItem = "Default";
  void changeSelectedItem(String? item) {
    selectedItem = item!;
    notifyListeners();
  }

  //

}
