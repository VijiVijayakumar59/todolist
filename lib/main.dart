import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/controller/image_controller.dart';
import 'package:todolist/view/home/screens/list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(ImagePickerController());
      }),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TodoListScreen(),
    );
  }
}
