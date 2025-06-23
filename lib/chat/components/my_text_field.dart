import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;

  const MyTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        hintText: 'Type Something...',
        fillColor: Colors.transparent,
        filled: true,
      ),
    );
  }
}
