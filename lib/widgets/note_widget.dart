import 'package:flutter/material.dart';
import 'package:notes_app/provider.dart';
import 'package:notes_app/screens/note_screen.dart';
import 'package:notes_app/utils/styles.dart';
import 'package:provider/provider.dart';

class NoteWidget extends StatelessWidget {
  String title, description;
  int noteNumber;
  bool isLong;
  var tapPosition;
  NoteWidget(
      {Key? key,
      required this.title,
      required this.description,
      required this.noteNumber,
      required this.isLong})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var overlay = Overlay.of(context)!.context.findRenderObject();
    return Consumer<NoteData>(
      builder: (BuildContext context, data, Widget? child) {
        return GestureDetector(
          onTap: (() {
            Navigator.push(context, MaterialPageRoute(builder: ((context) {
              return NoteScreen(title: title, descritpion: description);
            })));
          }),
          onTapDown: ((details) {
            tapPosition = details.globalPosition;
          }),
          onLongPress: (() {
            showMenu(
              context: context,
              position: RelativeRect.fromLTRB(
                tapPosition.dx,
                tapPosition.dy,
                overlay!.semanticBounds.size.width - tapPosition.dx,
                overlay.semanticBounds.size.height - tapPosition.dy,
              ),
              items: [
                PopupMenuItem(
                    value: noteNumber,
                    child: const Text(
                      "Delete",
                      style: TextStyle(fontSize: 20),
                    )),
              ],
            ).then((value) {
              if (value == null) return;
              data.deleteNote(noteNumber - 1);
            });
          }),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 5,
                      spreadRadius: 0,
                      offset: Offset(0, 0)),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: titleStyle,
                        maxLines: 2,
                      ),
                    ),
                    Text(
                      "$noteNumber",
                      style: counterStyle,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  description,
                  maxLines: isLong ? 8 : 5,
                  style: descriptionStyle,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
