import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Services/Logger/my_logger.dart';
import 'package:im_okay/pages/home/components/kin_update_toggle.dart';
import 'package:im_okay/pages/home/components/with_alerts/home_body_alerts.dart';
import 'package:im_okay/pages/home/components/without_alerts/home_body_no_alerts.dart';
import 'package:im_okay/pages/home/my_status.dart';

class HomePage extends StatefulWidget {
  late AlertsHomePageToggle toggle = AlertsHomePageToggle.kinNotReported;
  HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<AppUser> users = simulateAListOfUsersWithAndWithoutAlerts();
    Widget body = areAlertsActive(users) ? HomeBodyWithAlerts() : HomeBodyNoAlerts();
    return Scaffold(body: Column(children: [MyStatus(), body]));
  }

  List<AppUser> simulateAListOfUsersWithAndWithoutAlerts() {
    List<AppUser> users = [
      AppUser(
          firstName: "Guy", lastName: "Michael", lastAlertTime: 1774035000, lastSeen: 1774036000),
      AppUser(firstName: "Guy", lastName: "Michael", lastAlertTime: 1774035800),
      AppUser(firstName: "Guy", lastName: "Michael", lastAlertTime: 1774034940)
    ];

    return users;
  }

  bool areAlertsActive(List<AppUser> users) {
    return users.where((user) => !user.hasReportedSafeDuringAlert).isNotEmpty;
  }
}

class _HomePageConsts {
  static const String noAletsTitle = "אין אזעקות אצלך ואצל הקרובים";
  static const String noAlertsHelpText =
      "אם הקרובים שלך יחוו אזעקה, כאן אפשר להתעדכן בשלומם ולעדכן אותם במצבך";
  static const String topComponentTitle = "הופעלה אזעקה?";
  static const String topComponentButtonCaption = "עדכן סטאטוס";
}
