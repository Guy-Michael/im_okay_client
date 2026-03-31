import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/pages/kin/shared/kin_button.dart';

class IncomingKinRequestTile extends StatefulWidget {
  AppUser user;
  Future<void> Function() onConfirm;
  Future<void> Function() onDeny;

  IncomingKinRequestTile(
      {super.key, required this.user, required this.onConfirm, required this.onDeny});

  @override
  State<StatefulWidget> createState() => _IncomingKinRequestTilState();
}

class _IncomingKinRequestTilState extends State<IncomingKinRequestTile> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            height: 130,
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              spacing: 12,
              children: [
                Center(
                    child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage(widget.user.imageUrl))),
                )),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    widget.user.fullName,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Row(
                    spacing: 16,
                    children: [
                      KinButton(
                        type: KinButtonType.positiveAction,
                        caption: _IncomingKinRequestTileConsts.approveButtonCaption,
                        onPressed: widget.onConfirm,
                      ),
                      KinButton(
                        type: KinButtonType.negativeAction,
                        caption: _IncomingKinRequestTileConsts.denyButtonCaption,
                        onPressed: widget.onDeny,
                      ),
                    ],
                  )
                ]),
              ],
            )));
  }

  ElevatedButton getPendingKinRequestButton(
      {required Color color,
      required Function() onPressed,
      required String caption,
      Color textColor = Colors.white}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: color, minimumSize: Size(112, 35), maximumSize: Size(224, 70)),
      child: Text(
        caption,
        style: TextStyle(color: textColor, fontSize: 18),
      ),
    );
  }
}

class _IncomingKinRequestTileConsts {
  static const String approveButtonCaption = "אישור";
  static const String denyButtonCaption = "ביטול";
}
