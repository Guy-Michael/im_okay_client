import 'package:flutter/material.dart';
import 'package:im_okay_client/Pages/reports_page.dart';
import 'package:im_okay_client/Utils/http_utils.dart';
import 'package:im_okay_client/Utils/storage_utils.dart';
import 'package:im_okay_client/Widgets/app_bar.dart';
import 'package:im_okay_client/Pages/login_page.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  runApp(const ImOkayApp());
}

class ImOkayApp extends StatefulWidget {
  const ImOkayApp({super.key});

  @override
  State<StatefulWidget> createState() => ImOkayAppState();
}

class ImOkayAppState extends State<ImOkayApp> {
  late Future<bool> futureLoggedIn;

  @override
  void initState() {
    super.initState();
    futureLoggedIn = HttpUtils.validateLoginOnStartup();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: const ReportsPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/reports': (context) => const ReportsPage()
      },
      builder: (context, child) => Base(
          child: FutureBuilder<bool>(
        future: futureLoggedIn,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!) {
            debugPrint('access token is: ${snapshot.data!}');
            return const ReportsPage();
          } else {
            return const LoginPage();
          }
        },
      )),
    );
  }
}
