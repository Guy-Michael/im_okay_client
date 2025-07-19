import 'dart:async';

import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/Utils/stream_utils.dart';
import 'package:im_okay/Widgets/list_tile.dart';
import 'package:im_okay/Widgets/purple_button.dart';

class FriendRequestsPage extends StatefulWidget {
  final IFriendInteractionsProvider friendInteractionProvider;

  const FriendRequestsPage({required this.friendInteractionProvider, super.key});

  @override
  FriendRequestsPageState createState() => FriendRequestsPageState();
}

class FriendRequestsPageState extends State<FriendRequestsPage> {
  late StreamController<List<AppUser>> friendRequestStreamController;
  List<PendingFriendRequest> friendRequestsList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
          margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Text(
            FriendRequestConsts.title,
            textAlign: TextAlign.start,
            style: TextStyle(fontFamily: "Inter", fontSize: 28),
          )),
      StreamBuilder<List<AppUser>>(
          initialData: const [],
          stream: StreamUtils.initStream(
              func: widget.friendInteractionProvider.getIncomingPendingRequests),
          builder: (context, snapshot) {
            AppUser user = AppUser(firstName: "טל", lastName: "כספי");
            AppUser user2 = AppUser(firstName: "נועם", lastName: "נחום");
            AppUser user3 = AppUser(firstName: "בן", lastName: "קאושנסקי");
            AppUser user4 = AppUser(firstName: "זיו", lastName: "קידר");
            return
                // Container(
                // margin: EdgeInsets.fromLTRB(16, 12, 16, 12),
                // child:
                Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 20,
                        children: [
                  PendingFriendRequestNew(user: user),
                  PendingFriendRequestNew(user: user2),
                  PendingFriendRequestNew(user: user3),
                  PendingFriendRequestNew(user: user4),
                  // PendingFriendRequest(
                  //     friendInteractionProvider: widget.friendInteractionProvider, user: user),
                  // PendingFriendRequest(
                  //     friendInteractionProvider: widget.friendInteractionProvider, user: user2),
                  // PendingFriendRequest(
                  //     friendInteractionProvider: widget.friendInteractionProvider, user: user3),
                  // PendingFriendRequest(
                  //     friendInteractionProvider: widget.friendInteractionProvider, user: user4)
                ]))
                // )
                ;
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              // snapshot.data!
              //     .map((AppUser user) => PendingFriendRequest(
              //           friendInteractionProvider: widget.friendInteractionProvider,
              //           user: user,
              //         ))
              //     .toList());
            }
            return const Center(child: Text(FriendRequestConsts.noPendingRequestsCaption));
          })
    ]));
  }
}

class PendingFriendRequest extends StatefulWidget {
  final IFriendInteractionsProvider friendInteractionProvider;
  final AppUser user;

  const PendingFriendRequest(
      {required this.friendInteractionProvider, required this.user, super.key});

  @override
  State<PendingFriendRequest> createState() => PendingFriendRequestState();
}

class PendingFriendRequestNew extends StatefulWidget {
  final AppUser user;

  const PendingFriendRequestNew({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => PendingFriendRequestNewState();
}

class PendingFriendRequestNewState extends State<PendingFriendRequestNew> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // width: 361,
        height: 120,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          spacing: 12,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  shape: BoxShape.circle,
                  image: DecorationImage(image: NetworkImage("https://picsum.photos/200/200"))),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                widget.user.fullName,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              Row(
                spacing: 16,
                children: [
                  getPendingFriendRequestButton(
                      color: Colors.teal,
                      onPressed: () {},
                      caption: FriendRequestConsts.approveButtonCaption),
                  getPendingFriendRequestButton(
                      color: Color.fromARGB(1, 232, 232, 232),
                      onPressed: () {},
                      caption: FriendRequestConsts.denyButtonCaption,
                      textColor: Colors.black)
                ],
              )
            ]),
          ],
        ));
  }

  ElevatedButton getPendingFriendRequestButton(
      {required Color color,
      required Function() onPressed,
      required String caption,
      Color textColor = Colors.white}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: color, minimumSize: Size(112, 35), maximumSize: Size(224, 70)),
      child: Text(
        caption,
        style: TextStyle(color: textColor, fontSize: 18),
      ),
    );
  }
}

class PendingFriendRequestState extends State<PendingFriendRequest> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: _getList(user: widget.user),
    );
  }

  List<Widget> _getList({required AppUser user}) => [
        Expanded(
            child: GFListTileDirectional(
          title: Text(user.fullName),
          direction: TextDirection.rtl,
          margin: const EdgeInsets.fromLTRB(5, 1, 1, 5),
          onLongPress: () {},
          color: const Color.fromARGB(150, 170, 170, 170),
          avatar: const Icon(Icons.person_rounded),
          shadow: const BoxShadow(blurStyle: BlurStyle.solid, color: Colors.transparent),
        )),
        PurpleButton(
          onClick: () async {
            await widget.friendInteractionProvider.respondToFriendRequest(user, true);
            setState(() {});
          },
          padding: const EdgeInsets.all(15),
          caption: FriendRequestConsts.approveButtonCaption,
        ),
        const SizedBox(width: 2),
        PurpleButton(
          padding: const EdgeInsets.all(15),
          color: Colors.grey,
          onClick: () async {
            await widget.friendInteractionProvider.respondToFriendRequest(user, false);
          },
          caption: FriendRequestConsts.denyButtonCaption,
        )
      ];
}

class FriendRequestConsts {
  static const String title = "בקשות חדשות";
  static const String approveButtonCaption = "אישור";
  static const String denyButtonCaption = "ביטול";
  static const String noPendingRequestsCaption = "אין בקשות ממתינות :)";
  static String alertZoneCaption(String alertZone) => "אזור ההתראה שלך: $alertZone";
}
