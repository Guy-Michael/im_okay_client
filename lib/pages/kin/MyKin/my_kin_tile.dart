import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Models/cached_user_data.dart';

class MyKinTile extends StatefulWidget {
  final CachedUserData user;

  const MyKinTile({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => _MyKinTileState();
}

class _MyKinTileState extends State<MyKinTile> {
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
                      image: DecorationImage(image: NetworkImage(widget.user.image))),
                )),
                Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 16, children: [
                  Text(
                    widget.user.name,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Text(
                    widget.user.phone,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  )
                ]),
                Spacer(),
                Icon(
                  Icons.more_horiz_rounded,
                  color: Colors.green,
                  size: 50,
                )
              ],
            )));
  }
}
