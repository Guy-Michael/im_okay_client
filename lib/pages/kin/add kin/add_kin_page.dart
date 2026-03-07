import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/pages/kin/kin%20management/components/kin_page_title.dart';
import 'package:im_okay/pages/kin/add%20kin/components/add_kin_button.dart';

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
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        KinPageTitle(title: AddKinPageConsts.pageTitle),
        AddKinButton(
          user: user,
          onAddClicked: widget.friendInteractionProvider.sendFriendRequest,
        ),
        AddKinButton(
          user: user2,
          onAddClicked: widget.friendInteractionProvider.sendFriendRequest,
        ),
        AddKinButton(
          user: user3,
          onAddClicked: widget.friendInteractionProvider.sendFriendRequest,
        ),
        AddKinButton(
          user: user4,
          onAddClicked: widget.friendInteractionProvider.sendFriendRequest,
        ),
      ],
    ));
  }
}

class AddKinPageConsts {
  static const String pageTitle = "הוספת קרובים";
  static const String searchBarCaption = "חיפוש איש קשר";
}
