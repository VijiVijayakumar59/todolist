// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todolist/controller/image_controller.dart';

class CreateNoteScreen extends StatelessWidget {
  const CreateNoteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController noteController = TextEditingController();

    final noteBox = Hive.box('note_box');

    Future<void> createNote(Map<String, dynamic> newNote) async {
      await noteBox.add(newNote);
      print("Note count is ${noteBox.length}");
    }

    final ImagePickerController controller = Get.find();
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
              child: GetBuilder<ImagePickerController>(
                builder: (controller) => Obx(
                  () => Card(
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
                                backgroundImage:
                                    controller.pickedImageFile.value != null
                                        ? FileImage(
                                            controller.pickedImageFile.value!)
                                        : null,
                              ),
                              Positioned(
                                bottom: -1,
                                left: 48,
                                child: IconButton(
                                  onPressed: () async {
                                    await controller.pickImageFromGallery();
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: titleController,
                            decoration: const InputDecoration(
                              labelText: 'Title',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: noteController,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              labelText: 'Notes',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              createNote({
                                "title": titleController.text,
                                "note": noteController.text,
                                "imagePath":
                                    controller.pickedImageFile.value?.path ??
                                        '',
                              });
                              titleController.text = '';
                              noteController.text = '';
                              Get.back();
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
      ),
    );
  }
}