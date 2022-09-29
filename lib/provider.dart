import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/models/note.dart';

class NoteData extends ChangeNotifier {
  List<Note> notes = [
    Note(
        date: DateTime.now(),
        title: "Sample",
        description:
            "lorem ipsum dsf lorem ipsum lorem ipsum lorem ipsum dsf lorem ipsum lorem ipsum lorem ipsum dsf lorem ipsum lorem ipsum lorem ipsum dsf lorem ipsum lorem ipsum lorem ipsum lorem ipsumlorem ipsumlorem ipsumlorem ipsum lorem ipsumlorem ipsum lorem ipsumlorem ipsum ",
        noteNumber: 1),
    Note(
        date: DateTime.now(),
        title: "Note",
        description:
            "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsumlorem ipsumlorem ipsumlorem ipsum lorem ipsumlorem ipsum lorem ipsumlorem ipsum ",
        noteNumber: 2),
    Note(
        date: DateTime.now(),
        title: "Night homework",
        description:
            "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsumlorem ipsumlorem ipsumlorem ipsum lorem ipsumlorem ipsum lorem ipsumlorem ipsum ",
        noteNumber: 3),
    Note(
        date: DateTime.now(),
        title: "Lorem ipsum lorem lorem lorem",
        description:
            "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsumlorem ipsumlorem ipsumlorem ipsum lorem ipsumlorem ipsum lorem ipsumlorem ipsum ",
        noteNumber: 4)
  ];
  // bool adjuster(int index) {
  //   if (index % 4 == 0 || index % 4 == 3) {
  //     return true;
  //   }
  //   return false;
  // }

  get getIndex => notes.length;
  void addNote(TextEditingController title, TextEditingController description,
      DateTime time) {
    notes.add(Note(
        date: time,
        title: title.text,
        description: description.text,
        noteNumber: getIndex + 1));
    notifyListeners();
  }

  void deleteNote(int index) {
    notes.removeAt(index);
    notifyListeners();
  }

  String dateFormat(DateTime date) {
    return DateFormat.MEd().format(date);
  }
}
