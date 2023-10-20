import 'package:flutter/material.dart';
import 'package:im_okay_client/pages/add_friends_page.dart';
import 'package:im_okay_client/pages/reports_page.dart';

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
            onDestinationSelected: (value) {
              setState(
                () {
                  selectedIndex = value;
                },
              );
            },
            backgroundColor: Colors.amber,
            destinations: list
                .map((e) =>
                    NavigationDestination(label: e.label, icon: Icon(e.icon)))
                .toList()));
  }
}

List<({Widget widget, String label, IconData icon})> list = [
  const (widget: ReportsPage(), label: 'Home', icon: Icons.home),
  const (widget: AddFriendsPage(), label: 'Add Friends', icon: Icons.plus_one),
  const (widget: AddFriendsPage(), label: 'Settings', icon: Icons.settings),
];
