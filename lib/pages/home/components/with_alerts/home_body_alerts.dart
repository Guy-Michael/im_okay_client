import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Services/Logger/my_logger.dart';
import 'package:im_okay/pages/home/components/kin_update_toggle.dart';
import 'package:im_okay/pages/home/components/with_alerts/home_kin_update_tile_not_reported.dart';
import 'package:im_okay/pages/home/components/with_alerts/home_kin_update_tile_reported.dart';

enum AlertsHomePageToggle { kinReported, kinNotReported }

class HomeBodyWithAlerts extends StatefulWidget {
  AlertsHomePageToggle toggle = AlertsHomePageToggle.kinNotReported;

  HomeBodyWithAlerts({super.key});

  @override
  State<StatefulWidget> createState() => HomeBodyWithAlertsState();
}

class HomeBodyWithAlertsState extends State<HomeBodyWithAlerts> {
  @override
  Widget build(BuildContext context) {
    List<AppUser> users = [
      AppUser(
          firstName: "Guy", lastName: "Michael", lastAlertTime: 1774035940, lastSeen: 1774095940),
      AppUser(firstName: "Guy", lastName: "Michael", lastAlertTime: 1774035940),
      AppUser(firstName: "Guy", lastName: "Michael", lastAlertTime: 1774035940)
    ];

    List<Widget> userTiles = getTileList(users, widget.toggle);

    return Column(
      children: [
        KinUpdateToggle(
          onToggle: onToggle,
        ),
        Container(margin: EdgeInsets.only(top: 12), child: Column(spacing: 16, children: userTiles))
      ],
    );
  }

  List<Widget> getTileList(List<AppUser> users, AlertsHomePageToggle toggle) {
    Iterable<Widget> list;
    if (toggle == AlertsHomePageToggle.kinNotReported) {
      list = users.map((user) => HomeKinUpdateTileNotReported(user: user));
    } else {
      list = users.map((user) => HomeKinUpdateTileReported(user: user));
    }

    return list.toList();
  }

  void onToggle(AlertsHomePageToggle toggle) {
    logger.log("Got mode $toggle");
    setState(() => widget.toggle = toggle);
    // widget.toggle = toggle;
  }
}
