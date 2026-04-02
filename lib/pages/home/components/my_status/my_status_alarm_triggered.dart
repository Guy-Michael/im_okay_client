import 'package:flutter/material.dart';

class MyStatusAlarmTriggered extends StatefulWidget {
  const MyStatusAlarmTriggered({super.key});

  @override
  State createState() => MyStatusAlarmTriggeredState();
}

class MyStatusAlarmTriggeredState extends State<MyStatusAlarmTriggered> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        SizedBox(
          width: double.infinity,
          height: 28,
          child: Text(
            _MyStatusAlarmTriggeredConsts.topComponentTitleAlertTriggered,
            textAlign: TextAlign.center,
            style: headerTextStyle,
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 200),
          child: ElevatedButton.icon(
              label: Text(
                _MyStatusAlarmTriggeredConsts.topComponentButtonCaption,
                textAlign: TextAlign.center,
                style: buttonTextStyle,
              ),
              onPressed: () {},
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

class _MyStatusAlarmTriggeredConsts {
  static const String topComponentTitleAlertTriggered = "הופעלה אזעקה?";
  static const String topComponentButtonCaption = "עדכון סטאטוס";
}
