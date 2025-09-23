import 'dart:async';

import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/Utils/stream_utils.dart';
import 'package:im_okay/pages/kin/kin%20management/components/kin_page_title.dart';
import 'package:im_okay/pages/kin/shared/kin-button.dart';
import 'package:im_okay/pages/kin/shared/kin_tile_base.dart';

class IncomingKinRequestsPage extends StatefulWidget {
  final IKinInteractionsService friendInteractionProvider;

  const IncomingKinRequestsPage({required this.friendInteractionProvider, super.key});

  @override
  IncomingKinRequestsPageState createState() => IncomingKinRequestsPageState();
}

class IncomingKinRequestsPageState extends State<IncomingKinRequestsPage> {
  late StreamController<List<AppUser>> friendRequestStreamController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      KinPageTitle(
        title: KinRequestConsts.title,
      ),
      StreamBuilder<List<AppUser>>(
          initialData: const [],
          stream: StreamUtils.initStream(
              func: widget.friendInteractionProvider.getIncomingPendingRequests),
          builder: (context, snapshot) {
            AppUser user = AppUser(firstName: "טל", lastName: "כספי");
            AppUser user2 = AppUser(firstName: "נועם", lastName: "נחום");
            AppUser user3 = AppUser(firstName: "בן", lastName: "קאושנסקי");
            AppUser user4 = AppUser(firstName: "זיו", lastName: "קידר");
            List<AppUser> users = [user, user2, user3, user4];

            return Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 20,
                    children: users.map((user) {
                      return KinTileBase(
                          name: user.fullName,
                          whereTheConfirmDenyButtonsGo: Row(
                            spacing: 16,
                            children: [
                              KinButton(
                                type: KinButtonType.positiveAction,
                                caption: KinRequestConsts.approveButtonCaption,
                                onPressed: () {},
                              ),
                              KinButton(
                                type: KinButtonType.negativeAction,
                                caption: KinRequestConsts.denyButtonCaption,
                                onPressed: () {},
                              ),
                            ],
                          ));
                    }).toList()));
          })
    ]));
  }
}

class KinRequestConsts {
  static const String title = "בקשות חדשות";
  static const String approveButtonCaption = "אישור";
  static const String denyButtonCaption = "ביטול";
  static const String noPendingRequestsCaption = "אין בקשות ממתינות :)";
  static String alertZoneCaption(String alertZone) => "אזור ההתראה שלך: $alertZone";
}
