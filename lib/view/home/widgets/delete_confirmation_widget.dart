import 'package:flutter/material.dart';
import 'package:todolist/controller/todo_controller.dart';

Future<void> deleteConfirmationWidget(
    BuildContext context, int index, TodoController imageController) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Delete Note"),
        content: const Text("Are you sure you want to delete this note?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // Call the deleteNote method from ImagePickerController
              imageController.deleteNote(index);
              Navigator.of(context).pop();
            },
            child: const Text("Delete"),
          ),
        ],
      );
    },
  );
}
