import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';

class AsyncButton extends StatefulWidget {
  final Function() onPressed;
  final String? text;
  final Widget? icon;

  AsyncButton({required this.onPressed, this.text, this.icon});

  @override
  AsyncButtonState createState() => AsyncButtonState();
}

class AsyncButtonState extends State<AsyncButton> {
  bool isAwaitingCallbackCompletion = false;

  @override
  Widget build(BuildContext context) {
    GFButton button = GFButton(
      text: widget.text,
      icon:
          // isAwaitingCallbackCompletion
          // ?
          const CircularProgressIndicator(),
      // : widget.icon,
      onPressed: () async {
        setState(() {
          isAwaitingCallbackCompletion = true;
        });

        await widget.onPressed();
        setState(() {
          isAwaitingCallbackCompletion = false;
        });
      },
    );

    return button;
  }
}
