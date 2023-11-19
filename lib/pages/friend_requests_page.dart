import 'package:flutter/material.dart';
import 'package:im_okay/Models/user.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
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
            flex: 7,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 100, 0, 10),
              alignment: Alignment.center,
              // constraints: BoxConstraints.expand(height: 70),
              // constraints: const BoxConstraints(
              //     maxHeight: 200, maxWidth: 400, minHeight: 100, minWidth: 70),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xffb4d3d7)),
              child: Text(user.fullName,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  )),
            )),
        PurpleButton(
          caption: "אשר",
          callback: () => widget.friendInteractionProvider
              .respondToFriendRequest(user, true),
        ),
        PurpleButton(
          caption: "דחה",
          color: Colors.redAccent,
          callback: () => widget.friendInteractionProvider
              .respondToFriendRequest(user, false),
        )
      ];
}
