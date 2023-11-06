import 'package:flutter/material.dart';
import 'package:im_okay/Models/user.dart';
import 'package:im_okay/Services/API%20Services/friend_request_api_service.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/Utils/http_utils.dart';
import 'package:im_okay/Widgets/Reports%20Page/friend.dart';
import 'package:im_okay/Widgets/purple_button.dart';
import 'package:provider/provider.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureProvider<(User, List<User>)>(
        initialData: (const User(), const []),
        create: (context) async {
          List<User> users = await FriendInteractionsApiService.getAllFriends();
          User activeUser = await HttpUtils.getFullLoggedInUserData();
          return (activeUser, users);
        },
        catchError: (context, error) {
          debugPrint("Unable to load anything.");
          return (const User(), const []);
        },
        child: Scaffold(body:
            Consumer<(User, List<User>)>(builder: (context, value, child) {
          debugPrint(value.$1.toJson().toString());

          User activeUser = value.$1;
          List<User> users = value.$2;

          return Scaffold(
              body: ListView(
                  children: users.map((User user) {
                return FriendReport(
                    name: user.firstName, lastSeen: user.lastSeen);
              }).toList()),
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
        })));
  }

  void onReportButtonClicked() async {
    await FriendInteractionsApiService.reportOkay();
  }
}
