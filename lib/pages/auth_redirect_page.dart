import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/pages/hub_page.dart';
import 'package:im_okay/pages/login_page.dart';

class AuthRedirectPage extends StatelessWidget {
  final IFriendInteractionsProvider friendInteractionProvider;

  const AuthRedirectPage({required this.friendInteractionProvider, super.key});

  @override
  Widget build(BuildContext context) {
    bool loggedIn = FirebaseAuth.instance.currentUser != null;
    if (loggedIn) {
      return HubPage(friendInteractionProvider: friendInteractionProvider);
    } else {
      return LoginPage();
    }
  }
}
