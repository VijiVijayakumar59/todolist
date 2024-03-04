// ignore_for_file: file_names

import 'package:flutter/material.dart';

class KHeight extends StatelessWidget {
  final double size;

  const KHeight({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * size,
    );
  }
}

class KWidth extends StatelessWidget {
  final double size;
  const KWidth({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * size,
    );
  }
}
