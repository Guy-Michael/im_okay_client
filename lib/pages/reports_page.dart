import 'dart:async';

import 'package:flutter/material.dart';
import 'package:im_okay/Models/user.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/Widgets/Reports%20Page/friend.dart';
import 'package:im_okay/Widgets/purple_button.dart';

class ReportsPage extends StatefulWidget {
  final IFriendInteractionsProvider friendInteractionProvider;

  const ReportsPage({required this.friendInteractionProvider, super.key});

  @override
  State<StatefulWidget> createState() => ReportsPageState();
}

class ReportsPageState extends State<ReportsPage> {
  @override
  Widget build(BuildContext context) {
    var builder = FutureBuilder<(User activeUser, List<User> friends)>(
      initialData: (const User(), List<User>.empty()),
      future: () async {
        Timer.periodic(const Duration(seconds: 5), (_) {
          setState(() {});
        });
        List<User> users =
            await widget.friendInteractionProvider.getAllFriends();
        User activeUser = (await UserAuthenticationApiService.appUser)!;
        return (activeUser, users);
      }(),
      builder: (context, snapshot) {
        User activeUser = snapshot.data!.$1;
        List<User> users = snapshot.data!.$2;
        if (activeUser.firstName == '' && users.isEmpty) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        return Scaffold(
            body: ListView(children: () {
              if (users.isEmpty) {
                return [const Center(child: Text("עוד לא הוספת חברים :)"))];
              }
              return users.map((User user) {
                return FriendReport(
                    name: user.firstName, lastSeen: user.lastSeen);
              }).toList();
            }()),
            bottomSheet: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 20),
                PurpleButton(
                    callback: onReportButtonClicked,
                    caption: Consts.reportButtonCaption(
                        activeUser.firstName, activeUser.gender))
              ],
            ));
      },
    );
    return builder;
  }

  void onReportButtonClicked() async {
    await widget.friendInteractionProvider.reportOkay();
  }
}
