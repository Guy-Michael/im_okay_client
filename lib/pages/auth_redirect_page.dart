import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:im_okay/Models/user.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
import 'package:im_okay/pages/hub_page.dart';
import 'package:im_okay/pages/login_page.dart';

class AuthRedirectPage extends StatelessWidget {
  final IFriendInteractionsProvider friendInteractionProvider;

  const AuthRedirectPage({required this.friendInteractionProvider, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppUser?>(
      future: UserAuthenticationApiService.fetchUser(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoginPage();
        }

        if (snapshot.data == null) {
          return LoginPage();
        }

        return HubPage(friendInteractionProvider: friendInteractionProvider);
      },
    );
  }
}
