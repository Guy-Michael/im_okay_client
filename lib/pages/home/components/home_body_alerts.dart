import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/pages/home/components/home_kin_tile.dart';
import 'package:im_okay/pages/home/components/kin_update_toggle.dart';

class HomeBodyWithAlerts extends StatefulWidget {
  HomeBodyWithAlerts({super.key});
  List<bool> isSelected = [false, false];

  @override
  State<StatefulWidget> createState() => HomeBodyWithAlertsState();
}

class HomeBodyWithAlertsState extends State<HomeBodyWithAlerts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KinUpdateToggle(),
        HomeKinTile(
          user: AppUser(firstName: "Guy", lastName: "Michael"),
        )
      ],
    );
  }
}
