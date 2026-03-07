import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/pages/kin/kin%20management/components/kin_page_title.dart';
import 'package:im_okay/pages/kin/add%20kin/components/add_kin_button.dart';
import 'package:im_okay/pages/kin/kin%20page%20base/kin_page_base.dart';

class AddKinPage extends StatefulWidget {
  final IKinInteractionsService friendInteractionProvider;

  const AddKinPage({super.key, required this.friendInteractionProvider});

  @override
  State<StatefulWidget> createState() => AddKinPageState();
}

class AddKinPageState extends State<AddKinPage> {
  @override
  Widget build(BuildContext context) {
    AppUser user = AppUser(firstName: "טל", lastName: "כספי");
    AppUser user2 = AppUser(firstName: "נועם", lastName: "נחום");
    AppUser user3 = AppUser(firstName: "בן", lastName: "קאושנסקי");
    AppUser user4 = AppUser(firstName: "זיו", lastName: "קידר");
    List<AppUser> users = [user, user2, user3, user4, user, user];
    return KinPageBase(
      title: AddKinPageConsts.pageTitle,
      list: users
          .map<AddKinTile>((user) => AddKinTile(
                user: user,
                onAddClicked: (widget.friendInteractionProvider.sendFriendRequest),
              ))
          .toList(),
    );
  }
}

class AddKinPageConsts {
  static const String pageTitle = "הוספת קרובים";
  static const String searchBarCaption = "חיפוש איש קשר";
}
