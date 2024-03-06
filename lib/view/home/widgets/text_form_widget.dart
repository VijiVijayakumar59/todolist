import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  final String? text;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final TextInputType? keyboardType;

  const TextFormWidget({
    Key? key,
    required this.controller,
    this.text,
    this.validator,
    this.onChanged,
    this.maxLines,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: text,
        border: OutlineInputBorder(),
      ),
    );
  }
}
