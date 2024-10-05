import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/pages/hub_page.dart';

class AuthRedirectPage extends StatelessWidget {
  final IFriendInteractionsProvider friendInteractionProvider;

  const AuthRedirectPage({required this.friendInteractionProvider, super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            desktopLayoutDirection: TextDirection.rtl,
            showAuthActionSwitch: false,
            subtitleBuilder: (context, action) {
              return Container();
            },
            providers: [GoogleProvider(clientId: "WEB")],
            actions: [],
          );
        }

        return HubPage(
          friendInteractionProvider: friendInteractionProvider,
        );
      },
    );
    // return Scaffold(
    //   body: FutureBuilder<bool>(future: () async {
    //     bool authenticated = await UserAuthenticationApiService.appUser != null;

    //     return authenticated;
    //   }(), builder: (context, snapshot) {
    //     if (!snapshot.hasData) {
    //       return const Center(child: CircularProgressIndicator.adaptive());
    //     }
    //     return (snapshot.hasData && snapshot.data!)
    //         ? HubPage(
    //             friendInteractionProvider: friendInteractionProvider,
    //           )
    //         : const LoginPage();
    //   }),
    // );
  }
}
