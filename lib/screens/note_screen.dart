import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/controller/db_controller.dart';
import 'package:notes_app/screens/edit_note_screen.dart';
import 'package:notes_app/utils/styles.dart';
import 'package:provider/provider.dart';

import '../databse/db_helper.dart';

class NoteScreen extends StatelessWidget {
  final Note note;
  const NoteScreen({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 40, 10, 15),
        child: SafeArea(
            child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: Consumer<NoteData>(builder: (context, value, child) {
              return FutureBuilder(
                  future: value.readDataRow(note.noteNumber),
                  builder: (context, AsyncSnapshot<List<Map>> snapshot) {
                    if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 25,
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  // note.title,
                                  snapshot.data!.first["title"] ?? "N/A",
                                  style: mainTitleStyle,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    print(snapshot.data!.first["_id"]);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditNoteScreen(note: note),
                                        ));
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 25,
                                  ),
                                  color: Colors.yellowAccent,
                                ),
                                IconButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    await value.deleteNote(note.noteNumber);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    size: 25,
                                  ),
                                  color: Colors.redAccent,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SelectableText(
                          snapshot.data!.first["description"] ?? "N/A",
                          // note.description,
                          style: mainDescriptionStyle,
                        ),
                      ],
                    );
                  });
            }),
          ),
        )),
      ),
    );
  }
}
