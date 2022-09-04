import 'package:flutter/cupertino.dart';
import 'package:notes_app/models/note.dart';

class NoteData extends ChangeNotifier {
  List<Note> notes = [
    Note(
        title: "Sample",
        description:
            "lorem ipsum dsf lorem ipsum lorem ipsum lorem ipsum dsf lorem ipsum lorem ipsum lorem ipsum dsf lorem ipsum lorem ipsum lorem ipsum dsf lorem ipsum lorem ipsum lorem ipsum lorem ipsumlorem ipsumlorem ipsumlorem ipsum lorem ipsumlorem ipsum lorem ipsumlorem ipsum ",
        noteNumber: 1),
    Note(
        title: "Note",
        description:
            "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsumlorem ipsumlorem ipsumlorem ipsum lorem ipsumlorem ipsum lorem ipsumlorem ipsum ",
        noteNumber: 2),
    Note(
        title: "Night homework",
        description:
            "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsumlorem ipsumlorem ipsumlorem ipsum lorem ipsumlorem ipsum lorem ipsumlorem ipsum ",
        noteNumber: 3),
    Note(
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
  void addNote(TextEditingController title, TextEditingController description) {
    notes.add(Note(
        title: title.text,
        description: description.text,
        noteNumber: getIndex + 1));
    notifyListeners();
  }

  void deleteNote(int index) {
    notes.removeAt(index);
    notifyListeners();
  }
}
