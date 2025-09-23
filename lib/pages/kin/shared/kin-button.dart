import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum KinButtonType { positiveAction, negativeAction }

class KinButton extends StatefulWidget {
  KinButtonType type;
  String caption;
  Function() onPressed;

  KinButton({required this.type, required this.caption, required this.onPressed, super.key});

  @override
  State<StatefulWidget> createState() => KinButtonState();
}

class KinButtonState extends State<KinButton> {
  @override
  Widget build(BuildContext context) {
    final (backgroundColor, textColor) = switch (widget.type) {
      KinButtonType.positiveAction => (Colors.teal, Colors.white),
      KinButtonType.negativeAction => (const Color.fromARGB(255, 232, 232, 232), Colors.black),
    };

    return ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            minimumSize: Size(112, 35),
            maximumSize: Size(224, 70)),
        child: Text(
          widget.caption,
          style: TextStyle(color: textColor, fontSize: 18),
        ));
  }
}
