// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String labelText;
  final controller;
  final bool? obscureText;
  // final String? hintText;

  const MyTextfield({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 12),
      child: TextField(
        controller: controller,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade600,
            ),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}
