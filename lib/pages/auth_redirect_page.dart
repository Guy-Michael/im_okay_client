import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Services/AuthenticationService/i_authentication_service.dart';
import 'package:im_okay/Services/Logger/my_logger.dart';
import 'package:im_okay/Services/router_service.dart';
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
      logger.log('user exists!');
      await globalRouter.replaceNamed(Routes.kin.kinManagement);
    } else {
      logger.log('user does not exist!');
      await globalRouter.replace(Routes.auth.login);
    }
  }
}
