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
  List<User> _users = [];
  User? activeUser;
  List<User> get users => _users;

  UserList() {
    updateAll();
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      await updateAll();
    });
  }

  UserList.params(List<User> users, User? user) {
    _users = users;
    activeUser = user ?? User("", "", "", 0, "");
  }

  Future<void> updateAll() async {
    List<User> updatedUsers = await HttpUtils.getOtherUsers();
    _users = updatedUsers;
    activeUser = await StorageUtils.fetchUser();
    notifyListeners();
  }

  static Future<UserList> getUserList() async {
    List<User> updatedUsers = await HttpUtils.getOtherUsers();
    User? activeUser = await StorageUtils.fetchUser();

    return UserList.params(updatedUsers, activeUser);
  }
}

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserList>(
        builder: (context, value, child) => Scaffold(
            body: Column(children: [PersonList(value.users)]),
            bottomSheet: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PurpleButton(
                    callback: onLogoutButtonClicked,
                    caption:
                        Consts.logoutButtonCaption(value.activeUser!.gender)),
                PurpleButton(
                    callback: onReportButtonClicked,
                    caption: Consts.reportButtonCaption(
                        value.activeUser!.nameHeb, value.activeUser!.gender))
              ],
            )));
  }

  void onReportButtonClicked() async {
    bool reportedSuccessfully = await HttpUtils.reportOkay();
    if (reportedSuccessfully) {
      Fluttertoast.showToast(msg: Consts.reportedSuccessfully);
    }
  }

  void onLogoutButtonClicked() async {
    debugPrint('logging out..');
    await StorageUtils.removeCredentials();
    RouterService.router.go(Routes.loginPage);
  }
}
