import 'package:flutter/material.dart';

class UserTileColumn extends StatefulWidget {
  List<Widget> tiles;

  UserTileColumn({super.key, required this.tiles});

  @override
  State<UserTileColumn> createState() => _UserTileColumnState();
}

class _UserTileColumnState extends State<UserTileColumn> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
            child: Column(
      spacing: 16,
      children: widget.tiles,
    )));
  }
}
