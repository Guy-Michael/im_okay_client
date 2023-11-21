import 'package:flutter/material.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
import 'package:im_okay/pages/hub_page.dart';
import 'package:im_okay/pages/login_page.dart';

class AuthRedirectPage extends StatelessWidget {
  final IFriendInteractionsProvider friendInteractionProvider;

  const AuthRedirectPage({required this.friendInteractionProvider, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(future: () async {
        bool authenticated = await UserAuthenticationApiService.appUser != null;

        return authenticated;
      }(), builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        return (snapshot.hasData && snapshot.data!)
            ? HubPage(
                friendInteractionProvider: friendInteractionProvider,
              )
            : const LoginPage();
      }),
    );
  }
}
