import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_service.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/pages/home/home_page.dart';
import 'package:im_okay/pages/kin/kin management/kin_management_page.dart';
import 'package:im_okay/pages/auth_redirect_page.dart';
import 'package:im_okay/pages/kin/kin%20requests/kin_requests_page.dart';
import 'package:im_okay/pages/kin/my%20kin/add_kin_page.dart';
import 'package:im_okay/pages/login_page.dart';
import 'package:im_okay/pages/new_hub_page.dart';
import 'package:im_okay/pages/settings.dart';

final _rootNavigationKey = GlobalKey<NavigatorState>();
final _friendInteractionProvider = KinInteractionsApiService();

final GoRouter globalRouter = GoRouter(
  initialLocation: Routes.auth.authRedirectPage,
  navigatorKey: _rootNavigationKey,
  routes: [
    GoRoute(
      parentNavigatorKey: _rootNavigationKey,
      path: Routes.auth.authRedirectPage,
      builder: (context, state) =>
          AuthRedirectPage(friendInteractionProvider: _friendInteractionProvider),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigationKey,
      path: Routes.auth.login,
      builder: (context, state) => LoginPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return NewHubPage(
          friendInteractionProvider: _friendInteractionProvider,
          child: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          initialLocation: Routes.kin.kinManagement,
          routes: [
            GoRoute(
                path: Routes.kin.kinManagement,
                name: Routes.kin.kinManagement,
                builder: (context, state) => KinManagementPage(),
                routes: [
                  GoRoute(
                    path: Routes.kin.addKinPage,
                    name: Routes.kin.addKinPage,
                    builder: (context, state) => AddKinPage(
                      friendInteractionProvider: _friendInteractionProvider,
                    ),
                  ),
                  GoRoute(
                    path: Routes.kin.kinRequestsPage,
                    name: Routes.kin.kinRequestsPage,
                    builder: (context, state) => KinRequestsPage(
                      friendInteractionProvider: _friendInteractionProvider,
                    ),
                  ),
                ]),
          ],
        ),
        StatefulShellBranch(
          initialLocation: Routes.settings,
          routes: [
            GoRoute(
              path: Routes.settings,
              name: Routes.settings,
              builder: (context, state) => SettingsPage(),
            )
          ],
        ),
        StatefulShellBranch(routes: [
          GoRoute(path: Routes.home, name: Routes.home, builder: (context, state) => HomePage())
        ])
      ],
    ),
  ],
);
