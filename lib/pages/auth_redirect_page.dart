import 'package:flutter/material.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/pages/login_page.dart';

class AuthRedirectPage extends StatelessWidget {
  final IFriendInteractionsProvider friendInteractionProvider;

  const AuthRedirectPage({required this.friendInteractionProvider, super.key});

  @override
  Widget build(BuildContext context) {
    return LoginPage();
    // return StreamBuilder<User?>(
    //   stream: FirebaseAuth.instance.authStateChanges(),
    //   builder: (context, snapshot) {
    //     return LoginPage();
    //     // if (!snapshot.hasData) {
    //     //   return LoginPage();
    //     // }

    //     // return HubPage(
    //     //   friendInteractionProvider: friendInteractionProvider,
    //     // );
    //   },
    // );
  }
}
