import 'dart:async';

import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Services/KinInteractionService/i_kin_interaction_service.dart';
import 'package:im_okay/Services/service_injector.dart';
import 'package:im_okay/Utils/stream_utils.dart';
import 'package:im_okay/pages/home/components/update_status_popup.dart';
import 'package:im_okay/pages/home/components/with_alerts/home_body_alerts.dart';
import 'package:im_okay/pages/home/components/without_alerts/home_body_no_alerts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late final IKinInteractionsService _kinInteractionService;
  late StreamController<List<AppUser>>? controller;
  late AlertsHomePageToggle toggle = AlertsHomePageToggle.kinNotReported;
  bool showStatusUpdatePopup = false;
  bool popupVisible = false;

  @override
  void initState() {
    super.initState();

    _kinInteractionService = serviceInjector.get<IKinInteractionsService>();

    controller = StreamUtils.initStreamController(
        func: _kinInteractionService.getAllKin, duration: Duration(seconds: 10));
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

          Widget body;

          if (usersWithAlertsInTheLast30Minutes.isEmpty) {
            body = HomeBodyNoAlerts(
              onUpdateStatusClicked: () => onUpdateStatusClicked(context),
            );
          } else {
            List<AppUser> safeKin = usersWithAlertsInTheLast30Minutes
                .where((user) => user.durationSinceLastSeen() < user.durationSinceLastAlert())
                .toList();

            List<AppUser> kinNotReportedYet = usersWithAlertsInTheLast30Minutes
                .where((user) => user.durationSinceLastSeen() >= user.durationSinceLastAlert())
                .toList();

            body = HomeBodyWithAlerts(
              kinReported: safeKin,
              kinNotYetReported: kinNotReportedYet,
              onUpdateStatusClicked: () => onUpdateStatusClicked(context),
            );
          }

          return Scaffold(
              body: Stack(children: [
            body,
            Center(
                child: Visibility(
              visible: popupVisible,
              child: UpdateStatusPopup(
                onDismiss: onPopupDismiss,
                onReportOkClicked: _kinInteractionService.reportOkay,
              ),
            )),
          ]));
        });
  }

  void onPopupDismiss() => setState(() => popupVisible = false);
  void onUpdateStatusClicked(BuildContext context) {
    setState(() {
      popupVisible = true;
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
