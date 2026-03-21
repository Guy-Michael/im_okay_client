import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Utils/string_utils.dart';

class HomeKinUpdateTile extends StatefulWidget {
  final AppUser user;

  const HomeKinUpdateTile({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => _HomeKinUpdateTileState();
}

class _HomeKinUpdateTileState extends State<HomeKinUpdateTile> {
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
                Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 16, children: [
                  Text(
                    widget.user.fullName,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Text(
                    interpolateString(_HomeKinTileConsts.awaitingResponse,
                        [widget.user.durationSinceLastAlert().inMinutes]),
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  )
                ]),
                Spacer(),
                Icon(
                  Icons.notifications_on_outlined,
                  color: Colors.green,
                  size: 50,
                )
              ],
            )));
  }
}

class _HomeKinTileConsts {
  static const String awaitingResponse = "אזעקה לפני {0} דקות";
}
