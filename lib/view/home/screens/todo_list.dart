// ignore_for_file: unused_local_variable, avoid_print, deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todolist/view/home/widgets/delete_confirmation.dart';
import 'package:todolist/view/home/widgets/share.dart';
import 'package:todolist/controller/todo_controller.dart';
import 'package:todolist/utils/colors/colors.dart';
import 'package:todolist/view/edit/screens/edit_screen.dart';
import 'package:todolist/view/home/widgets/create_note_widget.dart';
import 'package:todolist/view/home/widgets/note_view_widget.dart';
import 'package:todolist/view/home/widgets/alert_button.dart';
import 'package:todolist/utils/constants/sized_Box.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.find();
    final noteBox = Hive.box("note_box");

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
                              todoController.deleteAllNotes();
                              Get.back();
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
        body: Obx(
          () => Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: todoController.notes.length,
                  itemBuilder: (context, index) {
                    final note = todoController.notes[index];
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
                                note['imagePath'] != null
                                    ? File(note['imagePath'])
                                    : null, // Convert String to File
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
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        leading: CircleAvatar(
                          radius: 34,
                          backgroundColor: Colors.blue,
                          backgroundImage: note['imagePath'] != null &&
                                  note['imagePath'].isNotEmpty
                              ? FileImage(File(note['imagePath']))
                              : null,
                          child: note['imagePath'] == null ||
                                  note['imagePath'].isEmpty
                              ? const Icon(
                                  Icons.person,
                                  size: 30,
                                  color: whiteColor,
                                )
                              : null,
                        ),
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
                              Get.to(() => EditScreen(noteIndex: index))
                                  ?.then((value) {
                                print('Returned value from EditScreen: $value');
                                if (value != null) {
                                  todoController.updateImage(
                                    todoController.notes[index]['imagePath'],
                                  );
                                }
                              });
                            } else if (value == 2) {
                              onShare(
                                context,
                                todoController.notes[index]['title'],
                                todoController.notes[index]['note'],
                                File(todoController.notes[index]
                                    ['imagePath']), // Convert String to File
                              );
                            } else if (value == 3) {
                              deleteConfirmationDialog(
                                  context, index, todoController);
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 111, 13, 129),
            onPressed: () {
              Get.to(CreateNoteScreen());
            },
            child: const Icon(Icons.add, color: whiteColor),
          ),
        ),
      ),
    );
  }
}
