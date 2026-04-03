import 'package:flutter/material.dart';
import 'package:im_okay/pages/home/components/with_alerts/home_body_alerts.dart';

class KinUpdateToggle extends StatefulWidget {
  List<bool> isSelected = [false, false];
  void Function(AlertsHomePageToggle toggle) onToggle;
  KinUpdateToggle({super.key, required this.onToggle});

  @override
  State<KinUpdateToggle> createState() => _KinUpdateToggleState();
}

class _KinUpdateToggleState extends State<KinUpdateToggle> {
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      borderRadius: BorderRadius.circular(50),
      isSelected: widget.isSelected,
      selectedColor: Colors.green,
      onPressed: (int newIndex) {
        setState(() {
          for (int index = 0; index < widget.isSelected.length; index++) {
            if (index == newIndex) {
              widget.isSelected[index] = true;
            } else {
              widget.isSelected[index] = false;
            }
          }
        });
        widget.onToggle(getCurrentMode());
      },
      children: [
        Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(spacing: 10, children: [
              Icon(Icons.hourglass_top),
              Text(_KinUpdateToggleConsts.notUpdatedYetToggleCaption),
            ])),
        Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(spacing: 10, children: [
              Icon(Icons.co_present_outlined),
              Text(_KinUpdateToggleConsts.notUpdatedYetToggleCaption),
            ])),
      ],
    );
  }

  AlertsHomePageToggle getCurrentMode() {
    if (widget.isSelected[0]) {
      return AlertsHomePageToggle.kinNotReported;
    } else {
      return AlertsHomePageToggle.kinReported;
    }
  }
}

class _KinUpdateToggleConsts {
  static const String notUpdatedYetToggleCaption = "טרם עדכנו";
  static const String alreadyUpdatedToggleCaption = "עדכנו";
}
