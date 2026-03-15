import 'package:flutter/material.dart';
import 'package:im_okay/Services/router_service.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/pages/home/my_status.dart';
import 'package:im_okay/pages/shared_components/go_to_add_kin_page_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      MyStatus(),
      Expanded(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 28, left: 16, right: 16, bottom: 28),
          child: Column(
            spacing: 32,
            children: [
              noAlertTitle(),
              helpText(),
              Image(image: AssetImage("Assets/Main/main_page_no_alarms.png")),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: GoToAddKinPageButton(),
      ),
    ]));
  }
}

Widget noAlertTitle() {
  return Text(
    _HomePageConsts.noAletsTitle,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
    ),
  );
}

Widget helpText() {
  return SizedBox(
    width: 305,
    child: ConstrainedBox(
      constraints: BoxConstraints(minWidth: 305),
      child: Text(
        _HomePageConsts.noAlertsHelpText,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF7B7B7B),
          fontSize: 18,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

class _HomePageConsts {
  static const String noAletsTitle = "אין אזעקות אצלך ואצל הקרובים";
  static const String noAlertsHelpText =
      "אם הקרובים שלך יחוו אזעקה, כאן אפשר להתעדכן בשלומם ולעדכן אותם במצבך";
  static const String topComponentTitle = "הופעלה אזעקה?";
  static const String topComponentButtonCaption = "עדכן סטאטוס";
}
