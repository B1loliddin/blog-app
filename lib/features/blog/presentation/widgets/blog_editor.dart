import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const BlogEditor({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: null,
      validator: (String? value) {
        if (value!.trim().isEmpty) {
          return '$hintText is missing';
        }

        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
