import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';

class AddKinButton extends StatefulWidget {
  final AppUser user;

  Future<void> Function({required AppUser user}) onAddClicked;

  AddKinButton({
    super.key,
    required this.user,
    required this.onAddClicked,
  });

  @override
  State<StatefulWidget> createState() => AddKinButtonState();
}

class IFriendsInteractionsService {}

class AddKinButtonState extends State<AddKinButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          border: Border.all(color: Colors.black),
          gradient: LinearGradient(colors: [Colors.white, Colors.grey]),
          backgroundBlendMode: BlendMode.color,
        ),
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              spacing: 12,
              children: [
                Text("Image"),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(widget.user.fullName), Text("Phone")],
                ),
                Spacer(
                  flex: 1,
                ),
                ElevatedButton(
                  onPressed: () => widget.onAddClicked(user: widget.user),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal, minimumSize: Size(112, 35)),
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )));
  }
}
