import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:im_okay_client/Utils/Consts/consts.dart';
import 'package:im_okay_client/pages/auth_redirect_page.dart';
import 'package:im_okay_client/pages/hub_page.dart';
import 'package:im_okay_client/pages/register_page.dart';

final _rootNavigationKey = GlobalKey<NavigatorState>();

final GoRouter globalRouter = GoRouter(
  initialLocation: Routes.authRedirectPage,
  navigatorKey: _rootNavigationKey,
  routes: [
    GoRoute(
        path: Routes.authRedirectPage,
        parentNavigatorKey: _rootNavigationKey,
        builder: (context, state) => const AuthRedirectPage()),
    GoRoute(
      parentNavigatorKey: _rootNavigationKey,
      path: Routes.registrationPage,
      builder: (context, state) => RegisterPage(),
    ),
    GoRoute(
        parentNavigatorKey: _rootNavigationKey,
        path: Routes.hub,
        builder: (context, state) => const HubPage())
  ],
);
