class ColumnNotes {
  static const String tableName = "notes";
  static const String idColumn = "_id";
  static const String titleColumn = "title";
  static const String descriptionColumn = "description";
  static const String dateColumn = "date";
}

class DatabaseTypes {
  static const String idType = "INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT";
  static const String stringType = "TEXT NOT NULL";
  static const String dateType = "TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP";
  static const String boolType = "BOOLEAN NOT NULL";
  static const String integerType = "INTEGER NOT NULL";
}
