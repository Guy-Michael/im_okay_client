import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:im_okay/Models/user.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/Widgets/list_tile.dart';
import 'package:im_okay/Widgets/purple_button.dart';

class FriendRequestsPage extends StatefulWidget {
  final IFriendInteractionsProvider friendInteractionProvider;

  const FriendRequestsPage(
      {required this.friendInteractionProvider, super.key});

  @override
  FriendRequestsPageState createState() => FriendRequestsPageState();
}

class FriendRequestsPageState extends State<FriendRequestsPage> {
  List<PendingFriendRequest> friendRequestsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<User>>(
      initialData: const [],
      future: widget.friendInteractionProvider.getIncomingPendingRequests(),
      builder: (context, snapshot) {
        // if (snapshot.hasData && snapshot.data!.isNotEmpty) {
        //   return Column(
        //       children: snapshot.data!
        //           .map((User user) => PendingFriendRequest(
        //                 friendInteractionProvider:
        //                     widget.friendInteractionProvider,
        //                 user: user,
        //               ))
        //           .toList());
        // }

        List<Widget> tiles = [
          Row(
            textDirection: TextDirection.rtl,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: GFListTileDirectional(
                title: Text("שם מלא משתמש"),
                direction: TextDirection.rtl,
                margin: const EdgeInsets.fromLTRB(5, 1, 1, 5),
                onLongPress: () {},
                color: const Color.fromARGB(150, 170, 170, 170),
                avatar: const Icon(Icons.person_rounded),
                shadow: const BoxShadow(
                    blurStyle: BlurStyle.solid, color: Colors.transparent),
              )),
              GFButton(
                onPressed: () {},
                text: "אשר",
              ),
              SizedBox(width: 2),
              GFButton(
                onPressed: () {},
                text: "דחה",
              )
            ],
          ),
          Row(
            children: [
              GFListTileDirectional(
                title: Text("שם מלא משתמש"),
                direction: TextDirection.rtl,
                margin: const EdgeInsets.fromLTRB(5, 1, 1, 5),
                onLongPress: () {},
                color: const Color.fromARGB(150, 170, 170, 170),
                avatar: const Icon(Icons.person_rounded),
                shadow: const BoxShadow(
                    blurStyle: BlurStyle.solid, color: Colors.transparent),
              ),
              PurpleButton(
                callback: () {},
                caption: "אשר",
              ),
              PurpleButton(
                callback: () {},
                caption: "אשר",
              )
            ],
          ),
          Row(
            children: [
              GFListTileDirectional(
                title: Text("שם מלא משתמש"),
                direction: TextDirection.rtl,
                margin: const EdgeInsets.fromLTRB(5, 1, 1, 5),
                onLongPress: () {},
                color: const Color.fromARGB(150, 170, 170, 170),
                avatar: const Icon(Icons.person_rounded),
                shadow: const BoxShadow(
                    blurStyle: BlurStyle.solid, color: Colors.transparent),
              ),
              PurpleButton(
                callback: () {},
                caption: "אשר",
              ),
              PurpleButton(
                callback: () {},
                caption: "אשר",
              )
            ],
          ),
        ];

        List<PendingFriendRequest> requests = [
          PendingFriendRequest(
            friendInteractionProvider: widget.friendInteractionProvider,
            user: const User(firstName: "TEST", lastName: "TESTING"),
          ),
          PendingFriendRequest(
            friendInteractionProvider: widget.friendInteractionProvider,
            user: const User(firstName: "TEST", lastName: "TESTING"),
          ),
          PendingFriendRequest(
            friendInteractionProvider: widget.friendInteractionProvider,
            user: const User(firstName: "TEST", lastName: "TESTING"),
          ),
          PendingFriendRequest(
            friendInteractionProvider: widget.friendInteractionProvider,
            user: const User(firstName: "TEST", lastName: "TESTING"),
          )
        ];

        return Column(
          children: requests,
        );

        return const Center(child: Text("No pending requests :)"));
      },
    ));
  }
}

class PendingFriendRequest extends StatefulWidget {
  final IFriendInteractionsProvider friendInteractionProvider;
  final User user;
  // final Function(User user) onAddClicked;

  const PendingFriendRequest(
      {required this.friendInteractionProvider, required this.user, super.key});

  @override
  State<PendingFriendRequest> createState() => PendingFriendRequestState();
}

class PendingFriendRequestState extends State<PendingFriendRequest> {
  @override
  Widget build(BuildContext context) {
    // return Container(
    // margin: const EdgeInsets.only(bottom: 5, right: 15),
    // child:
    return Row(
      // runSpacing: 100,
      // spacing: 10,
      textDirection: TextDirection.rtl,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: _getList(user: widget.user),
      // )
    );
  }

  List<Widget> _getList({required User user}) => [
        Expanded(
            child: GFListTileDirectional(
          title: Text(user.fullName),
          direction: TextDirection.rtl,
          margin: const EdgeInsets.fromLTRB(5, 1, 1, 5),
          onLongPress: () {},
          color: const Color.fromARGB(150, 170, 170, 170),
          avatar: const Icon(Icons.person_rounded),
          shadow: const BoxShadow(
              blurStyle: BlurStyle.solid, color: Colors.transparent),
        )),
        GFButton(
          onPressed: () async {
            await widget.friendInteractionProvider
                .respondToFriendRequest(user, true);
          },
          text: "אשר",
        ),
        const SizedBox(width: 2),
        GFButton(
          color: Colors.redAccent,
          onPressed: () async {
            await widget.friendInteractionProvider
                .respondToFriendRequest(user, false);
          },
          text: "דחה",
        )
      ];
}
