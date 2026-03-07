import 'package:flutter/material.dart';
import 'package:im_okay/pages/kin/kin%20management/components/kin_page_title.dart';
// import 'package:im_okay/pages/kin/shared/kin_page_title.dart';

class KinPageBase extends StatefulWidget {
  String title;
  List<Widget> list;
  bool displaySearchBar;
  String? searchBarHint;
  String? kinListHint;

  KinPageBase(
      {required this.title,
      required this.list,
      this.displaySearchBar = true,
      this.searchBarHint,
      this.kinListHint,
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
        SearchAnchor.bar(
          suggestionsBuilder: (context, controller) {
            return [];
          },
          barHintText: widget.searchBarHint,
        ),
      Divider(
        thickness: 1,
      ),
      Expanded(
          child: SingleChildScrollView(
              child: Column(
        spacing: 16,
        children: widget.list,
      )))
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
