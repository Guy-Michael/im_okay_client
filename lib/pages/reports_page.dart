import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_okay_client/Models/user.dart';
import 'package:im_okay_client/Services/router_service.dart';
import 'package:im_okay_client/Utils/Consts/consts.dart';
import 'package:im_okay_client/Utils/http_utils.dart';
import 'package:im_okay_client/Widgets/Reports%20Page/friend.dart';
import 'package:im_okay_client/Widgets/purple_button.dart';
import 'package:provider/provider.dart';

// class UserList extends ChangeNotifier {
//   late List<User> users;
//   UserList({this.users = const []}) {
//     updateAll();

//     Timer.periodic(const Duration(seconds: 5), (timer) async {
//       // await updateAll();
//     });
//   }

//   Future<void> updateAll() async {
//     List<User> updatedUsers = await HttpUtils.getAllFriends();
//     users = updatedUsers;
//     activeUser = (await StorageUtils.fetchUser());
//     notifyListeners();
//   }

//   static Future<UserList> getUserList() async {
//     List<User> updatedUsers = await HttpUtils.getAllFriends();
//     User activeUser = (await StorageUtils.fetchUser());
//     return UserList(users: updatedUsers, activeUser: activeUser);
//   }
// }

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureProvider<(Map<String, dynamic>?, List<User>)>(
        initialData: (null, const []),
        create: (context) async {
          List<User> users = await HttpUtils.getAllFriends();
          var idTokenResult =
              await auth.FirebaseAuth.instance.currentUser?.getIdTokenResult();

          return (idTokenResult?.claims, users);
        },
        catchError: (context, error) {
          return (null, const []);
        },
        child: Scaffold(body: Consumer<(Map<String, dynamic>?, List<User>)>(
            builder: (context, value, child) {
          String firstName = value.$1?['firstName'];
          String lastName = value.$1?['lastName'];
          String gender = value.$1?['gender'];
          String fullName = "$firstName $lastName";

          return Scaffold(
              body: ListView(
                  children: value.$2.map((User user) {
                return Friend(name: user.firstName, lastSeen: user.lastSeen);
              }).toList()),
              bottomSheet: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PurpleButton(
                      callback: onLogoutButtonClicked,
                      caption: Consts.logoutButtonCaption(gender)),
                  const SizedBox(width: 20),
                  PurpleButton(
                      callback: onReportButtonClicked,
                      caption: Consts.reportButtonCaption(fullName, gender))
                ],
              ));
        })));
  }

  void onReportButtonClicked() async {
    bool reportedSuccessfully = await HttpUtils.reportOkay();
    if (reportedSuccessfully) {
      Fluttertoast.showToast(msg: Consts.reportedSuccessfully);
    }
  }

  void onLogoutButtonClicked() async {
    await auth.FirebaseAuth.instance.signOut();

    // await StorageUtils.removeCredentials();
    globalRouter.push(Routes.authRedirectPage);
  }

  void onAddFriendsButtonClicked() async {
    globalRouter.push(Routes.addFriendsPage);
  }
}
