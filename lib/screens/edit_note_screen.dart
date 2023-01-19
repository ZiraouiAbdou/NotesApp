// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';

import 'package:notes_app/models/note.dart';
import 'package:notes_app/controller/db_controller.dart';
import 'package:notes_app/utils/colors.dart';
import 'package:notes_app/utils/date_format.dart';
import 'package:notes_app/utils/styles.dart';
import 'package:provider/provider.dart';

class EditNoteScreen extends StatefulWidget {
  final Note note;

  const EditNoteScreen({Key? key, required this.note}) : super(key: key);

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  DateTime? _date;
  final TextEditingController titleController = new TextEditingController();

  final TextEditingController descriptionController =
      new TextEditingController();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  void initState() {
    titleController.text = widget.note.title;
    descriptionController.text = widget.note.description;

    _date = widget.note.date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: (() => Navigator.pop(context)),
                          child: Row(
                            children: const [
                              Text(
                                "Cancel",
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white54),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.cancel,
                                size: 30,
                                color: AppColors.addNotePageColor,
                              ),
                            ],
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please add a title";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide()),
                        hintText: "title:",
                        hintStyle: TextStyle(color: Colors.white54),
                        hintMaxLines: 5),
                    style: titleStyle.copyWith(color: Colors.white54),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white54),
                    controller: descriptionController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please add a description";
                      } else {
                        return null;
                      }
                    },
                    textAlign: TextAlign.start,
                    minLines: 1,
                    maxLines: 24,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide()),
                        hintText: "description",
                        hintStyle: TextStyle(color: Colors.white54)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () async {
                          _date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime(DateTime.now().year + 5, 12, 31));
                          _date ??= widget.note.date;
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text("Choose Date",
                              style: TextStyle(
                                  color: AppColors.addNotePageColor,
                                  fontSize: 20)),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Consumer<NoteData>(
                        builder: (context, value, child) {
                          return Text(
                            MyDateFormat.dateFormat(_date!).toString(),
                            style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<NoteData>(
                    builder: (BuildContext context, data, Widget? child) {
                      return InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              await data.updateNote(
                                  titleController.text,
                                  descriptionController.text,
                                  _date!.millisecondsSinceEpoch,
                                  widget.note.noteNumber);
                            }
                            print(titleController.text);
                            // print(widget.note.noteNumber);

                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.addNotePageColor,
                              borderRadius: BorderRadius.circular(23),
                            ),
                            child: Center(
                              child: Text(
                                "Save",
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
      ),
    );
  }
}
