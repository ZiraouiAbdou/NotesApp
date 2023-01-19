import 'package:flutter/material.dart';
import 'package:notes_app/controller/db_controller.dart';
import 'package:notes_app/routes/app_routes.dart';
import 'package:notes_app/utils/colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => NoteData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: AppColors.mainColorTheme,
            primarySwatch: Colors.blue,
            appBarTheme:
                const AppBarTheme(backgroundColor: AppColors.addNotePageColor),
            iconTheme: const IconThemeData(color: Colors.white54)),
        routes: routes,
      ),
    );
  }
}
