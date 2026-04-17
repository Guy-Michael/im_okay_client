import 'package:flutter/material.dart';
import 'package:im_okay/pages/kin/KinManagement/components/kin_page_title.dart';
import 'package:im_okay/pages/SharedComponents/user_tile_column.dart';

class KinPageBase extends StatefulWidget {
  String title;
  List<Widget> list;
  bool displaySearchBar;
  String? searchBarHint;
  String? kinListHint;
  Future<void> Function(String query)? onSubmitSearch;

  KinPageBase(
      {required this.title,
      required this.list,
      this.displaySearchBar = false,
      this.searchBarHint,
      this.kinListHint,
      this.onSubmitSearch,
      super.key});

  @override
  State<StatefulWidget> createState() => KinPageBaseState();
}

class KinPageBaseState extends State<KinPageBase> {
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      KinPageTitle(
        title: widget.title,
      ),
      if (widget.displaySearchBar)
        SearchBar(
          onChanged: (value) async {
            await widget.onSubmitSearch!(value);
          },
        ),
      Divider(
        thickness: 1,
      ),
      UserTileColumn(
        tiles: widget.list,
      )
    ];

    return Scaffold(
      appBar: AppBar(title: Text(KinPageBaseConsts.backButtonCaption)),
      body: Column(
        spacing: 12,
        children: list,
      ),
    );
  }
}

class KinPageBaseConsts {
  static const String backButtonCaption = "חזרה";
}
