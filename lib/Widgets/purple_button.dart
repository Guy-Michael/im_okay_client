import 'package:flutter/material.dart';
import 'package:im_okay_client/Utils/Consts/consts.dart';

class PurpleButton extends StatelessWidget {
  late final Function() callback;
  late final String caption;

  PurpleButton({required this.callback, required this.caption, super.key});

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
