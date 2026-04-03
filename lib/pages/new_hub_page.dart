import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:im_okay/Utils/Consts/consts.dart';

class NewHubPage extends StatefulWidget {
  final Widget child;

  NewHubPage({required this.child, super.key});

  @override
  State<StatefulWidget> createState() => NewHubPageState();
}

class NewHubPageState extends State<NewHubPage> {
  int selectedIndex = 2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widget.child,
        bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: (value) {
              setState(() => selectedIndex = value);
              String route = _getBottomNavigationWidgets()[value].route;
              context.replaceNamed(route);
            },
            destinations: _getBottomNavigationWidgets()
                .map((e) => NavigationDestination(
                      label: e.label,
                      icon: Icon(e.icon),
                      selectedIcon: Icon(e.iconSelected),
                    ))
                .toList()));
  }

  List<({String route, String label, IconData icon, IconData iconSelected})>
      _getBottomNavigationWidgets() => [
            (
              route: Routes.settings,
              label: BottomNavbarConsts.settingsButtonCaption,
              icon: Icons.settings_outlined,
              iconSelected: Icons.settings
            ),
            (
              route: Routes.home,
              label: BottomNavbarConsts.homeButtonCaption,
              icon: Icons.home_outlined,
              iconSelected: Icons.home
            ),
            (
              route: Routes.kin.kinManagement,
              label: BottomNavbarConsts.kinManagement,
              icon: Icons.plus_one_outlined,
              iconSelected: Icons.plus_one
            ),
          ];
}

class BottomNavbarConsts {
  static const String homeButtonCaption = "בית";
  static const String kinManagement = "ניהול קרובים";
  static const String requestsButtonCaption = "בקשות";
  static const String settingsButtonCaption = "הגדרות";
}
