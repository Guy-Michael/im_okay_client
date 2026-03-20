import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/pages/home/components/with_alerts/home_kin_update_tile.dart';
import 'package:im_okay/pages/home/components/kin_update_toggle.dart';

class HomeBodyWithAlerts extends StatefulWidget {
  const HomeBodyWithAlerts({super.key});

  @override
  State<StatefulWidget> createState() => HomeBodyWithAlertsState();
}

class HomeBodyWithAlertsState extends State<HomeBodyWithAlerts> {
  @override
  Widget build(BuildContext context) {
    List<AppUser> users = [
      AppUser(firstName: "Guy", lastName: "Michael", lastAlertTime: 1774035940),
      AppUser(firstName: "Guy", lastName: "Michael", lastAlertTime: 1774035940),
      AppUser(firstName: "Guy", lastName: "Michael", lastAlertTime: 1774035940)
    ];

    return Column(
      children: [
        KinUpdateToggle(),
        Container(
            margin: EdgeInsets.only(top: 12),
            child: Column(
                spacing: 16, children: users.map((user) => HomeKinUpdateTile(user: user)).toList()))
      ],
    );
  }
}
