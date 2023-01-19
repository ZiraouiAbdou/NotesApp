class Note {
  String title;
  String description;
  int noteNumber;
  DateTime date;
  int? printedID;
  Note(
      {required this.title,
      required this.description,
      required this.noteNumber,
      required this.date,
      this.printedID});
}
