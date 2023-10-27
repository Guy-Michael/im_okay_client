import 'package:flutter/material.dart';
import 'package:im_okay_client/Models/user.dart';
import 'package:im_okay_client/Utils/http_utils.dart';
import 'package:im_okay_client/Widgets/my_text_field.dart';

class AddFriendsPage extends StatefulWidget {
  const AddFriendsPage({super.key});

  @override
  AddFriendsPageState createState() => AddFriendsPageState();
}

class AddFriendsPageState extends State<AddFriendsPage> {
  TextEditingController searchController = TextEditingController();
  List<FriendSearchResult> searchList = [];

  void getSearchResults() async {
    String searchQuery = searchController.text;
    searchList = (await HttpUtils.queryFriends(searchQuery))
        .map((e) => FriendSearchResult(name: "${e.firstName} ${e.lastName}"))
        .toList();
    setState(() {});
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
              hintText: 'חפשו חברים',
              icon: Icons.search,
            )),
        ElevatedButton(
            onPressed: getSearchResults, child: const Text("search")),
        Wrap(children: searchList
            // [
            //   FriendSearchResult(name: 'שמובי מיכאל כעעעעע'),
            //   FriendSearchResult(name: 'שמובי מיכאל כעעעעע'),
            //   FriendSearchResult(name: 'שמובי מיכאל כעעעעע'),
            //   FriendSearchResult(name: 'שמובי מיכאל כעעעעע'),
            //   FriendSearchResult(name: 'שמובי מיכאל כעעעעע'),
            //   FriendSearchResult(name: 'שמובי מיכאל כעעעעע'),
            //   FriendSearchResult(name: 'שמובי מיכאל כעעעעע')
            // ],
            ),
      ],
    ));
  }
}

class FriendSearchResult extends StatefulWidget {
  final String name;
  final Widget? appended;

  FriendSearchResult({this.name = '', this.appended, super.key});

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
          children: _getList(widget.name),
        ));
  }
}

List<Widget> _getList(String name) => [
      Container(
        alignment: Alignment.center,
        width: 160,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xffb4d3d7)),
        child: Text(name,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            )),
      ),
      IconButton(
          color: const Color(0xffb4d3d7),
          style: ButtonStyle(
              fixedSize: const MaterialStatePropertyAll(Size(50, 50)),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)))),
          onPressed: () => debugPrint("pressed!"),
          alignment: Alignment.center,
          icon: const Icon(Icons.add))
    ];
