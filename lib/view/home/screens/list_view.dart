import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todolist/controller/image_controller.dart';
import 'package:todolist/view/edit/screens/edit_screen.dart';
import 'package:todolist/view/home/widgets/create_note_widget.dart';
import 'package:todolist/view/home/widgets/note_view_widget.dart';
import 'package:todolist/view/home/widgets/alert_button.dart';
import 'package:todolist/view/home/widgets/sizedBox.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({Key? key});

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
        body: FutureBuilder(
          future: Hive.openBox("note_box"),
          builder: (context, AsyncSnapshot<Box<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              } else {
                final noteBox = Hive.box("note_box");
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: noteBox.length,
                        itemBuilder: (context, index) {
                          final note = noteBox.getAt(index) as Map;
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
                                    child: noteView(
                                      context,
                                      imageController.pickedImageFile.value,
                                      note['title'],
                                      note['note'],
                                    ),
                                  );
                                },
                              );
                            },
                            child: ListTile(
                              title: Text(
                                note['title'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              leading: Obx(() {
                                return CircleAvatar(
                                  radius: 30,
                                  child:
                                      imageController.pickedImageFile.value !=
                                              null
                                          ? ClipOval(
                                              child: Image.file(
                                                imageController
                                                    .pickedImageFile.value!,
                                              ),
                                            )
                                          : const Icon(
                                              Icons.person,
                                              size: 30,
                                            ),
                                );
                              }),
                              subtitle: Text(
                                note['note'],
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
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 111, 13, 129),
            onPressed: () {
              Get.to(const CreateNoteScreen());
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

