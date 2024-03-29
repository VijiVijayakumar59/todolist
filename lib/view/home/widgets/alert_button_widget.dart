import 'package:flutter/material.dart';
import 'package:todolist/utils/colors/colors.dart';

class AlertButtonWidget extends StatelessWidget {
  final String text;
  const AlertButtonWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.17,
      padding: const EdgeInsets.all(2),
      child: Text(
        text,
        style: const TextStyle(
          color: blackColor,
        ),
      ),
    );
  }
}
