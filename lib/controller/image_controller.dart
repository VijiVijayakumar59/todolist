import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerController extends GetxController {
  Rx<File?> pickedImageFile = Rx<File?>(null);
  RxString title = ''.obs;
  RxString note = ''.obs;
  RxList<Map<String, dynamic>> notes = <Map<String, dynamic>>[].obs;
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

  final noteBox = Hive.box('note_box');

  // Future<void> createNote(Map<String, dynamic> newNote) async {
  //   await noteBox.add(newNote);
  //   notes.add(newNote); // Add this line to update the notes list
  //   print("Note count is ${noteBox.length}");
  // }
  Future<void> createNote() async {
    Map<String, dynamic> newNote = {
      "title": title.value,
      "note": note.value,
      "imagePath": pickedImageFile.value?.path ?? '',
    };
    await noteBox.add(newNote);
    notes.add(newNote);
  }

  Future<void> editNote(int index, Map<String, dynamic> editedNote) async {
    // Retrieve the existing note from the notes list
    Map<String, dynamic> existingNote = notes[index];

    // Update the existing note with the edited information
    existingNote['title'] = editedNote['title'];
    existingNote['note'] = editedNote['note'];
    existingNote['imagePath'] = editedNote['imagePath'];

    // Update the note in the Hive database
    await noteBox.putAt(index, existingNote);

    // Update the notes list with the edited note
    notes[index] = existingNote;
  }

  Future<void> deleteNote(int index) async {
    // Remove the note from the Hive box at the specified index
    await noteBox.deleteAt(index);

    // Remove the note from the notes list
    notes.removeAt(index);
  }

  Future<void> deleteAllNotes() async {
    // Clear the notes list
    notes.clear();

    // Clear the Hive box
    await noteBox.clear();
  }
}
