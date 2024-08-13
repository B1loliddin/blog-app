import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;

  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (String? value) {
        if (value!.trim().isEmpty) {
          return '$hintText is missing!';
        }

        return null;
      },
      controller: controller,
      textInputAction: TextInputAction.next,
      obscureText: isObscureText,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
