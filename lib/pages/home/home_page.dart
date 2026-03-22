import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
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
    //TODO: Logic here is wrong.
    // I think the flow should be:
    // a Stream builder \ Provider that gets all kin.
    // On the home page widget, we will divide into 3 groups:
    // 1. Have no alerts
    // 2. have alerts and not reported
    // 3. have alerts and have reported
    // If 2 or 3 are not empty, go to home body with alerts
    // If only 1 is not empty, go to home body without alerts
    List<AppUser> users = simulateAListOfUsersWithAndWithoutAlerts();
    Widget body = areAlertsActive(users) ? HomeBodyWithAlerts() : HomeBodyNoAlerts();
    return Scaffold(body: Column(children: [MyStatus(), body]));
  }

  List<AppUser> simulateAListOfUsersWithAndWithoutAlerts() {
    List<AppUser> users = [
      AppUser(
          firstName: "Guy", lastName: "Michael", lastAlertTime: 1774035000, lastSeen: 1777097000),
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
