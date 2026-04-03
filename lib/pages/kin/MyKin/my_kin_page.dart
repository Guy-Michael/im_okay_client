import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:im_okay/Providers/providers.dart';
import 'package:im_okay/pages/kin/empty_kin_page/empty_kin_page.dart';
import 'package:im_okay/pages/kin/kin%20page%20base/kin_page_base.dart';
import 'package:im_okay/pages/kin/MyKin/my_kin_tile.dart';

class MyKinPage extends ConsumerStatefulWidget {
  const MyKinPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MyKinPageState();
}

class MyKinPageState extends ConsumerState<MyKinPage> {
  @override
  Widget build(BuildContext context) {
    final kin = ref.watch(kinProvider);
    return kin.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Container(),
        data: (data) {
          if (data.isEmpty) {
            return EmptyKinPage(
              title: _MyKinPageConsts.title,
              subtitle: _MyKinPageConsts.emptyPageSubtitle,
              helpText: _MyKinPageConsts.emptyPageHelpText,
              showAddKinButton: true,
            );
          }

          List<MyKinTile> list = data.map((user) => MyKinTile(user: user)).toList();

          return KinPageBase(
            title: _MyKinPageConsts.title,
            list: list,
          );
        });
  }
}

class _MyKinPageConsts {
  static final String title = "הקרובים שלי";
  static final String emptyPageSubtitle = "כאן יופיעו הקרובים שלך";
  static final String emptyPageHelpText = "הוסיפו קרובים כדי להתעדכן בשלומם בעת אזעקה";
  static final String emptyPageActionCaption = "הוספת קרובים";
}
