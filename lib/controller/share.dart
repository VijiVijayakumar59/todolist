// ignore_for_file: avoid_print, deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

Future<void> onShare(
    BuildContext context, String title, String note, File? imageFile) async {
  String text = '$title\n$note';

  try {
    if (imageFile != null) {
      await Share.shareFiles([imageFile.path], text: text);
    } else {
      await Share.share(text);
    }
  } catch (e) {
    print('Error sharing: $e');
  }
}
