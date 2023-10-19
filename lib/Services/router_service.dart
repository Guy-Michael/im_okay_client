import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:im_okay_client/Utils/Consts/consts.dart';
import 'package:im_okay_client/Widgets/contact_list.dart';
import 'package:im_okay_client/main.dart';
import 'package:im_okay_client/pages/add_friends_page.dart';
import 'package:im_okay_client/pages/login_page.dart';
import 'package:im_okay_client/pages/register_page.dart';
import 'package:im_okay_client/pages/reports_page.dart';
import 'package:provider/provider.dart';

class RouterService {
  static GoRouter router = GoRouter(
    initialLocation: Routes.loginPage,
    overridePlatformDefaultLocation: true,
    routes: [
      GoRoute(
          path: Routes.loginPage,
          builder: (context, state) {
            return LoginPage();
          }),
      GoRoute(
          path: Routes.reportsPage,
          builder: (context, state) => FutureProvider<UserList?>(
                initialData: UserList.params([], null),
                create: (context) => UserList.getUserList(),
                child: const ReportsPage(),
              )),
      GoRoute(
        path: Routes.registrationPage,
        builder: (context, state) => RegisterPage(),
      ),
      GoRoute(
        path: Routes.contactsPage,
        builder: (context, state) => const ContactListPage(),
      ),
      GoRoute(
          path: Routes.addFriendsPage,
          builder: (context, state) => const AddFriendsPage()),
    ],
  );

  static void routeFromIndex(int index) {
    router.push(Routes.fromInt(index));
  }
}
