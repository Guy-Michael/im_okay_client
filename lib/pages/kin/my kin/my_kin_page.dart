import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/pages/kin/incoming%20kin%20requests/incoming_kin_requests_page.dart';
import 'package:im_okay/pages/kin/shared/kin_tile_base.dart';

class MyKinPage extends StatefulWidget {
  const MyKinPage({super.key});

  @override
  State<StatefulWidget> createState() => MyKinPageState();
}

class MyKinPageState extends State<MyKinPage> {
  @override
  Widget build(BuildContext context) {
    Text phoneNumber = Text("0548045705");

    return KinTileBase(
      name: "טל כספי",
      whereTheConfirmDenyButtonsGo: phoneNumber,
    );
  }
}
