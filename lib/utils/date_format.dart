import 'package:intl/intl.dart';

class MyDateFormat {
  static String dateFormat(DateTime date) {
    return DateFormat('MMM/d/yyyy').format(date);
  }
}
