import 'package:flutter/material.dart';
import 'package:im_okay/Enums/relationship_enum.dart';
import 'package:im_okay/Models/cached_user_data.dart';

class AddKinTile extends StatefulWidget {
  final CachedUserData cachedUserData;

  Future<void> Function({required CachedUserData user}) onAddClicked;
  Future<void> Function({required CachedUserData user}) onCancelClicked;

  AddKinTile(
      {super.key,
      required this.cachedUserData,
      required this.onAddClicked,
      required this.onCancelClicked});

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
              spacing: 10,
              children: [
                Center(
                    child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage(widget.cachedUserData.image))),
                )),
                Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 16, children: [
                  Text(
                    widget.cachedUserData.name,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Text(
                    widget.cachedUserData.phone,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  )
                ]),
                Spacer(),
                _getActionButton(widget.cachedUserData.relationship)
              ],
            )));
  }

  ElevatedButton _getActionButton(Relationship type) {
    switch (type) {
      case Relationship.noRelationship:
        {
          return ElevatedButton(
            onPressed: () => widget.onAddClicked(user: widget.cachedUserData),
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.teal, minimumSize: Size(112, 35)),
            child: Text(
              _AddKinTileConsts.addButtonCaption,
              style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: "Inter"),
            ),
          );
        }
      case Relationship.friendshipRequested:
        {
          return ElevatedButton(
            onPressed: () => widget.onCancelClicked(user: widget.cachedUserData),
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.grey, minimumSize: Size(112, 35)),
            child: Text(
              _AddKinTileConsts.cancelButtonCaption,
              style:
                  TextStyle(color: Colors.black.withAlpha(100), fontSize: 16, fontFamily: "Inter"),
            ),
          );
        }
      default:
        throw Exception("Case not implemented!");
    }
  }
}

class _AddKinTileConsts {
  static const String addButtonCaption = "הוספה";
  static const String cancelButtonCaption = "ביטול";
}
