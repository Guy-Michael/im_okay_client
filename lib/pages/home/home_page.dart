import 'package:flutter/material.dart';
import 'package:im_okay/pages/home/components/home_body_no_alerts.dart';
import 'package:im_okay/pages/home/my_status.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [MyStatus(), HomeBodyNoAlerts()]));
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
