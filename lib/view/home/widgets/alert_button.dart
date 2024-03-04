import 'package:flutter/material.dart';
import 'package:todolist/utils/constants/colors.dart';

class AlertButton extends StatelessWidget {
  final String text;
  const AlertButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.17,
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style: const TextStyle(
          color: blackColor,
        ),
      ),
    );
  }
}
