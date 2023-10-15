import 'package:flutter/material.dart';
import 'package:im_okay_client/Models/user.dart';
import 'package:im_okay_client/Utils/http_utils.dart';
import 'package:im_okay_client/Widgets/person_list.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<StatefulWidget> createState() => ReportsState();
}

class ReportsState extends State<ReportsPage> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = HttpUtils.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
              child: Container(
            alignment: Alignment.center,
            color: Colors.black,
          )),
          PersonList()
        ],
      ),
    );
  }
}
