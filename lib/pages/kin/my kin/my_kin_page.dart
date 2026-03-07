import 'package:flutter/material.dart';
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
    Text phoneNumber = Text("0548045705");

    final MyKinTile tile = MyKinTile(
      name: "טל כספי",
      whereTheConfirmDenyButtonsGo: phoneNumber,
    );

    List<MyKinTile> list = [tile, tile, tile, tile, tile, tile];

    return KinPageBase(
      title: _MyKinPageConsts.title,
      list: list,
    );
  }
}

class _MyKinPageConsts {
  static final String title = "הקרובים שלי";
}
