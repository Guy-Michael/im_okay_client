import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
import 'package:im_okay/Services/Logger/my_logger.dart';
import 'package:im_okay/Services/router_service.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/pages/hub_page.dart';
import 'package:im_okay/pages/login_page.dart';

class AuthRedirectPage extends StatelessWidget {
  final IKinInteractionsService friendInteractionProvider;

  const AuthRedirectPage({required this.friendInteractionProvider, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future(),
      builder: (context, snapshot) {
        // if (!snapshot.hasData || snapshot.data == null) {
        //   return LoginPage();
        // }

        // globalRouter.pushReplacement(Routes.reportsPage);

        return Center(child: CircularProgressIndicator());

        // return HubPage(friendInteractionProvider: friendInteractionProvider);
      },
    );
  }
}

Future<void> future() async {
  AppUser? appUser = await UserAuthenticationApiService.fetchUser();
  if (appUser != null) {
    logger.log('user exists!');
    await globalRouter.replace(Routes.hub);
  } else {
    logger.log('user does not exist!');
    await globalRouter.replace(Routes.login);
  }
}
