import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_service.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/pages/kin/kin management/kin_management_page.dart';
import 'package:im_okay/pages/auth_redirect_page.dart';
import 'package:im_okay/pages/hub_page.dart';
import 'package:im_okay/pages/kin/kin%20requests/kin_requests_page.dart';
import 'package:im_okay/pages/kin/my%20kin/add_kin_page.dart';
import 'package:im_okay/pages/login_page.dart';
import 'package:im_okay/pages/phone_verification_page.dart';

final _rootNavigationKey = GlobalKey<NavigatorState>();
final _friendInteractionProvider = KinInteractionsApiService();
final GoRouter globalRouter = GoRouter(
  initialLocation: Routes.authRedirectPage,
  navigatorKey: _rootNavigationKey,
  routes: [
    GoRoute(
      path: Routes.authRedirectPage,
      parentNavigatorKey: _rootNavigationKey,
      builder: (context, state) =>
          AuthRedirectPage(friendInteractionProvider: _friendInteractionProvider),
      // redirect:
    ),
    GoRoute(
        parentNavigatorKey: _rootNavigationKey,
        path: Routes.hub,
        builder: (context, state) =>
            HubPage(friendInteractionProvider: _friendInteractionProvider)),
    GoRoute(
      parentNavigatorKey: _rootNavigationKey,
      path: Routes.login,
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigationKey,
      path: Routes.phoneVerification,
      builder: (context, state) => PhoneVerificationPage(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigationKey,
      path: Routes.kinManagement,
      builder: (context, state) => KinManagementPage(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigationKey,
      path: Routes.addKinPage,
      builder: (context, state) => AddKinPage(
        friendInteractionProvider: _friendInteractionProvider,
      ),
    ),
    GoRoute(
        parentNavigatorKey: _rootNavigationKey,
        path: Routes.kinRequestsPage,
        builder: (context, state) => KinRequestsPage(
              friendInteractionProvider: _friendInteractionProvider,
            ))
  ],
);
