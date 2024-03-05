import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class TodoController extends GetxController {
  final noteBox = Hive.box('note_box');
  Rx<File?> pickedImageFile = Rx<File?>(null);
  RxString title = ''.obs;
  RxString note = ''.obs;
  RxList<Map<String, dynamic>> notes = <Map<String, dynamic>>[].obs;

  //===================image updation==================//
  final ImagePicker picker = ImagePicker();

  Future<String?> pickImageFromGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final String imagePath = image.path;
      Get.find<TodoController>().updateImage(imagePath);
      return imagePath; // Return the selected image path
    }
    return null; // Return null if no image is picked
  }

  var imagePath = ''.obs;

  void updateImage(String path) {
    imagePath.value = path;
    log(imagePath.value); // Add this line for debugging
  }

  //===================create note====================//

  Future<void> createNote() async {
    Map<String, dynamic> newNote = {
      "title": title.value,
      "note": note.value,
      "imagePath": imagePath.value,
    };
    await noteBox.add(newNote);
    notes.add(newNote);
  }

  //====================edit note=====================//

  Future<void> editNote(int index, Map<String, dynamic> editedNote) async {
    Map<String, dynamic> existingNote = notes[index];

    existingNote['title'] = editedNote['title'];
    existingNote['note'] = editedNote['note'];
    existingNote['imagePath'] = editedNote['imagePath'];

    await noteBox.putAt(index, existingNote);
    notes[index] = existingNote;
  }

  //===============delete a particular note=============//

  Future<void> deleteNote(int index) async {
    await noteBox.deleteAt(index);
    notes.removeAt(index);
  }

//===================delete all note====================//

  Future<void> deleteAllNotes() async {
    notes.clear();
    await noteBox.clear();
  }
}
