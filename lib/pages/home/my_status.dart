import 'package:flutter/material.dart';

class MyStatus extends StatefulWidget {
  const MyStatus({super.key});

  @override
  State<StatefulWidget> createState() => MyStatusState();
}

class MyStatusState extends State<MyStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, bottom: 20),
      decoration: BoxDecoration(color: const Color.fromARGB(255, 244, 244, 244)),
      child: Column(
        spacing: 8,
        children: [
          SizedBox(
            width: double.infinity,
            height: 28,
            child: Text(
              _MyStatusConsts.topComponentTitleAlertTriggered,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 200),
            child: topComponentButton(),
          ),
        ],
      ),
    );
  }

  Widget topComponentButton() {
    return ElevatedButton.icon(
        label: Text(
          _MyStatusConsts.topComponentButtonCaption,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(255, 128, 0, 0),
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        //TODO: Implement button
        onPressed: () {},
        icon: Icon(
          Icons.edit_square,
          size: 25,
          color: Color.fromARGB(255, 128, 0, 0),
        ),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 236, 212, 212)),
        ));
  }
}

class _MyStatusConsts {
  static const String topComponentTitleAlertTriggered = "הופעלה אזעקה?";
  static const String topComponentTitleNoStatus = "ללא סטאטוס";
  static const String topComponentTitleImOkay = "אני בסדר";
  static const String topComponentButtonCaption = "עדכן סטאטוס";
}
