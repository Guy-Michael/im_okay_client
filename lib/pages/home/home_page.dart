import 'dart:async';

import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/ikin_interaction_service.dart';
import 'package:im_okay/Utils/stream_utils.dart';
import 'package:im_okay/pages/home/components/with_alerts/home_body_alerts.dart';
import 'package:im_okay/pages/home/components/without_alerts/home_body_no_alerts.dart';
import 'package:im_okay/pages/home/my_status.dart';

class HomePage extends StatefulWidget {
  IKinInteractionsService kinInteractionService;
  late AlertsHomePageToggle toggle = AlertsHomePageToggle.kinNotReported;
  HomePage({super.key, required this.kinInteractionService});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late StreamController<List<AppUser>>? controller;

  @override
  void initState() {
    super.initState();
    controller = StreamUtils.initStreamController(
        func: widget.kinInteractionService.getAllKin, duration: Duration(seconds: 10));
  }

  @override
  void dispose() {
    controller?.close();
    controller = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: controller!.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<AppUser> usersWithAlertsInTheLast30Minutes = snapshot.data!.where((user) {
            Duration durationSinceLastAlert = user.durationSinceLastAlert();
            return durationSinceLastAlert < Duration(minutes: 30);
          }).toList();

          if (usersWithAlertsInTheLast30Minutes.isEmpty) {
            return HomeBodyNoAlerts();
          }

          List<AppUser> safeKin = usersWithAlertsInTheLast30Minutes
              .where((user) => user.durationSinceLastSeen() < user.durationSinceLastAlert())
              .toList();

          List<AppUser> kinNotReportedYet = usersWithAlertsInTheLast30Minutes
              .where((user) => user.durationSinceLastSeen() >= user.durationSinceLastAlert())
              .toList();

          return Scaffold(
              body: Column(children: [
            MyStatus(),
            HomeBodyWithAlerts(kinReported: safeKin, kinNotYetReported: kinNotReportedYet)
          ]));
        });
  }
}

class _HomePageConsts {
  static const String noAletsTitle = "אין אזעקות אצלך ואצל הקרובים";
  static const String noAlertsHelpText =
      "אם הקרובים שלך יחוו אזעקה, כאן אפשר להתעדכן בשלומם ולעדכן אותם במצבך";
  static const String topComponentTitle = "הופעלה אזעקה?";
  static const String topComponentButtonCaption = "עדכן סטאטוס";
}
