import 'package:go_router/go_router.dart';
import 'package:im_okay_client/Models/user.dart';
import 'package:im_okay_client/Utils/http_utils.dart';
import 'package:im_okay_client/Utils/storage_utils.dart';
import 'package:im_okay_client/pages/login_page.dart';
import 'package:im_okay_client/pages/reports_page.dart';
import 'package:provider/provider.dart';

class RouterService {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoginPage()),
      GoRoute(
          path: '/report',
          builder: (context, state) => FutureProvider<UserList?>(
                initialData: UserList.params([], null),
                create: (context) => UserList.getUserList(),
                child: const ReportsPage(),
              ))
    ],
  );
}
