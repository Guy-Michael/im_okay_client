import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_okay_client/Models/user.dart';
import 'package:im_okay_client/Utils/Consts/consts.dart';
import 'package:im_okay_client/Utils/http_utils.dart';
import 'package:im_okay_client/Utils/storage_utils.dart';
import 'package:im_okay_client/Widgets/person_list.dart';
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

  Future<void> updateAll() async {
    List<User> updatedUsers = await HttpUtils.getOtherUsers();
    _users = updatedUsers;
    activeUser = await StorageUtils.fetchUser();
    notifyListeners();
  }
}

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          Consumer<UserList>(builder: (context, value, child) {
            return PersonList(value.users);
          })
        ]),
        bottomSheet: Container(
          height: 50,
          margin: const EdgeInsets.only(bottom: 50),
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            onPressed: onReportButtonClicked,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(300, 100),
              maximumSize: const Size(500, 300),
              backgroundColor: Colors.deepPurpleAccent,
            ),
            child: Text(
              ReportsPageConsts.reportButtonCaption(Gender.female),
              style: const TextStyle(fontSize: 25),
            ),
          ),
        ));
  }
}

void onReportButtonClicked() async {
  bool reportedSuccessfully = await HttpUtils.reportOkay();
  if (reportedSuccessfully) {
    Fluttertoast.showToast(msg: ReportsPageConsts.reportedSuccessfully);
  }
}
