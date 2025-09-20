import 'dart:async';

import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/Utils/stream_utils.dart';
import 'package:im_okay/pages/kin/kin%20management/components/kin_page_title.dart';
import 'package:im_okay/pages/kin/kin%20requests/components/pending_kin_request.dart';

class KinRequestsPage extends StatefulWidget {
  final IKinInteractionsService friendInteractionProvider;

  const KinRequestsPage({required this.friendInteractionProvider, super.key});

  @override
  KinRequestsPageState createState() => KinRequestsPageState();
}

class KinRequestsPageState extends State<KinRequestsPage> {
  late StreamController<List<AppUser>> friendRequestStreamController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
          child: KinPageTitle(
        title: KinRequestConsts.title,
      )),
      StreamBuilder<List<AppUser>>(
          initialData: const [],
          stream: StreamUtils.initStream(
              func: widget.friendInteractionProvider.getIncomingPendingRequests),
          builder: (context, snapshot) {
            AppUser user = AppUser(firstName: "טל", lastName: "כספי");
            AppUser user2 = AppUser(firstName: "נועם", lastName: "נחום");
            AppUser user3 = AppUser(firstName: "בן", lastName: "קאושנסקי");
            AppUser user4 = AppUser(firstName: "זיו", lastName: "קידר");
            return Center(
                child:
                    Column(crossAxisAlignment: CrossAxisAlignment.center, spacing: 20, children: [
              PendingKinRequest(user: user),
              PendingKinRequest(user: user2),
              PendingKinRequest(user: user3),
              PendingKinRequest(user: user4),
            ]));
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
