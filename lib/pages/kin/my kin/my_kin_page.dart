import 'dart:async';

import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/ikin_interaction_service.dart';
import 'package:im_okay/Utils/stream_utils.dart';
import 'package:im_okay/pages/kin/empty_kin_page/empty_kin_page.dart';
import 'package:im_okay/pages/kin/kin%20page%20base/kin_page_base.dart';
import 'package:im_okay/pages/kin/my%20kin/my_kin_tile.dart';

class MyKinPage extends StatefulWidget {
  final IKinInteractionsService kinInteractionsService;
  const MyKinPage({super.key, required this.kinInteractionsService});

  @override
  State<StatefulWidget> createState() => MyKinPageState();
}

class MyKinPageState extends State<MyKinPage> {
  @override
  Widget build(BuildContext context) {
    StreamController<List<AppUser>> streamController = StreamUtils.initStreamController(
        duration: Duration(seconds: 10), func: widget.kinInteractionsService.getAllFriends);

    return StreamBuilder<List<AppUser>>(
        stream: streamController.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.isEmpty) {
            return EmptyKinPage(
              title: _MyKinPageConsts.title,
              subtitle: _MyKinPageConsts.emptyPageSubtitle,
              helpText: _MyKinPageConsts.emptyPageHelpText,
              showAddKinButton: true,
            );
          }

          List<MyKinTile> list = snapshot.data!.map((user) => MyKinTile(user: user)).toList();

          return KinPageBase(
            title: _MyKinPageConsts.title,
            list: list,
          );
        });
  }
}

class _MyKinPageConsts {
  static final String title = "הקרובים שלי";
  static final String emptyPageSubtitle = "כאן יופיעו הקרובים שלך";
  static final String emptyPageHelpText = "הוסיפו קרובים כדי להתעדכן בשלומם בעת אזעקה";
  static final String emptyPageActionCaption = "הוספת קרובים";
}
