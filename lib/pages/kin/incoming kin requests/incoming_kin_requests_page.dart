import 'dart:async';

import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/pages/kin/empty_kin_page/empty_kin_page.dart';
import 'package:im_okay/pages/kin/incoming%20kin%20requests/incoming_kin_request_tile.dart';
import 'package:im_okay/pages/kin/kin%20page%20base/kin_page_base.dart';
import 'package:im_okay/pages/kin/shared/kin_button.dart';

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
    AppUser user = AppUser(firstName: "טל", lastName: "כספי");
    AppUser user2 = AppUser(firstName: "נועם", lastName: "נחום");
    AppUser user3 = AppUser(firstName: "בן", lastName: "קאושנסקי");
    AppUser user4 = AppUser(firstName: "זיו", lastName: "קידר");
    List<AppUser> users = [user, user2, user3, user4];
    // List<AppUser> users = [];

    if (users.isEmpty) {
      return EmptyKinPage(
        helpText: _KinRequestConsts.emptyPageHelpText,
        subtitle: _KinRequestConsts.emptyPageSubtitle,
        title: _KinRequestConsts.title,
      );
    }

    return KinPageBase(
        title: _KinRequestConsts.title,
        list: users
            .map<IncomingKinRequestTile>((user) => IncomingKinRequestTile(
                  name: user.fullName,
                  whereTheConfirmDenyButtonsGo: Row(
                    spacing: 16,
                    children: [
                      KinButton(
                        type: KinButtonType.positiveAction,
                        caption: _KinRequestConsts.approveButtonCaption,
                        onPressed: () {},
                      ),
                      KinButton(
                        type: KinButtonType.negativeAction,
                        caption: _KinRequestConsts.denyButtonCaption,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ))
            .toList());
  }
}

class _KinRequestConsts {
  static const String title = "בקשות חדשות";
  static const String approveButtonCaption = "אישור";
  static const String denyButtonCaption = "ביטול";
  static const String noPendingRequestsCaption = "אין בקשות ממתינות :)";
  static final String emptyPageSubtitle = "אין כרגע בקשות חדשות";
  static final String emptyPageHelpText = "כאשר יגיעו בקשות חדשות, הן יופיעו כאן";
  static String alertZoneCaption(String alertZone) => "אזור ההתראה שלך: $alertZone";
}
