import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_okay_client/Models/user.dart';
import 'package:im_okay_client/Services/router_service.dart';
import 'package:im_okay_client/Utils/Consts/consts.dart';
import 'package:im_okay_client/Utils/http_utils.dart';
import 'package:im_okay_client/Utils/storage_utils.dart';
import 'package:im_okay_client/Widgets/person_list.dart';
import 'package:im_okay_client/Widgets/purple_button.dart';
import 'package:provider/provider.dart';

class UserList extends ChangeNotifier {
  User activeUser = User(username: "test", nameHeb: "מבחן");
  List<User> users = [];

  UserList() {
    updateAll();
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      await updateAll();
    });
  }

  UserList.params({required this.users, User? activeUser}) {
    activeUser = activeUser ?? User();
  }

  Future<void> updateAll() async {
    List<User> updatedUsers = await HttpUtils.getOtherUsers();
    users = updatedUsers;
    activeUser = (await StorageUtils.fetchUser())!;
    notifyListeners();
  }

  static Future<UserList> getUserList() async {
    List<User> updatedUsers = await HttpUtils.getOtherUsers();
    User? activeUser = await StorageUtils.fetchUser();

    return UserList.params(users: updatedUsers, activeUser: activeUser);
  }
}

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureProvider<UserList>(
        initialData: UserList(),
        create: (context) async {
          List<User> users = await HttpUtils.getOtherUsers();
          return UserList.params(users: users);
        },
        child: Scaffold(
            body: Consumer<UserList>(
                builder: (context, value, child) => Scaffold(
                    body: ListView(children: [PersonList(value.users)]),
                    bottomSheet: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PurpleButton(
                            callback: onLogoutButtonClicked,
                            caption: Consts.logoutButtonCaption(
                                value.activeUser!.gender)),
                        const SizedBox(width: 20),
                        PurpleButton(
                            callback: onReportButtonClicked,
                            caption: Consts.reportButtonCaption(
                                value.activeUser!.nameHeb,
                                value.activeUser!.gender))
                      ],
                    )))));
  }

  void onReportButtonClicked() async {
    bool reportedSuccessfully = await HttpUtils.reportOkay();
    if (reportedSuccessfully) {
      Fluttertoast.showToast(msg: Consts.reportedSuccessfully);
    }
  }

  void onLogoutButtonClicked() async {
    await StorageUtils.removeCredentials();
    globalRouter.push(Routes.loginPage);
  }

  void onAddFriendsButtonClicked() async {
    globalRouter.push(Routes.addFriendsPage);
  }
}
