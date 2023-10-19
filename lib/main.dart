import 'package:flutter/material.dart';
import 'package:im_okay_client/Services/router_service.dart';
import 'package:im_okay_client/Utils/Consts/consts.dart';
import 'package:im_okay_client/Utils/http_utils.dart';
import 'package:im_okay_client/pages/add_friends_page.dart';
import 'package:im_okay_client/pages/login_page.dart';
import 'package:im_okay_client/pages/reports_page.dart';

void main() async {
  RouterService.router;
  runApp(MaterialApp.router(
      routerConfig: RouterService.router,
      builder: (context, child) => ImOkayApp()));
}

class ImOkayApp extends StatefulWidget {
  const ImOkayApp({super.key});

  @override
  State<StatefulWidget> createState() => ImOkayAppState();
}

class ImOkayAppState extends State<ImOkayApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AddFriendsPage());
  }
}
