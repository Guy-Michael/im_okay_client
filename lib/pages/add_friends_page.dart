import 'package:flutter/material.dart';
import 'package:im_okay/Enums/friend_query_type_enum.dart';
import 'package:im_okay/Models/search_query_response.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/Services/Notification%20Services/in_app_message_service.dart';
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
    List<SearchQueryResponse> searchResults =
        await widget.friendInteractionProvider.queryFriends(searchQuery);

    setState(() {
      searchList = searchResults
          .map((e) => FriendSearchResult(
              user: e.user,
              type: e.relationship,
              onAddClicked: onAddClicked,
              onCancelClicked: onCancelRequestClicked))
          .toList();
    });
  }

  void onAddClicked(AppUser user) async {
    await widget.friendInteractionProvider.sendFriendRequest(friend: user);
    InAppMessageService.showToast(
        message: _AddFriendsPageConsts.FriendRequestSentMessage(user.fullName));

    await getSearchResults();
  }

  void onCancelRequestClicked(AppUser user) async {
    await widget.friendInteractionProvider.cancelFriendRequest(friend: user);
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
                hintText: _AddFriendsPageConsts.searchBarCaption,
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
                  onClick: getSearchResults, caption: _AddFriendsPageConsts.searchButtonCaption))),
    );
  }
}

class FriendSearchResult extends StatefulWidget {
  final AppUser user;
  FriendQueryType type;
  Function(AppUser user)? onAddClicked;
  Function(AppUser user)? onCancelClicked;

  FriendSearchResult(
      {required this.user, required this.type, this.onAddClicked, this.onCancelClicked, super.key});

  @override
  State<FriendSearchResult> createState() => FriendSearchResultState();
}

class FriendSearchResultState extends State<FriendSearchResult> {
  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case (FriendQueryType.friendshipRequested):
        {
          return friendshipRequested(widget.user, widget.onCancelClicked!);
        }

      case (FriendQueryType.friendsWith):
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

Container notFriend(AppUser user, Function(AppUser user) onAddClicked) => Container(
    margin: margin,
    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      userUi(user),
      PurpleButton(
        onClick: () => onAddClicked(user),
        caption: _AddFriendsPageConsts.addFriendButtonCaption,
      )
    ]));

Container friendshipRequested(AppUser user, Function(AppUser user) onCancelRequestClicked) =>
    Container(
        margin: margin,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          userUi(user),
          PurpleButton(
            onClick: () => onCancelRequestClicked(user),
            color: Colors.grey,
            caption: _AddFriendsPageConsts.cancelRequestButtonCaption,
          )
        ]));

Container alreadyFriend(AppUser user) => Container(
    margin: margin,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        userUi(user),
        PurpleButton(
          onClick: () async {},
          color: Colors.grey,
          caption: _AddFriendsPageConsts.alreadyFriendsCaption,
        )
      ],
    ));

Expanded userUi(AppUser user) => Expanded(
        child: GFListTileDirectional(
      title: Text(user.fullName),
      margin: const EdgeInsets.fromLTRB(5, 1, 1, 5),
      onLongPress: () {},
      color: const Color.fromARGB(150, 170, 170, 170),
      avatar: const Icon(Icons.person_rounded),
      shadow: const BoxShadow(blurStyle: BlurStyle.solid, color: Colors.transparent),
    ));

EdgeInsets margin = const EdgeInsets.only(bottom: 5, right: 15);

class _AddFriendsPageConsts {
  static const String searchBarCaption = "חיפוש";
  static const String searchButtonCaption = "חיפוש";
  static const String addFriendButtonCaption = "+";
  static const String cancelRequestButtonCaption = "ביטול";
  static const String alreadyFriendsCaption = "חברים";
  static String FriendRequestSentMessage(String name) => "בקשת חברות נשלחה ל$name";
}
