import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.hint,
    this.controller,
    this.type,
    required this.validator,
  });

  final String hint;
  final controller;
  final type;
  final String? Function(String? value) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(5.5)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(5.5),
        ),
        hintText: hint,
        contentPadding: const EdgeInsets.all(9),
        hintStyle: const TextStyle(color: Colors.blueGrey, fontSize: 14),
        filled: true,
        //fillColor: Colors.green[50]
      ),
    );
  }
}
