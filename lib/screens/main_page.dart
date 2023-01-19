// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/databse/notes_db.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/controller/db_controller.dart';
import 'package:notes_app/routes/app_routes.dart';
import 'package:notes_app/utils/colors.dart';
import 'package:notes_app/widgets/note_widget.dart';
import 'package:provider/provider.dart';

import '../databse/db_helper.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);
  final NotesDatabase myDB = new NotesDatabase();
  Future<List<Map<dynamic, dynamic>>> readData() async {
    var results = myDB.readData("SELECT * FROM ${ColumnNotes.tableName}");
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff333F46),
      appBar: AppBar(
          title: const Text(
        "My Notes",
        style: TextStyle(color: Colors.black),
      )),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder(
              future: context.watch<NoteData>().selectedItem == "Default"
                  ? context
                      .select<NoteData, Future<List<Map<dynamic, dynamic>>>>(
                          (value) => value.readData())
                  : context
                      .select<NoteData, Future<List<Map<dynamic, dynamic>>>>(
                          (value) => value.readDataSortedByDate()),
              builder: (context,
                  AsyncSnapshot<List<Map<dynamic, dynamic>>> snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text(
                    "No Notes Yet",
                    style: TextStyle(fontSize: 25, color: Colors.white70),
                  ));
                } else {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: SizedBox(
                            width: 200,
                            child: DropdownButtonFormField<String>(
                              dropdownColor: AppColors.mainColorTheme,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                              value: context.select<NoteData, String>(
                                  (value) => value.selectedItem),
                              items: context
                                  .read<NoteData>()
                                  .menuItems
                                  .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )))
                                  .toList(),
                              onChanged: (item) {
                                context.select<NoteData, void>(
                                    (value) => value.changeSelectedItem(item));
                              },
                            ),
                          ),
                        ),
                        GridView.custom(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverWovenGridDelegate.count(
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 0,
                              crossAxisCount: 2,
                              pattern: const [
                                WovenGridTile(4 / 6, crossAxisRatio: 0.9),
                                WovenGridTile(1),
                              ]),
                          childrenDelegate:
                              SliverChildBuilderDelegate((context, index) {
                            return NoteWidget(
                              currentNote: Note(
                                  title: snapshot.data![index]["title"],
                                  description: snapshot.data![index]
                                      ["description"],
                                  noteNumber: snapshot.data![index]["_id"],
                                  printedID: index + 1,
                                  date: DateTime.fromMillisecondsSinceEpoch(
                                      snapshot.data![index]["date"])),
                              //checking the container position to adjust the max lines of
                              //each container to avoid overflow
                              isLong: (index % 4 == 0 || index % 4 == 3),
                            );
                          }, childCount: context.watch<NoteData>().len),
                        ),
                      ],
                    ),
                  );
                }
              })),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        backgroundColor: AppColors.addNotePageColor,
        onPressed: () {
          Navigator.pushNamed(context, Routes.addNote);
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
