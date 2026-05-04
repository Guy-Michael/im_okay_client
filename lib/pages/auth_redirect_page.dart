import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Services/AuthenticationService/i_authentication_service.dart';
import 'package:im_okay/Routers/global_router.dart';
import 'package:im_okay/Services/service_injector.dart';
import 'package:im_okay/Utils/Consts/consts.dart';

class AuthRedirectPage extends StatelessWidget {
  late IAuthenticationService _authService;

  AuthRedirectPage({super.key}) {
    _authService = serviceInjector.get<IAuthenticationService>();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future(),
      builder: (context, snapshot) {
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<void> future() async {
    AppUser? appUser = await _authService.fetchUser();
    if (appUser != null) {
      await globalRouter.replaceNamed(Routes.kin.kinManagement);
    } else {
      await globalRouter.replace(Routes.auth.login);
    }
  }
}
