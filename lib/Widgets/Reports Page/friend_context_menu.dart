import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:im_okay/Models/user.dart';

class FriendContextMenu extends StatefulWidget {
  final AppUser user;
  const FriendContextMenu({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => FriendContextMenuState();
}

class FriendContextMenuState extends State<FriendContextMenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(dropdownMenuEntries: [
      DropdownMenuEntry(label: "PING ${widget.user.firstName}", value: {}),
      DropdownMenuEntry(label: "UNFRIEND ${widget.user.firstName}", value: {})
    ]);
  }
}
