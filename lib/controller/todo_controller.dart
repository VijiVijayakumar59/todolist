import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class TodoController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  late Box box;

  @override
  void onInit() {
    super.onInit();
    box = Hive.box('note_box');
  }
}
