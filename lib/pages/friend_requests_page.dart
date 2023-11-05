import 'package:flutter/material.dart';
import 'package:im_okay/Models/user.dart';
import 'package:im_okay/Services/API%20Services/friend_request_api_service.dart';
import 'package:im_okay/Utils/http_utils.dart';
import 'package:im_okay/Widgets/purple_button.dart';

class FriendRequestsPage extends StatefulWidget {
  const FriendRequestsPage({super.key});

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
      future: HttpUtils.getFriendRequests(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
              children: snapshot.data!
                  .map((User user) => PendingFriendRequest(
                        user: user,
                      ))
                  .toList());
        }

        return const Text("No pending requests :)");
      },
    ));
  }
}

class PendingFriendRequest extends StatefulWidget {
  final User user;
  // final Function(User user) onAddClicked;

  const PendingFriendRequest({required this.user, super.key});

  @override
  State<PendingFriendRequest> createState() => PendingFriendRequestState();
}

class PendingFriendRequestState extends State<PendingFriendRequest> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 5, right: 15),
        child: Row(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _getList(user: widget.user),
        ));
  }
}

List<Widget> _getList({required User user}) => [
      Container(
        alignment: Alignment.center,
        constraints: const BoxConstraints(
            maxHeight: 70, maxWidth: 100, minHeight: 70, minWidth: 100),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xffb4d3d7)),
        child: Text(user.fullName,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            )),
      ),
      PurpleButton(
        caption: "אשר",
        callback: () =>
            FriendInteractionsApiService.respondToFriendRequest(user, true),
      ),
      PurpleButton(
        caption: "דחה",
        callback: () =>
            FriendInteractionsApiService.respondToFriendRequest(user, false),
      )
    ];
