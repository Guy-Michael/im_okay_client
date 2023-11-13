import 'package:flutter/material.dart';
import 'package:im_okay/pages/add_friends_page.dart';
import 'package:im_okay/pages/friend_requests_page.dart';
import 'package:im_okay/pages/reports_page.dart';
import 'package:im_okay/pages/settings.dart';

class HubPage extends StatefulWidget {
  const HubPage({super.key});

  @override
  State<StatefulWidget> createState() => HubPageState();
}

class HubPageState extends State<HubPage> {
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
        ),
        body: list[selectedIndex].widget,
        bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: (value) {
              setState(
                () {
                  selectedIndex = value;
                },
              );
            },
            backgroundColor: Colors.amber,
            destinations: list
                .map((e) => NavigationDestination(
                      label: e.label,
                      icon: Icon(e.icon),
                      selectedIcon: Icon(e.iconSelected),
                    ))
                .toList()));
  }
}

List<({Widget widget, String label, IconData icon, IconData iconSelected})>
    list = [
  (
    widget: const ReportsPage(),
    label: 'Home',
    icon: Icons.home_outlined,
    iconSelected: Icons.home
  ),
  (
    widget: const AddFriendsPage(),
    label: 'Add Friends',
    icon: Icons.plus_one_outlined,
    iconSelected: Icons.plus_one
  ),
  (
    widget: const FriendRequestsPage(),
    label: "Requests",
    icon: Icons.waves_outlined,
    iconSelected: Icons.waves
  ),
  (
    widget: const SettingsPage(),
    label: 'Settings',
    icon: Icons.settings_outlined,
    iconSelected: Icons.settings
  )
];
