import 'package:flutter/material.dart';

class PurpleButton extends StatelessWidget {
  final Function() callback;
  final String caption;
  double minimumHeight;
  double maximumHeight;
  double minimumWidth;
  double maximumWidth;
  double scaleFactor;
  PurpleButton(
      {required this.callback,
      required this.caption,
      this.minimumHeight = 100,
      this.minimumWidth = 70,
      this.maximumHeight = 200,
      this.maximumWidth = 400,
      this.scaleFactor = 1,
      super.key});

  @override
  Widget build(BuildContext context) {
    Size minimumSize =
        Size(minimumHeight * scaleFactor, minimumWidth * scaleFactor);
    Size maximumSize =
        Size(maximumHeight * scaleFactor, maximumWidth * scaleFactor);

    return ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
            minimumSize: minimumSize,
            maximumSize: maximumSize,
            backgroundColor: Colors.deepPurpleAccent),
        child: Text(
          caption,
          textScaleFactor: 1.5,
        ));
  }
}
