import 'package:flutter/material.dart';
import 'package:im_okay/pages/kin/empty_kin_page/empty_kin_page.dart';
import 'package:im_okay/pages/kin/kin%20page%20base/kin_page_base.dart';
import 'package:im_okay/pages/kin/my%20kin/my_kin_tile.dart';

class MyKinPage extends StatefulWidget {
  const MyKinPage({super.key});

  @override
  State<StatefulWidget> createState() => MyKinPageState();
}

class MyKinPageState extends State<MyKinPage> {
  @override
  Widget build(BuildContext context) {
    String phoneNumber = "0548045705";

    final MyKinTile tile = MyKinTile(
      name: "טל כספי",
      phoneNumber: phoneNumber,
    );

    List<MyKinTile> list = [tile, tile, tile, tile, tile, tile];
    // List<MyKinTile> list = [];

    if (list.isEmpty) {
      return EmptyKinPage(
        title: _MyKinPageConsts.title,
        subtitle: _MyKinPageConsts.emptyPageSubtitle,
        helpText: _MyKinPageConsts.emptyPageHelpText,
        showAddKinButton: true,
      );
    }
    return KinPageBase(
      title: _MyKinPageConsts.title,
      list: list,
    );
  }
}

class _MyKinPageConsts {
  static final String title = "הקרובים שלי";
  static final String emptyPageSubtitle = "כאן יופיעו הקרובים שלך";
  static final String emptyPageHelpText = "הוסיפו קרובים כדי להתעדכן בשלומם בעת אזעקה";
  static final String emptyPageActionCaption = "הוספת קרובים";
}
