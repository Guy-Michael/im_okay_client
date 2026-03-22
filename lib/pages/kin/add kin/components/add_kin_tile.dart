import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';

class AddKinTile extends StatefulWidget {
  final AppUser user;

  Future<void> Function({required AppUser user}) onAddClicked;

  AddKinTile({
    super.key,
    required this.user,
    required this.onAddClicked,
  });

  @override
  State<StatefulWidget> createState() => AddKinTileState();
}

class IFriendsInteractionsService {}

class AddKinTileState extends State<AddKinTile> {
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
                Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 16, children: [
                  Text(
                    widget.user.fullName,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Text(
                    "0548045705",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  )
                ]),
                Spacer(),
                ElevatedButton(
                  onPressed: () => widget.onAddClicked(user: widget.user),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal, minimumSize: Size(112, 35)),
                  child: Text(
                    _AddKinTileConsts.addButtonCaption,
                    style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: "Inter"),
                  ),
                )
              ],
            )));
  }
}

class _AddKinTileConsts {
  static const String addButtonCaption = "הוספה";
}
