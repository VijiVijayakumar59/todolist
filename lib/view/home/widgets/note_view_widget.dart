import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todolist/utils/constants/colors.dart';
import 'package:todolist/utils/constants/sized_Box.dart';

Widget noteView(
    BuildContext context, File? imageFile, String title, String note) {
  return Stack(
    children: <Widget>[
      Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(top: 50),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: blackColor,
              offset: Offset(0, 10),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const KHeight(size: 0.02),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
            Text(
              note,
              style: const TextStyle(fontSize: 16),
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
              ? const Icon(
                  Icons.person,
                  size: 30,
                  color: whiteColor,
                )
              : null,
        ),
      ),
    ],
  );
}
