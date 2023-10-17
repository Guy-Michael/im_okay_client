import 'package:go_router/go_router.dart';
import 'package:im_okay_client/Utils/Consts/consts.dart';
import 'package:im_okay_client/pages/login_page.dart';
import 'package:im_okay_client/pages/register_page.dart';
import 'package:im_okay_client/pages/reports_page.dart';
import 'package:provider/provider.dart';

class RouterService {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
          path: Routes.loginPage,
          builder: (context, state) => const LoginPage()),
      GoRoute(
          path: Routes.reportsPage,
          builder: (context, state) => FutureProvider<UserList?>(
                initialData: UserList.params([], null),
                create: (context) => UserList.getUserList(),
                child: const ReportsPage(),
              )),
      GoRoute(
        path: Routes.registrationPage,
        builder: (context, state) => RegisterPage(),
      )
    ],
  );
}
