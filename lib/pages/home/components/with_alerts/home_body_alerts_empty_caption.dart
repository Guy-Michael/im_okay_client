import 'package:flutter/material.dart';
import 'package:im_okay/pages/home/components/with_alerts/home_body_alerts.dart';

enum HomePageCaptionMode { allAccounted, awaitingForUpdates }

class HomeBodyAlertsEmptyCaption extends StatefulWidget {
  AlertsHomePageToggle toggle;
  HomeBodyAlertsEmptyCaption({super.key, required this.toggle});

  @override
  State<StatefulWidget> createState() => _HomeBodyAlertsEmptyCaptionState();
}

class _HomeBodyAlertsEmptyCaptionState extends State<HomeBodyAlertsEmptyCaption> {
  @override
  Widget build(BuildContext context) {
    String caption = widget.toggle == AlertsHomePageToggle.kinNotReported
        ? _AllKinAccountedForCaptionConsts.allAccounted
        : _AllKinAccountedForCaptionConsts.awaitingUpdates;

    IconData icon = widget.toggle == AlertsHomePageToggle.kinNotReported
        ? _AllKinAccountedForCaptionConsts.allAccountedIcon
        : _AllKinAccountedForCaptionConsts.waitingForUpdateIcon;

    return Container(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 8,
        children: [
          SizedBox(
            width: 325,
            child: Text(
              caption,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Icon(icon),
        ],
      ),
    );
  }
}

class _AllKinAccountedForCaptionConsts {
  static const String allAccounted = "כל הקרובים עדכנו במצבם";
  static const String awaitingUpdates = "מחכים לעדכון מהקרובים";

  static const IconData allAccountedIcon = Icons.check_circle_outline_outlined;
  static const IconData waitingForUpdateIcon = Icons.timer_outlined;
}
