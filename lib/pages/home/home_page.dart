import 'package:flutter/material.dart';
import 'package:im_okay/pages/home/components/home_body_alerts.dart';
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
    return Scaffold(body: Column(children: [MyStatus(), HomeBodyWithAlerts()]));
  }
}

class _HomePageConsts {
  static const String noAletsTitle = "אין אזעקות אצלך ואצל הקרובים";
  static const String noAlertsHelpText =
      "אם הקרובים שלך יחוו אזעקה, כאן אפשר להתעדכן בשלומם ולעדכן אותם במצבך";
  static const String topComponentTitle = "הופעלה אזעקה?";
  static const String topComponentButtonCaption = "עדכן סטאטוס";
}
