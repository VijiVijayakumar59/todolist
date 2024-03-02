import 'package:flutter/material.dart';

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
      color: const Color.fromARGB(255, 107, 4, 125),
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
