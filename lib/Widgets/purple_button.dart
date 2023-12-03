import 'package:flutter/material.dart';

class PurpleButton extends StatefulWidget {
  final Future<void> Function() onClick;
  final bool showProgressIndicatorAfterClick;
  final String caption;
  final Color color;

  const PurpleButton(
      {required this.onClick,
      required this.caption,
      this.showProgressIndicatorAfterClick = false,
      this.color = Colors.deepPurpleAccent,
      super.key});

  @override
  State<StatefulWidget> createState() => PurpleButtonState();
}

class PurpleButtonState extends State<PurpleButton> {
  bool isWaitingForCallback = false;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    Size minimumSize = Size(deviceWidth * 0.2, deviceHeight * 0.05);
    Size maximumSize = Size(minimumSize.width * 3, minimumSize.height * 3);
    return ElevatedButton(
        onPressed: () async {
          if (widget.showProgressIndicatorAfterClick) {
            setState(() {
              isWaitingForCallback = true;
            });
          }
          widget.onClick().then((value) => setState(() {
                isWaitingForCallback = false;
              }));
        },
        style: ElevatedButton.styleFrom(
            minimumSize: minimumSize, maximumSize: maximumSize, backgroundColor: widget.color),
        child: Padding(
            padding: const EdgeInsets.all(5),
            child: isWaitingForCallback
                ? const CircularProgressIndicator()
                : Text(
                    widget.caption,
                    textScaleFactor: 1.5,
                  )));
  }
}
