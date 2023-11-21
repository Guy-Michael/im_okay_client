import 'dart:async';

import 'package:flutter/material.dart';
import 'package:im_okay/Models/user.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/Widgets/list_tile.dart';
import 'package:im_okay/Widgets/purple_button.dart';

Future<(User activeUser, List<User> friends)> future(
    IFriendInteractionsProvider provider) async {
  List<User> users = await provider.getAllFriends();
  User activeUser = (await UserAuthenticationApiService.appUser)!;
  return (activeUser, users);
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
    var builder = FutureBuilder<(User activeUser, List<User> friends)>(
      initialData: (const User(), List<User>.empty()),
      future: future(widget.friendInteractionProvider),
      builder: (context, snapshot) {
        User activeUser = snapshot.data!.$1;
        List<User> users = snapshot.data!.$2;
        if (activeUser.firstName == '' && users.isEmpty) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        return Scaffold(
            body: Wrap(
                textDirection: TextDirection.rtl,
                children: () {
                  if (users.isEmpty) {
                    return [const Center(child: Text("עוד לא הוספת חברים :)"))];
                  }
                  GFListTileDirectional activeUserTile = GFListTileDirectional(
                    title: Text("השיתוף האחרון שלי"),
                    direction: TextDirection.rtl,
                    margin: const EdgeInsets.fromLTRB(5, 1, 1, 5),
                    onLongPress: () {},
                    color: const Color.fromARGB(150, 170, 170, 170),
                    icon: Text(
                        parseLastSeen(activeUser.lastSeen, activeUser.gender)),
                    avatar: const Icon(Icons.person_rounded),
                    shadow: const BoxShadow(
                        blurStyle: BlurStyle.solid, color: Colors.transparent),
                  );

                  List<GFListTileDirectional> allUserTiles = users
                      .map((e) => GFListTileDirectional(
                            title: Text(e.fullName),
                            direction: TextDirection.rtl,
                            margin: const EdgeInsets.fromLTRB(5, 1, 1, 5),
                            onLongPress: () {},
                            color: const Color.fromARGB(150, 170, 170, 170),
                            icon: Text(parseLastSeen(e.lastSeen, e.gender)),
                            avatar: const Icon(Icons.person_rounded),
                            shadow: const BoxShadow(
                                blurStyle: BlurStyle.solid,
                                color: Colors.transparent),
                          ))
                      .toList();
                  allUserTiles.insert(0, activeUserTile);
                  return allUserTiles;
                }()),
            bottomSheet: Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PurpleButton(
                    callback: onReportButtonClicked,
                    caption: Consts.reportButtonCaption(
                        activeUser.firstName, activeUser.gender)),
                const SizedBox(width: 20),
                PurpleButton(
                    callback: () => setState(() {}),
                    caption:
                        activeUser.gender == Gender.female ? "רענני" : "רענן")
              ],
            ));
      },
    );
    return builder;
  }

  void onReportButtonClicked() async {
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
  // } else {
  //   DateTime time = DateTime.fromMillisecondsSinceEpoch(lastSeen);
  //   result = " ${time.day}.${time.month}, ${time.hour}:${time.minute}";
  // }

  return result;
}
