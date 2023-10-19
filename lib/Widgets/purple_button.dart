import 'package:flutter/material.dart';

class PurpleButton extends StatelessWidget {
  final Function() callback;
  final String caption;

  const PurpleButton(
      {required this.callback, required this.caption, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(200, 70),
            maximumSize: const Size(400, 200),
            backgroundColor: Colors.deepPurpleAccent),
        child: Text(
          caption,
          textScaleFactor: 1.5,
        ));
  }
}
