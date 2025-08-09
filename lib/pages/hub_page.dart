import 'package:flutter/material.dart';
import 'package:im_okay/Services/API Services/Friend Interaction Service/friend_interactions_api_provider.dart';
import 'package:im_okay/Services/location_service.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/pages/Kin/Kin%20Management/kin_management_page.dart';
import 'package:im_okay/pages/add_friends_page.dart';
import 'package:im_okay/pages/kin_requests_page.dart';
import 'package:im_okay/pages/reports_page.dart';
import 'package:im_okay/pages/settings.dart';
import 'package:provider/provider.dart';

class HubPage extends StatefulWidget {
  final IFriendInteractionsProvider friendInteractionProvider;

  const HubPage({required this.friendInteractionProvider, super.key});

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
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          elevation: 0,
        ),
        body: Expanded(
            child: Container(
                margin: EdgeInsets.fromLTRB(16, 58, 16, 58),
                child: _getBottomNavigationWidgets()[selectedIndex].page)),
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
              page: ReportsPage(friendInteractionProvider: widget.friendInteractionProvider),
              // page: reportsPage,
              label: BottomNavbarConsts.homeButtonCaption,
              icon: Icons.home_outlined,
              iconSelected: Icons.home
            ),
            (
              page: KinManagementPage(),
              // page: AddFriendsPage(friendInteractionProvider: widget.friendInteractionProvider),
              // page: addFriendsPage,
              label: BottomNavbarConsts.addFriendsButtonCaption,
              icon: Icons.plus_one_outlined,
              iconSelected: Icons.plus_one
            ),
            (
              page: KinRequestsPage(friendInteractionProvider: widget.friendInteractionProvider),
              // page: friendRequestsPage,
              label: BottomNavbarConsts.requestsButtonCaption,
              icon: Icons.waves_outlined,
              iconSelected: Icons.waves
            ),
            (
              page: SettingsPage(),
              // page: settingsPage,
              label: BottomNavbarConsts.settingsButtonCaption,
              icon: Icons.settings_outlined,
              iconSelected: Icons.settings
            )
          ];
}

class BottomNavbarConsts {
  static const String homeButtonCaption = "שיתופים";
  static const String addFriendsButtonCaption = "מצא חברים";
  static const String requestsButtonCaption = "בקשות";
  static const String settingsButtonCaption = "הגדרות";
}
