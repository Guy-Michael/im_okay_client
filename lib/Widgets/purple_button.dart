import 'package:flutter/material.dart';

class PurpleButton extends StatefulWidget {
  final Function() callback;
  final String caption;
  final Color color;
  final double minimumHeight;
  final double maximumHeight;
  final double minimumWidth;
  final double maximumWidth;
  final double scaleFactor;

  const PurpleButton(
      {required this.callback,
      required this.caption,
      this.color = Colors.deepPurpleAccent,
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
            minimumSize: Size(widget.minimumWidth * widget.scaleFactor,
                widget.minimumWidth * widget.scaleFactor),
            maximumSize: Size(widget.maximumWidth * widget.scaleFactor,
                widget.maximumHeight * widget.scaleFactor),
            backgroundColor: widget.color),
        child: Text(
          widget.caption,
          textScaleFactor: 1.5,
        ));
  }
}
