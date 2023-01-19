import '../screens/add_note_screen.dart';
import '../screens/main_page.dart';

class Routes {
  static const String homePage = '/';
  static const String addNote = 'add_note';
  static const String deleteNote = 'delete_note';
  static const String editNote = 'edit_note';
}

final routes = {
  Routes.homePage: (context) => MainPage(),
  Routes.addNote: (context) => const AddNoteScreen(),
};
