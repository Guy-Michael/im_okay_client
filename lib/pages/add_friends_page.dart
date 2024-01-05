import 'package:flutter/material.dart';
import 'package:im_okay/Enums/friend_query_type_enum.dart';
import 'package:im_okay/Models/user.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
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
    if (searchQuery.isEmpty) {
      return;
    }
    List<(User user, FriendQueryType relationship)> searchResults =
        await widget.friendInteractionProvider.queryFriends(searchQuery);

    setState(() {
      searchList = searchResults
          .map((e) => FriendSearchResult(user: e.$1, type: e.$2, onAddClicked: onAddClicked))
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
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: PurpleButton(
                  onClick: getSearchResults, caption: AddFriendsPageConsts.searchButtonCaption))),
    );
  }
}

class FriendSearchResult extends StatefulWidget {
  final User user;
  FriendQueryType type;
  Function(User user)? onAddClicked;

  FriendSearchResult({required this.user, required this.type, this.onAddClicked, super.key});

  @override
  State<FriendSearchResult> createState() => FriendSearchResultState();
}

class FriendSearchResultState extends State<FriendSearchResult> {
  @override
  Widget build(BuildContext context) {
    debugPrint("got here: ${widget.type}, ${widget.user}");
    switch (widget.type) {
      case (FriendQueryType.FRIENDSHIP_REQUESTED):
        {
          return friendshipRequested(widget.user, (user) {});
        }

      case (FriendQueryType.FRIENDS_WITH):
        {
          return alreadyFriend(widget.user);
        }

      default:
        {
          return notFriend(widget.user, widget.onAddClicked!);
        }
    }
  }
}

Container notFriend(User user, Function(User user) onAddClicked) => Container(
    margin: margin,
    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      userUi(user),
      PurpleButton(
        onClick: () => onAddClicked(user),
        caption: AddFriendsPageConsts.addFriendButtonCaption,
      )
    ]));

Container friendshipRequested(User user, Function(User user)? onCancelRequestClicked) => Container(
    margin: margin,
    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      userUi(user),
      PurpleButton(
        onClick: () async {},
        color: Colors.grey,
        caption: AddFriendsPageConsts.cancelRequestButtonCaption,
      )
    ]));

Container alreadyFriend(User user) => Container(
    margin: margin,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        userUi(user),
        PurpleButton(
          onClick: () async {},
          color: Colors.grey,
          caption: AddFriendsPageConsts.alreadyFriendsCaption,
        )
        // GFListTileDirectional(title: Text(AddFriendsPageConsts.alreadyFriendsCaption))
      ],
    ));

Expanded userUi(User user) => Expanded(
        child: GFListTileDirectional(
      title: Text(user.fullName),
      margin: const EdgeInsets.fromLTRB(5, 1, 1, 5),
      onLongPress: () {},
      color: const Color.fromARGB(150, 170, 170, 170),
      avatar: const Icon(Icons.person_rounded),
      shadow: const BoxShadow(blurStyle: BlurStyle.solid, color: Colors.transparent),
    ));

EdgeInsets margin = const EdgeInsets.only(bottom: 5, right: 15);

class AddFriendsPageConsts {
  static const String searchBarCaption = "חיפוש";
  static const String searchButtonCaption = "חיפוש";
  static const String addFriendButtonCaption = "+";
  static const String cancelRequestButtonCaption = "ביטול";
  static const String alreadyFriendsCaption = "חברים";
}
