import 'package:flutter/material.dart';

class MyStatusImOk extends StatefulWidget {
  const MyStatusImOk({super.key});

  @override
  State createState() => MyStatusImOkState();
}

class MyStatusImOkState extends State<MyStatusImOk> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        SizedBox(
          width: double.infinity,
          height: 28,
          child: Text(
            _MyStatusImOkConsts.topComponentTitleImOkay,
            textAlign: TextAlign.center,
            style: headerTextStyle,
          ),
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

class _MyStatusImOkConsts {
  static const String topComponentTitleImOkay = "אני בסדר";
  static const String topComponentButtonCaption = "עדכון סטאטוס";
}
