import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:im_okay/Enums/relationship_enum.dart';
import 'package:im_okay/Models/cached_user_data.dart';
import 'package:im_okay/Services/CacheService/Abstract/i_cache_service.dart';
import 'package:im_okay/Services/service_injector.dart';
import 'package:im_okay/pages/Kin/KinPageBase/kin_page_base.dart';
import 'package:im_okay/pages/kin/MyKin/my_kin_tile.dart';

class MyKinPage extends ConsumerStatefulWidget {
  const MyKinPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MyKinPageState();
}

class MyKinPageState extends ConsumerState<MyKinPage> {
  late final ICacheService _cacheService;

  @override
  void initState() {
    super.initState();
    _cacheService = serviceInjector.get<ICacheService>();
  }

  @override
  Widget build(BuildContext context) {
    List<CachedUserData> users = _cacheService.fetchUsers();
    List<MyKinTile> tiles = users
        .where((user) => user.relationship == Relationship.friendsWith)
        .map((user) => MyKinTile(
              user: user,
            ))
        .toList();
    return KinPageBase(
      title: _MyKinPageConsts.title,
      list: tiles,
    );

    // final kin = ref.watch(kinProvider);
    // return kin.when(
    //     loading: () => Center(child: CircularProgressIndicator()),
    //     error: (error, stackTrace) => Container(),
    //     data: (data) {
    //       if (data.isEmpty) {
    //         return EmptyKinPage(
    //           title: _MyKinPageConsts.title,
    //           subtitle: _MyKinPageConsts.emptyPageSubtitle,
    //           helpText: _MyKinPageConsts.emptyPageHelpText,
    //           showAddKinButton: true,
    //         );
    //       }

    //       List<MyKinTile> list = data.map((user) => MyKinTile(user: user)).toList();

    //       return KinPageBase(
    //         title: _MyKinPageConsts.title,
    //         list: list,
    //       );
    //     });
  }
}

class _MyKinPageConsts {
  static final String title = "הקרובים שלי";
  static final String emptyPageSubtitle = "כאן יופיעו הקרובים שלך";
  static final String emptyPageHelpText = "הוסיפו קרובים כדי להתעדכן בשלומם בעת אזעקה";
  static final String emptyPageActionCaption = "הוספת קרובים";
}
