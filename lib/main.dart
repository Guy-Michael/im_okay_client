import 'package:flutter/material.dart';
import 'package:im_okay_client/Services/router_service.dart';
import 'package:im_okay_client/pages/login_page.dart';

void main() async {
  globalRouter;
  runApp(const MaterialApp(home: ImOkayApp()));
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
    return MaterialApp.router(routerConfig: globalRouter);
    // builder: (context, child) =>
    //     Scaffold(body: LoginPage(key: widget.key)));
  }
}
