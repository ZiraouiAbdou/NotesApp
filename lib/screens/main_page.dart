import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/provider.dart';
import 'package:notes_app/routes/app_routes.dart';
import 'package:notes_app/utils/colors.dart';
import 'package:notes_app/widgets/note_widget.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notes")),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Consumer<NoteData>(
            builder: (context, data, child) {
              if (data.notes.isEmpty) {
                return const Center(
                    child: Text(
                  "No Notes Yet",
                  style: TextStyle(fontSize: 25),
                ));
              } else {
                return GridView.custom(
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
                          title: data.notes[index].title,
                          description: data.notes[index].description,
                          noteNumber: index + 1,
                          date: data.notes[index].date),
                      //checking the container position to adjust the max lines of
                      //each container to avoid overflow
                      isLong: (index % 4 == 0 || index % 4 == 3),
                    );
                  }, childCount: data.notes.length),
                );
              }
            },
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.floatingActionButtonColor,
        onPressed: () {
          Navigator.pushNamed(context, Routes.addNote);
        },
        child: const Icon(Icons.add_comment_outlined),
      ),
    );
  }
}
