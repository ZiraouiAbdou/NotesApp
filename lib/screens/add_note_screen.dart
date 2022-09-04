// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:notes_app/provider.dart';
import 'package:notes_app/utils/colors.dart';
import 'package:notes_app/utils/styles.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = new TextEditingController();
    TextEditingController descriptionController = new TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                InkWell(
                    onTap: (() => Navigator.pop(context)),
                    child: Row(
                      children: const [
                        Text(
                          "Cancel",
                          style: TextStyle(fontSize: 25),
                        ),
                        Icon(
                          Icons.cancel,
                          size: 30,
                          color: AppColors.blueColor,
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      hintText: "title:",
                      hintMaxLines: 5),
                  style: titleStyle,
                ),
                const SizedBox(
                  height: 20,
                ),
                // ignore: prefer_const_constructors
                TextField(
                  controller: descriptionController,
                  textAlign: TextAlign.start,
                  minLines: 24,
                  maxLines: 24,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      hintText: "description",
                      hintStyle: TextStyle()),
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer<NoteData>(
                  builder: (BuildContext context, data, Widget? child) {
                    return InkWell(
                        onTap: (() {
                          data.addNote(titleController, descriptionController);
                          Navigator.pop(context);
                        }),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: BorderRadius.circular(23),
                          ),
                          child: Center(
                            child: Text(
                              "Add Note",
                              style: addNoteStyle,
                            ),
                          ),
                        ));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
