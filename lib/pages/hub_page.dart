import 'package:flutter/material.dart';
import 'package:im_okay/Services/API Services/Friend Interaction Service/friend_interactions_api_provider.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/pages/add_friends_page.dart';
import 'package:im_okay/pages/friend_requests_page.dart';
import 'package:im_okay/pages/reports_page.dart';
import 'package:im_okay/pages/settings.dart';

class HubPage extends StatefulWidget {
  final IFriendInteractionsProvider friendInteractionProvider;

  const HubPage({required this.friendInteractionProvider, super.key});

  @override
  State<StatefulWidget> createState() => HubPageState();
}

class HubPageState extends State<HubPage> {
  int selectedIndex = 0;
  late ReportsPage reportsPage;
  late SettingsPage settingsPage;
  late AddFriendsPage addFriendsPage;
  late FriendRequestsPage friendRequestsPage;

  @override
  void initState() {
    super.initState();
    reportsPage = ReportsPage(friendInteractionProvider: widget.friendInteractionProvider);
    settingsPage = const SettingsPage();
    addFriendsPage = AddFriendsPage(friendInteractionProvider: widget.friendInteractionProvider);
    friendRequestsPage =
        FriendRequestsPage(friendInteractionProvider: widget.friendInteractionProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(Consts.appName),
          backgroundColor: const Color.fromARGB(255, 157, 100, 255),
        ),
        body: _getBottomNavigationWidgets()[selectedIndex].page,
        bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: (value) {
              setState(
                () {
                  selectedIndex = value;
                },
              );
            },
            backgroundColor: const Color.fromARGB(255, 157, 100, 255),
            destinations: _getBottomNavigationWidgets()
                .map((e) => NavigationDestination(
                      label: e.label,
                      icon: Icon(e.icon),
                      selectedIcon: Icon(e.iconSelected),
                    ))
                .toList()));
  }

  List<({Widget page, String label, IconData icon, IconData iconSelected})>
      _getBottomNavigationWidgets() => [
            (
              page: reportsPage,
              label: BottomNavbarConsts.homeButtonCaption,
              icon: Icons.home_outlined,
              iconSelected: Icons.home
            ),
            (
              page: addFriendsPage,
              label: BottomNavbarConsts.addFriendsButtonCaption,
              icon: Icons.plus_one_outlined,
              iconSelected: Icons.plus_one
            ),
            (
              page: friendRequestsPage,
              label: BottomNavbarConsts.requestsButtonCaption,
              icon: Icons.waves_outlined,
              iconSelected: Icons.waves
            ),
            (
              page: settingsPage,
              label: BottomNavbarConsts.settingsButtonCaption,
              icon: Icons.settings_outlined,
              iconSelected: Icons.settings
            )
          ];
}

class BottomNavbarConsts {
  static final String homeButtonCaption = "שיתופים";
  static final String addFriendsButtonCaption = "מצא חברים";
  static final String requestsButtonCaption = "בקשות";
  static final String settingsButtonCaption = "הגדרות";
}
