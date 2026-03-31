import 'dart:async';

import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/ikin_interaction_service.dart';
import 'package:im_okay/Utils/stream_utils.dart';
import 'package:im_okay/pages/kin/empty_kin_page/empty_kin_page.dart';
import 'package:im_okay/pages/kin/incoming%20kin%20requests/incoming_kin_request_tile.dart';
import 'package:im_okay/pages/kin/kin%20page%20base/kin_page_base.dart';

class IncomingKinRequestsPage extends StatefulWidget {
  final IKinInteractionsService friendInteractionProvider;

  const IncomingKinRequestsPage({required this.friendInteractionProvider, super.key});

  @override
  IncomingKinRequestsPageState createState() => IncomingKinRequestsPageState();
}

class IncomingKinRequestsPageState extends State<IncomingKinRequestsPage> {
  late StreamController<List<AppUser>>? friendRequestStreamController;

  @override
  void initState() {
    super.initState();
    friendRequestStreamController = StreamUtils.initStreamController(
        func: widget.friendInteractionProvider.getIncomingPendingRequests,
        duration: Duration(seconds: 5));
  }

  @override
  void dispose() {
    friendRequestStreamController?.close();
    friendRequestStreamController = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: friendRequestStreamController?.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || (snapshot.hasData && snapshot.data!.isEmpty)) {
          return EmptyKinPage(
            helpText: _KinRequestConsts.emptyPageHelpText,
            subtitle: _KinRequestConsts.emptyPageSubtitle,
            title: _KinRequestConsts.title,
          );
        }

        return KinPageBase(
            title: _KinRequestConsts.title,
            list: snapshot.data!
                .map<IncomingKinRequestTile>((user) => IncomingKinRequestTile(
                      user: user,
                      onConfirm: () =>
                          widget.friendInteractionProvider.respondToKinRequest(user, true),
                      onDeny: () =>
                          widget.friendInteractionProvider.respondToKinRequest(user, false),
                    ))
                .toList());
      },
    );
  }
}

class _KinRequestConsts {
  static const String title = "בקשות חדשות";
  static const String noPendingRequestsCaption = "אין בקשות ממתינות :)";
  static final String emptyPageSubtitle = "אין כרגע בקשות חדשות";
  static final String emptyPageHelpText = "כאשר יגיעו בקשות חדשות, הן יופיעו כאן";
  static String alertZoneCaption(String alertZone) => "אזור ההתראה שלך: $alertZone";
}
