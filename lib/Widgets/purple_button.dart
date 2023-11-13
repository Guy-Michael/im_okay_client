import 'package:flutter/material.dart';

class PurpleButton extends StatefulWidget {
  final Function() callback;
  final String caption;
  final double minimumHeight;
  final double maximumHeight;
  final double minimumWidth;
  final double maximumWidth;
  final double scaleFactor;

  const PurpleButton(
      {required this.callback,
      required this.caption,
      this.minimumHeight = 100,
      this.minimumWidth = 70,
      this.maximumHeight = 200,
      this.maximumWidth = 400,
      this.scaleFactor = 1,
      super.key});

  @override
  State<StatefulWidget> createState() => PurpleButtonState();
}

class PurpleButtonState extends State<PurpleButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.callback,
        style: ElevatedButton.styleFrom(
            minimumSize: Size(widget.minimumHeight * widget.scaleFactor,
                widget.minimumWidth * widget.scaleFactor),
            maximumSize: Size(widget.maximumHeight * widget.scaleFactor,
                widget.maximumWidth * widget.scaleFactor),
            backgroundColor: Colors.deepPurpleAccent),
        child: Text(
          widget.caption,
          textScaleFactor: 1.5,
        ));
  }
}
