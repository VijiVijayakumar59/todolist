import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerController extends GetxController {
  Rx<File?> pickedImageFile = Rx<File?>(null);

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
}
