import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/controller/image_controller.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ImagePickerController controller = Get.find();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Screen',
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: GetBuilder<ImagePickerController>(
              builder: (controller) => Card(
                elevation: 5,
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
                            backgroundImage: controller.pickedImageFile.value !=
                                    null
                                ? FileImage(controller.pickedImageFile.value!)
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
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Notes',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Implement save functionality here
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
    );
  }
}
