import 'package:flutter/material.dart';

class LoginTextInput extends StatelessWidget {
  // Text box for login
  const LoginTextInput({
    super.key,
    required this.hint,
    required this.label,
    this.controller,
    this.isPassword = false,
  });

  final String hint;
  final String label;
  final bool isPassword;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ), // Set hint text color to grey
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
      ),
    );
  }
}
