import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:im_okay/Models/user.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
import 'package:im_okay/Widgets/list_tile.dart';
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

  Future<void> getSearchResults() async {
    String searchQuery = searchController.text;
    List<User> searchResults = await widget.friendInteractionProvider.queryFriends(searchQuery);

    setState(() {
      searchList = searchResults
          .map((e) => FriendSearchResult(user: e, onAddClicked: onAddClicked))
          .toList();
    });
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
                hintText: AddFriendsPageConsts.searchBarCaption,
                icon: Icons.search,
              )),
          Wrap(children: searchList),
        ],
      ),
      bottomSheet: Center(
          heightFactor: 1,
          child: PurpleButton(
              onClick: getSearchResults, caption: AddFriendsPageConsts.searchButtonCaption)),
    );
  }
}

class FriendSearchResult extends StatefulWidget {
  final User user;
  final Function(User user) onAddClicked;

  const FriendSearchResult({required this.user, required this.onAddClicked, super.key});

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
              Expanded(
                  child: GFListTileDirectional(
                title: Text(widget.user.fullName),
                direction: TextDirection.rtl,
                margin: const EdgeInsets.fromLTRB(5, 1, 1, 5),
                onLongPress: () {},
                color: const Color.fromARGB(150, 170, 170, 170),
                avatar: const Icon(Icons.person_rounded),
                shadow: const BoxShadow(blurStyle: BlurStyle.solid, color: Colors.transparent),
              )),
              PurpleButton(
                onClick: () => widget.onAddClicked(widget.user),
                caption: AddFriendsPageConsts.addFriendButtonCaption,
              )
            ]));
  }
}

class AddFriendsPageConsts {
  static final String searchBarCaption = "חיפוש";
  static final String searchButtonCaption = "חיפוש";
  static final String addFriendButtonCaption = "+";
}
