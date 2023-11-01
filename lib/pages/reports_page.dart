import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:im_okay/Models/user.dart';
import 'package:im_okay/Services/router_service.dart';
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
          List<User> users = await HttpUtils.getAllFriends();
          User activeUser = await HttpUtils.getFullLoggedInUserData();
          return (activeUser, users);
        },
        catchError: (context, error) {
          debugPrint("Unable to load anything.");
          return (const User(), const []);
        },
        child: Scaffold(body:
            Consumer<(User, List<User>)>(builder: (context, value, child) {
          debugPrint("yes");
          User activeUser = value.$1;
          List<User> users = value.$2;

          return Scaffold(
              body: ListView(
                  children: users.map((User user) {
                return Friend(name: user.firstName, lastSeen: user.lastSeen);
              }).toList()),
              bottomSheet: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PurpleButton(
                      callback: onLogoutButtonClicked,
                      caption: Consts.logoutButtonCaption(activeUser.gender)),
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
    var user = auth.FirebaseAuth.instance.currentUser;
    String? uid = user?.uid;
    String? authToken = await user?.getIdToken();

    // String? fcmToken = await FirebaseMessaging.instance.getToken() ?? "Rweq";
    debugPrint("uid: $uid \n device token: fcmToken \n authToken: $authToken");
    // bool reportedSuccessfully = await HttpUtils.reportOkay();
    // if (reportedSuccessfully) {
    //   // Fluttertoast.showToast(msg: Consts.reportedSuccessfully);
    // }
  }

  void onLogoutButtonClicked() async {
    await auth.FirebaseAuth.instance.signOut();
    globalRouter.push(Routes.authRedirectPage);
  }
}
