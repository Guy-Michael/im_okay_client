import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController inputController;
  final String hintText;
  final bool obscureText;
  final IconData? icon;

  const MyTextField(
      {required this.inputController,
      required this.hintText,
      super.key,
      this.obscureText = false,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: inputController,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: IconButton(
              icon: Icon(icon),
              onPressed: () {
                // Handle the search functionality here
                // You can filter userEntries based on the search query
              },
            )),
        obscureText: obscureText);
  }
}
