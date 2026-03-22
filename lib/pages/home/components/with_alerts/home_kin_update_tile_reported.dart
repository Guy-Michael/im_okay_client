import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Utils/string_utils.dart';

class HomeKinUpdateTileReported extends StatefulWidget {
  final AppUser user;

  const HomeKinUpdateTileReported({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => _HomeKinUpdateTileReportedState();
}

class _HomeKinUpdateTileReportedState extends State<HomeKinUpdateTileReported> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            height: 130,
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            padding: EdgeInsets.all(12),
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
                      image: DecorationImage(image: NetworkImage("https://picsum.photos//200"))),
                )),
                Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 8, children: [
                  Text(
                    widget.user.fullName,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Row(
                    spacing: 4,
                    children: [
                      Icon(
                        _HomeKinTileConsts.imOkayIcon,
                        color: Colors.green,
                      ),
                      Text(_HomeKinTileConsts.imOkay),
                    ],
                  ),
                  Text(
                    interpolateString(_HomeKinTileConsts.awaitingResponse,
                        [widget.user.durationSinceLastSeen().inMinutes]),
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  )
                ]),
              ],
            )));
  }
}

class _HomeKinTileConsts {
  static const String imOkay = "אני בסדר";
  static const IconData imOkayIcon = Icons.check_circle_outline_outlined;
  static const String awaitingResponse = "לפני {0} דקות";
}
