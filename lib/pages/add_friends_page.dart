import 'package:flutter/material.dart';
import 'package:im_okay/Models/user.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/Widgets/my_text_field.dart';
import 'package:im_okay/Widgets/purple_button.dart';

class AddFriendsPage extends StatefulWidget {
  final IFriendInteractionsProvider friendInteractionProvider;

  const AddFriendsPage({required this.friendInteractionProvider, super.key});

  @override
  AddFriendsPageState createState() => AddFriendsPageState();
}

class AddFriendsPageState extends State<AddFriendsPage> {
  TextEditingController searchController = TextEditingController();
  List<FriendSearchResult> searchList = [];

  void getSearchResults() async {
    String searchQuery = searchController.text;
    List<User> searchResults =
        await widget.friendInteractionProvider.queryFriends(searchQuery);

    searchList = searchResults
        .map((e) => FriendSearchResult(user: e, onAddClicked: onAddClicked))
        .toList();

    setState(() {});
  }

  void onAddClicked(User user) {
    widget.friendInteractionProvider.sendFriendRequest(friend: user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: MyTextField(
                inputController: searchController,
                hintText: 'חפשו חברים',
                icon: Icons.search,
              )),
          Wrap(children: searchList),
        ],
      ),
      bottomSheet: Center(
          heightFactor: 1,
          child: PurpleButton(callback: getSearchResults, caption: "search")),
    );
  }
}

class FriendSearchResult extends StatefulWidget {
  final User user;
  final Function(User user) onAddClicked;

  const FriendSearchResult(
      {required this.user, required this.onAddClicked, super.key});

  @override
  State<FriendSearchResult> createState() => FriendSearchResultState();
}

class FriendSearchResultState extends State<FriendSearchResult> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 5, right: 15),
        child: Row(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 160,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xffb4d3d7)),
                child: Text(widget.user.fullName,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    )),
              ),
              IconButton(
                  color: const Color(0xffb4d3d7),
                  style: ButtonStyle(
                      fixedSize: const MaterialStatePropertyAll(Size(50, 50)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)))),
                  onPressed: () => widget.onAddClicked(widget.user),
                  alignment: Alignment.center,
                  icon: const Icon(Icons.add))
            ]
            // _getList(user: widget.user, onAddClicked: widget.onAddClicked),
            ));
  }
}

// List<Widget> _getList(
//         {required User user, required Function(User) onAddClicked}) =>
