import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/controller/todo_controller.dart';

class EditScreen extends StatefulWidget {
  final int noteIndex;

  const EditScreen({
    Key? key,
    required this.noteIndex,
  }) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoController>(
      init: TodoController(),
      builder: (controller) {
        Map<String, dynamic> existingNote = controller.notes[widget.noteIndex];
        TextEditingController titleController =
            TextEditingController(text: existingNote['title']);
        TextEditingController noteController =
            TextEditingController(text: existingNote['note']);
        imagePath ??= existingNote['imagePath'];

        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Edit Screen',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey,
                            key: UniqueKey(),
                            backgroundImage:
                                imagePath != null && imagePath!.isNotEmpty
                                    ? FileImage(File(imagePath!))
                                    : null,
                          ),
                          Positioned(
                            bottom: -1,
                            left: 48,
                            child: IconButton(
                              onPressed: () async {
                                String? newImagePath =
                                    await controller.pickImageFromGallery();
                                if (newImagePath != null) {
                                  print(
                                      "New image path selected: $newImagePath");
                                  imagePath = newImagePath;
                                }
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: noteController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Notes',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Create a map with the edited details
                          Map<String, dynamic> editedNote = {
                            "title": titleController.text,
                            "note": noteController.text,
                            "imagePath": imagePath ?? '',
                          };
                          controller.editNote(
                            widget.noteIndex,
                            editedNote,
                          );
                          Get.back();
                        },
                        child: const Text('Update'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
