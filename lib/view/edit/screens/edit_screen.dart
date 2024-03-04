import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/controller/todo_controller.dart';
import 'package:todolist/utils/constants/sized_Box.dart';

class EditScreen extends StatelessWidget {
  final int noteIndex;

  const EditScreen({
    Key? key,
    required this.noteIndex,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.find();
    Map<String, dynamic> existingNote = controller.notes[noteIndex];
    TextEditingController titleController =
        TextEditingController(text: existingNote['title']);
    TextEditingController noteController =
        TextEditingController(text: existingNote['note']);

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
                  if (controller.pickedImageFile.value != null)
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              FileImage(controller.pickedImageFile.value!),
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
                  const KHeight(size: 0.03),
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const KHeight(size: 0.03),
                  TextFormField(
                    controller: noteController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Notes',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const KHeight(size: 0.03),
                  ElevatedButton(
                    onPressed: () {
                      // Create a map with the edited details
                      Map<String, dynamic> editedNote = {
                        "title": titleController.text,
                        "note": noteController.text,
                        "imagePath":
                            controller.pickedImageFile.value?.path ?? '',
                      };
                      controller.editNote(noteIndex, editedNote);
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
  }
}
