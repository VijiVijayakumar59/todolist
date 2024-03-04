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

  void updateImage(File image) {
    pickedImageFile.value = image;
  }

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      pickedImageFile.value = File(pickedImage.path);
    }
  }

  //===================create note====================//

  Future<void> createNote() async {
    Map<String, dynamic> newNote = {
      "title": title.value,
      "note": note.value,
      "imagePath": pickedImageFile.value?.path ?? '',
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
