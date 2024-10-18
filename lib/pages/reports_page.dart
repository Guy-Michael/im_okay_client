import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:im_okay/Models/user.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_service.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
import 'package:im_okay/Services/Notification%20Services/in_app_message_service.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/Widgets/Reports%20Page/friend_context_menu.dart';
import 'package:im_okay/Widgets/list_tile.dart';
import 'package:im_okay/Widgets/purple_button.dart';

Future<(AppUser? activeUser, List<AppUser> friends)> future(
    IFriendInteractionsProvider provider) async {
  List<AppUser> users = await provider.getAllFriends();
  AppUser? user = await UserAuthenticationApiService.appUser;
  return (user, users);
}

class ReportsPage extends StatefulWidget {
  final IFriendInteractionsProvider friendInteractionProvider;

  const ReportsPage({required this.friendInteractionProvider, super.key});

  @override
  State<StatefulWidget> createState() => ReportsPageState();
}

class ReportsPageState extends State<ReportsPage> {
  @override
  Widget build(BuildContext context) {
    var builder = FutureBuilder<(AppUser? activeUser, List<AppUser> friends)>(
      initialData: (new AppUser(), List<AppUser>.empty()),
      future: future(widget.friendInteractionProvider),
      builder: (context, snapshot) {
        AppUser? activeUser = snapshot.data?.$1;
        List<AppUser> users = snapshot.data?.$2 ?? [];

        return Scaffold(
            body: Wrap(
                textDirection: TextDirection.rtl,
                children: () {
                  if (users.isEmpty) {
                    return [const Center(heightFactor: 5, child: Text("עוד לא הוספת חברים :)"))];
                  }
                  GFListTileDirectional activeUserTile = GFListTileDirectional(
                    title: const Text("השיתוף האחרון שלי"),
                    direction: TextDirection.rtl,
                    margin: const EdgeInsets.fromLTRB(5, 1, 1, 5),
                    onLongPress: () {},
                    color: const Color.fromARGB(150, 170, 170, 170),
                    avatar: const Icon(Icons.person_rounded),
                    shadow: const BoxShadow(blurStyle: BlurStyle.solid, color: Colors.transparent),
                  );

                  List<GFListTileDirectional> allUserTiles = users
                      .map((e) => GFListTileDirectional(
                            title: Text(e.fullName),
                            direction: TextDirection.rtl,
                            margin: const EdgeInsets.fromLTRB(5, 1, 1, 5),
                            onLongPress: () async {
                              await showMenu(
                                  context: context,
                                  position: RelativeRect.fromLTRB(100, 100, 100, 100),
                                  items: [
                                    PopupMenuItem(
                                      onTap: () async {
                                        await widget.friendInteractionProvider
                                            .unfriendUser(friend: e);
                                        setState(() {});
                                      },
                                      child: Text(_ReportsPageConsts.deleteFriend),
                                    )
                                  ]);
                            },
                            color: const Color.fromARGB(150, 170, 170, 170),
                            icon: Text(parseLastSeen(e.lastSeen, e.gender)),
                            avatar: const Icon(Icons.person_rounded),
                            shadow: const BoxShadow(
                                blurStyle: BlurStyle.solid, color: Colors.transparent),
                          ))
                      .toList();
                  allUserTiles.insert(0, activeUserTile);
                  return allUserTiles;
                }()),
            bottomSheet: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PurpleButton(
                      showProgressIndicatorAfterClick: true,
                      onClick: onReportButtonClicked,
                      caption: _ReportsPageConsts.reportNow,
                    ),
                    const SizedBox(width: 20),
                    PurpleButton(
                        showProgressIndicatorAfterClick: true,
                        onClick: () async => setState(() {}),
                        caption: _ReportsPageConsts.refresh)
                  ],
                )));
      },
    );
    return builder;
  }

  Future<void> onReportButtonClicked() async {
    await widget.friendInteractionProvider.reportOkay();
    setState(() {});
  }
}

String parseLastSeen(int lastSeen, String gender) {
  String result = '';

  if (lastSeen == 0) {
    return Consts.notReportedYet(gender);
  }

  int delta = DateTime.now().millisecondsSinceEpoch - lastSeen;
  Duration duration = Duration(milliseconds: delta);

  result = Consts.xTimeAgo(duration);
  return result;
}

class _ReportsPageConsts {
  static const String reportNow = 'שיתוף';
  static const String refresh = 'רענון';
  static const String deleteFriend = 'מחיקת חיבור';
}
