import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/controller/todo_controller.dart';
import 'package:todolist/view/home/widgets/text_form_widget.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  String? newImage;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController noteController = TextEditingController();

    final TodoController controller = Get.find();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Create your Note',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          leading: IconButton(
            onPressed: () {
              Get.back(result: controller.pickedImageFile.value);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 30,
              top: 8,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.grey,
                              backgroundImage: newImage != null
                                  ? FileImage(
                                      File(newImage!),
                                    )
                                  : null,
                            ),
                            Positioned(
                              bottom: -1,
                              left: 48,
                              child: IconButton(
                                onPressed: () async {
                                  final String? imagePath =
                                      await controller.pickImageFromGallery();
                                  if (imagePath != null) {
                                    setState(() {
                                      newImage = imagePath;
                                    });
                                  }
                                },
                                icon: const Icon(
                                  Icons.edit,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextFormWidget(
                          controller: titleController,
                          onChanged: (value) {
                            controller.title.value = value;
                          },
                          text: "Title",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Title cannot be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormWidget(
                          controller: noteController,
                          onChanged: (value) {
                            controller.note.value = value;
                          },
                          text: "Note",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Note cannot be empty';
                            }
                            return null;
                          },
                          maxLines: 5,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              controller.title.value = titleController.text;
                              controller.note.value = noteController.text;
                              await controller.createNote();
                              titleController.clear();
                              noteController.clear();
                              Get.back();
                            }
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
