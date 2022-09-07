import 'package:flutter/material.dart';
import 'package:notes_app/utils/styles.dart';

class NoteScreen extends StatelessWidget {
  final String title, descritpion;
  const NoteScreen({Key? key, required this.title, required this.descritpion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 40, 10, 15),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
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
                      size: 30,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      title,
                      style: mainTitleStyle,
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              SelectableText(
                descritpion,
                style: mainDescriptionStyle,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
