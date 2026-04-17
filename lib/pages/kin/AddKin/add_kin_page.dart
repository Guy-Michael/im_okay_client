import 'package:flutter/material.dart';
import 'package:im_okay/Enums/relationship_enum.dart';
import 'package:im_okay/Models/cached_user_data.dart';
import 'package:im_okay/Services/CacheService/Abstract/i_cache_service.dart';
import 'package:im_okay/Services/KinInteractionService/i_kin_interaction_service.dart';
import 'package:im_okay/Services/service_injector.dart';
import 'package:im_okay/pages/Kin/KinPageBase/kin_page_base.dart';
import 'package:im_okay/pages/kin/AddKin/components/add_kin_tile.dart';

class AddKinPage extends StatefulWidget {
  const AddKinPage({super.key});

  @override
  State<StatefulWidget> createState() => AddKinPageState();
}

class AddKinPageState extends State<AddKinPage> {
  late final IKinInteractionsService _kinInteractionService;
  late final ICacheService _cacheService;
  List<CachedUserData> searchResults = [];

  @override
  void initState() {
    super.initState();
    _cacheService = serviceInjector.get<ICacheService>();
    _kinInteractionService = serviceInjector.get<IKinInteractionsService>();
  }

  @override
  Widget build(BuildContext context) {
    return KinPageBase(
      title: AddKinPageConsts.pageTitle,
      displaySearchBar: true,
      onSubmitSearch: getKinSuggestions,
      list: searchResults
          .map<AddKinTile>((cachedUserData) => AddKinTile(
                cachedUserData: cachedUserData,
                onAddClicked: (_kinInteractionService.sendFriendRequest),
                onCancelClicked: (_kinInteractionService.cancelFriendRequest),
              ))
          .toList(),
    );
  }

  Future<void> getKinSuggestions(String query) async {
    List<CachedUserData> list = _cacheService
        .fetchUsers()
        .where((response) =>
            query.isNotEmpty &&
            response.name.startsWith(query) &&
            response.relationship != Relationship.friendsWith)
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
