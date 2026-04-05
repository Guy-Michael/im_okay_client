import 'package:flutter/material.dart';

class MyStatusNoStatus extends StatefulWidget {
  void Function() onUpdateStatusClicked;

  MyStatusNoStatus({super.key, required this.onUpdateStatusClicked});

  @override
  State createState() => MyStatusNoStatusState();
}

class MyStatusNoStatusState extends State<MyStatusNoStatus> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        SizedBox(
          width: double.infinity,
          height: 28,
          child: Text(
            _MyStatusNoStatusConsts.topComponentTitleNoStatus,
            textAlign: TextAlign.center,
            style: headerTextStyle,
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 200),
          child: ElevatedButton.icon(
              label: Text(
                _MyStatusNoStatusConsts.topComponentButtonCaption,
                textAlign: TextAlign.center,
                style: buttonTextStyle,
              ),
              onPressed: widget.onUpdateStatusClicked,
              icon: buttonIcon,
              style: topComponentButtonStyle),
        ),
      ],
    );
  }

  Icon buttonIcon = Icon(
    Icons.edit_square,
    size: 25,
    color: Color.fromARGB(255, 128, 0, 0),
  );

  TextStyle headerTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
  );

  ButtonStyle topComponentButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 236, 212, 212)),
  );

  TextStyle buttonTextStyle = TextStyle(
    color: Color.fromARGB(255, 128, 0, 0),
    fontSize: 19,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
  );
}

class _MyStatusNoStatusConsts {
  static const String topComponentTitleNoStatus = "ללא סטאטוס";
  static const String topComponentButtonCaption = "עדכון סטאטוס";
}
