import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/controller/db_controller.dart';
import 'package:notes_app/screens/note_screen.dart';
import 'package:notes_app/utils/colors.dart';
import 'package:notes_app/utils/date_format.dart';
import 'package:notes_app/utils/styles.dart';
import 'package:provider/provider.dart';

class NoteWidget extends StatelessWidget {
  final bool isLong;
  final Note currentNote;
  const NoteWidget({Key? key, required this.currentNote, required this.isLong})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(context, MaterialPageRoute(builder: ((context) {
          return NoteScreen(
            note: currentNote,
          );
        })));
      }),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
            // color: Color(0xffA8D9FA),
            color: AppColors.lightYellow,
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
                    currentNote.title,
                    style: titleStyle,
                    maxLines: 2,
                  ),
                ),
                Text(
                  "${currentNote.printedID}",
                  style: counterStyle,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              currentNote.description,
              maxLines: isLong ? 7 : 4,
              style: descriptionStyle,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  MyDateFormat.dateFormat(currentNote.date),
                  textAlign: TextAlign.end,
                  style: dateStyle,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
