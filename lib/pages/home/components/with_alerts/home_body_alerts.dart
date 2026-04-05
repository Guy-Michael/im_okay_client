import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Services/Logger/my_logger.dart';
import 'package:im_okay/pages/home/components/kin_update_toggle.dart';
import 'package:im_okay/pages/home/components/my_status/my_status.dart';
import 'package:im_okay/pages/home/components/with_alerts/home_body_alerts_empty_caption.dart';
import 'package:im_okay/pages/home/components/with_alerts/home_kin_update_tile_not_reported.dart';
import 'package:im_okay/pages/home/components/with_alerts/home_kin_update_tile_reported.dart';

enum AlertsHomePageToggle { kinReported, kinNotReported }

class HomeBodyWithAlerts extends StatefulWidget {
  void Function() onUpdateStatusClicked;
  AlertsHomePageToggle toggle = AlertsHomePageToggle.kinNotReported;
  List<AppUser> kinNotYetReported;
  List<AppUser> kinReported;
  HomeBodyWithAlerts(
      {super.key,
      required this.kinNotYetReported,
      required this.kinReported,
      required this.onUpdateStatusClicked});

  @override
  State<StatefulWidget> createState() => HomeBodyWithAlertsState();
}

class HomeBodyWithAlertsState extends State<HomeBodyWithAlerts> {
  @override
  Widget build(BuildContext context) {
    List<Widget> userTiles = getTileList(widget.toggle);

    return Column(
      children: [
        MyStatus(
          onUpdateStatusClicked: widget.onUpdateStatusClicked,
        ),
        KinUpdateToggle(
          onToggle: onToggle,
        ),
        Container(
            margin: EdgeInsets.only(top: 12),
            child: userTiles.isEmpty
                ? HomeBodyAlertsEmptyCaption(toggle: widget.toggle)
                : Column(spacing: 16, children: userTiles))
      ],
    );
  }

  List<Widget> getTileList(AlertsHomePageToggle toggle) {
    Iterable<Widget> list;
    switch (toggle) {
      case AlertsHomePageToggle.kinNotReported:
        {
          list = widget.kinNotYetReported.map((user) => HomeKinUpdateTileNotReported(user: user));
          break;
        }
      case AlertsHomePageToggle.kinReported:
        {
          list = widget.kinReported.map((user) => HomeKinUpdateTileReported(user: user));
          break;
        }
    }

    return list.toList();
  }

  void onToggle(AlertsHomePageToggle toggle) {
    logger.log("Got mode $toggle");
    setState(() => widget.toggle = toggle);
  }
}
