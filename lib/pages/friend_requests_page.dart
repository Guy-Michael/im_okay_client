import 'dart:async';

import 'package:flutter/material.dart';
import 'package:im_okay/Models/user.dart';
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
    friendRequestStreamController = StreamController<List<AppUser>>();
    friendRequestStreamController.addStream(StreamUtils.initStreamWithInitial(
        Duration(seconds: 5), widget.friendInteractionProvider.getIncomingPendingRequests));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<List<AppUser>>(
            initialData: const [],
            stream: friendRequestStreamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return Column(
                    children: snapshot.data!
                        .map((AppUser user) => PendingFriendRequest(
                              friendInteractionProvider: widget.friendInteractionProvider,
                              user: user,
                            ))
                        .toList());
              }

              return const Center(child: Text(FriendRequestConsts.noPendingRequestsCaption));
            }));
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
  static const String approveButtonCaption = "אישור";
  static const String denyButtonCaption = "דחייה";
  static const String noPendingRequestsCaption = "אין בקשות ממתינות :)";
  static String alertZoneCaption(String alertZone) => "אזור ההתראה שלך: " + alertZone;
}
