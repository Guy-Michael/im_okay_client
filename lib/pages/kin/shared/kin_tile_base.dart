import 'package:flutter/material.dart';
import 'package:im_okay/pages/kin/incoming%20kin%20requests/incoming_kin_requests_page.dart';

class KinTileBase extends StatefulWidget {
  final String name;
  final Widget whereTheConfirmDenyButtonsGo;

  const KinTileBase({super.key, required this.name, required this.whereTheConfirmDenyButtonsGo});

  @override
  State<StatefulWidget> createState() => _KinTileBaseState();
}

class _KinTileBaseState extends State<KinTileBase> {
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
                      image: DecorationImage(image: NetworkImage("https://picsum.photos/200/200"))),
                )),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    widget.name,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  widget.whereTheConfirmDenyButtonsGo
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
