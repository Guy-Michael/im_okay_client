import 'package:flutter/material.dart';
import 'package:im_okay/Enums/friend_query_type_enum.dart';
import 'package:im_okay/Models/search_query_response.dart';
import 'package:im_okay/Services/ApiServices/KinInteractionService/i_kin_interaction_service.dart';
import 'package:im_okay/Services/service_injector.dart';
import 'package:im_okay/pages/kin/add%20kin/components/add_kin_tile.dart';
import 'package:im_okay/pages/kin/kin%20page%20base/kin_page_base.dart';

class AddKinPage extends StatefulWidget {
  const AddKinPage({super.key});

  @override
  State<StatefulWidget> createState() => AddKinPageState();
}

class AddKinPageState extends State<AddKinPage> {
  late final IKinInteractionsService _kinInteractionService;
  List<SearchQueryResponse> searchResults = [];

  @override
  void initState() {
    super.initState();

    _kinInteractionService = serviceInjector.get<IKinInteractionsService>();
  }

  @override
  Widget build(BuildContext context) {
    return KinPageBase(
      title: AddKinPageConsts.pageTitle,
      displaySearchBar: true,
      onSubmitSearch: getKinSuggestions,
      list: searchResults
          .map<AddKinTile>((queryResponse) => AddKinTile(
                queryResponse: queryResponse,
                onAddClicked: (_kinInteractionService.sendFriendRequest),
                onCancelClicked: (_kinInteractionService.cancelFriendRequest),
              ))
          .toList(),
    );
  }

  Future<void> getKinSuggestions(String query) async {
    if (query.isEmpty) {
      return;
    }

    List<SearchQueryResponse> list = (await _kinInteractionService.queryFriends(query))
        .where((response) => response.relationship != FriendQueryType.friendsWith)
        .toList();
    setState(() {
      searchResults = list;
    });
  }
}

class AddKinPageConsts {
  static const String pageTitle = "הוספת קרובים";
  static const String searchBarCaption = "חיפוש איש קשר";
}
