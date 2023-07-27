import 'package:flutter/material.dart';

class CustomTextfield1 extends StatelessWidget {
  const CustomTextfield1({
    super.key,
    required this.hint,
    this.controller,
    required this.inputType,
    this.validator,
    required this.password,
    this.enable,
    this.readOnly,
    this.onTap,
  });
  final bool password;
  final bool? readOnly;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType inputType;
  final bool? enable;
  final String? Function(String? value)? validator;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly ?? false,
      enabled: enable,
      validator: validator,
      keyboardType: inputType,
      obscureText: password,
      controller: controller,
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
          fillColor: const Color.fromARGB(255, 53, 58, 53)),
    );
  }
}
