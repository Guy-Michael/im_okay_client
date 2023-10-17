import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController inputController;
  final String hintText;
  final bool obscureText;

  const MyTextField(this.inputController, this.hintText,
      {super.key, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: inputController,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: hintText,
        ),
        obscureText: obscureText);
  }
}
