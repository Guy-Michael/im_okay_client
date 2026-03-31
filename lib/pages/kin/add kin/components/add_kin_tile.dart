import 'package:flutter/material.dart';
import 'package:im_okay/Enums/friend_query_type_enum.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Models/search_query_response.dart';

class AddKinTile extends StatefulWidget {
  final SearchQueryResponse queryResponse;

  Future<void> Function({required AppUser user}) onAddClicked;
  Future<void> Function({required AppUser user}) onCancelClicked;

  AddKinTile(
      {super.key,
      required this.queryResponse,
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
                      image:
                          DecorationImage(image: NetworkImage(widget.queryResponse.user.imageUrl))),
                )),
                Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 16, children: [
                  Text(
                    widget.queryResponse.user.fullName,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Text(
                    widget.queryResponse.user.phoneNumber,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  )
                ]),
                Spacer(),
                _getActionButton(widget.queryResponse.relationship)
              ],
            )));
  }

  ElevatedButton _getActionButton(FriendQueryType type) {
    switch (type) {
      case FriendQueryType.noRelationship:
        {
          return ElevatedButton(
            onPressed: () => widget.onAddClicked(user: widget.queryResponse.user),
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.teal, minimumSize: Size(112, 35)),
            child: Text(
              _AddKinTileConsts.addButtonCaption,
              style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: "Inter"),
            ),
          );
        }
      case FriendQueryType.friendshipRequested:
        {
          return ElevatedButton(
            onPressed: () => widget.onCancelClicked(user: widget.queryResponse.user),
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
