import 'package:flutter/material.dart';
import 'package:im_okay/Enums/friend_query_type_enum.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/pages/kin/add%20kin/components/add_kin_tile.dart';
import 'package:im_okay/pages/kin/kin%20page%20base/kin_page_base.dart';

class AddKinPage extends StatefulWidget {
  final IKinInteractionsService friendInteractionProvider;
  List<AppUser> searchResults = [];
  AddKinPage({super.key, required this.friendInteractionProvider});

  @override
  State<StatefulWidget> createState() => AddKinPageState();
}

class AddKinPageState extends State<AddKinPage> {
  @override
  Widget build(BuildContext context) {
    return KinPageBase(
      title: AddKinPageConsts.pageTitle,
      displaySearchBar: true,
      onSubmitSearch: getKinSuggestions,
      list: widget.searchResults
          .map<AddKinTile>((user) => AddKinTile(
                user: user,
                onAddClicked: (widget.friendInteractionProvider.sendFriendRequest),
              ))
          .toList(),
    );
  }

  Future<void> getKinSuggestions(String query) async {
    if (query.isEmpty) {
      return;
    }

    List<AppUser> list = (await widget.friendInteractionProvider.queryFriends(query))
        .where((response) => response.relationship != FriendQueryType.friendsWith)
        .map<AppUser>((response) => response.user)
        .toList();
    setState(() {
      widget.searchResults = list;
    });
  }
}

class AddKinPageConsts {
  static const String pageTitle = "הוספת קרובים";
  static const String searchBarCaption = "חיפוש איש קשר";
}
