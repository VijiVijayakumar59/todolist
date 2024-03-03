import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/controller/image_controller.dart';

class EditScreen extends StatelessWidget {
  final int noteIndex;

  const EditScreen({Key? key, required this.noteIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImagePickerController controller = Get.find();

    // Get the existing note details
    Map<String, dynamic> existingNote = controller.notes[noteIndex];

    // Initialize controllers with existing details
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
                  // Display existing image
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
                    onPressed: () {
                      // Create a map with the edited details
                      Map<String, dynamic> editedNote = {
                        "title": titleController.text,
                        "note": noteController.text,
                        "imagePath":
                            controller.pickedImageFile.value?.path ?? '',
                      };

                      // Call the editNote method to update the note
                      controller.editNote(noteIndex, editedNote);

                      // Navigate back to the previous screen
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
