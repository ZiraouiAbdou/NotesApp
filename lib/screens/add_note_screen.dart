// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:notes_app/databse/db_helper.dart';
import 'package:notes_app/controller/db_controller.dart';
import 'package:notes_app/utils/colors.dart';
import 'package:notes_app/utils/date_format.dart';
import 'package:notes_app/utils/styles.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = new TextEditingController();
    final TextEditingController descriptionController =
        new TextEditingController();
    final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
    DateTime? _date = DateTime.now();
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
                  // ignore: prefer_const_constructors
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
                          _date ??= DateTime.now();
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
                          onTap: (() async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            data.insertNote(
                                titleController.text,
                                descriptionController.text,
                                _date!.millisecondsSinceEpoch);

                            Navigator.pop(context);
                          }),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.addNotePageColor,
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
      ),
    );
  }
}
