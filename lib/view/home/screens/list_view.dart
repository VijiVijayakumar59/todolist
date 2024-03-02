import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/controller/image_controller.dart';
import 'package:todolist/view/edit/screens/edit_screen.dart';
import 'package:todolist/view/home/widgets/alert_button.dart';
import 'package:todolist/view/home/widgets/sizedBox.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ImagePickerController imageController = Get.find();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Todo List",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Delete All"),
                        content: const Text("This will delete all data"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const AlertButton(text: "Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const AlertButton(text: "Delete"),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.delete,
                ),
              ),
            ),
          ],
        ),
        body: GetBuilder<ImagePickerController>(
          builder: (controller) => Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              child: contentBox(
                                context,
                                imageController.pickedImageFile.value,
                              ),
                            );
                          },
                        );
                      },
                      child: ListTile(
                        title: const Text(
                          "Title",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        leading: CircleAvatar(
                          radius: 30,
                          child: imageController.pickedImageFile.value != null
                              ? ClipOval(
                                  child: Image.file(
                                    imageController.pickedImageFile.value!,
                                  ),
                                )
                              : Icon(
                                  Icons.person,
                                  size: 30,
                                ),
                        ),
                        subtitle: const Text(
                          "Notes will be showing here",
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: PopupMenuButton<int>(
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 1,
                              child: Row(
                                children: [
                                  Icon(Icons.edit),
                                  KWidth(size: 0.03),
                                  Text("Edit")
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 2,
                              child: Row(
                                children: [
                                  Icon(Icons.share),
                                  KWidth(size: 0.03),
                                  Text("Share")
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 3,
                              child: Row(
                                children: [
                                  Icon(Icons.delete),
                                  KWidth(size: 0.03),
                                  Text("Delete")
                                ],
                              ),
                            ),
                          ],
                          offset: const Offset(0, 100),
                          color: const Color.fromARGB(255, 237, 235, 242),
                          elevation: 2,
                          onSelected: (value) {
                            if (value == 1) {
                              Get.to(() => const EditScreen())?.then(
                                (value) {
                                  if (value != null && value is File) {
                                    imageController.updateImage(value);
                                  }
                                },
                              );
                            } else if (value == 2) {
                              // Implement share functionality
                            } else if (value == 3) {
                              // Implement delete functionality
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  contentBox(context, File? imageFile) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const KHeight(size: 0.02),
              const Text(
                "Title",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 15),
              const Text(
                "Notes",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
                maxLines: 15,
              ),
              const SizedBox(height: 22),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Close",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 12,
          left: MediaQuery.of(context).size.width / 2 - 70,
          child: CircleAvatar(
            radius: 34,
            backgroundColor: Colors.blue,
            backgroundImage: imageFile != null ? FileImage(imageFile) : null,
            child: imageFile == null
                ? Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.white,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
