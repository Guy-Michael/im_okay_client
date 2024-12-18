import 'dart:async';
import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/Utils/stream_utils.dart';
import 'package:im_okay/Widgets/list_tile.dart';
import 'package:im_okay/Widgets/purple_button.dart';

Future<List<AppUser>> future(IFriendInteractionsProvider provider) async {
  List<AppUser> users = await provider.getAllFriends();
  return users;
}

class ReportsPage extends StatefulWidget {
  final IFriendInteractionsProvider friendInteractionProvider;

  const ReportsPage({required this.friendInteractionProvider, super.key});

  @override
  State<StatefulWidget> createState() => ReportsPageState();
}

class ReportsPageState extends State<ReportsPage> {
  late StreamController<List<AppUser>>? friendStreamController;
  late StreamController<AppUser?>? activeUserStreamController;

  @override
  void initState() {
    super.initState();
    initStreams();
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("disposing streams");
    friendStreamController?.close();
    activeUserStreamController?.close();
    friendStreamController = null;
    activeUserStreamController = null;
  }

  void initStreams() {
    friendStreamController = StreamController<List<AppUser>>();

    friendStreamController?.addStream(StreamUtils.initStreamWithInitial(
        Duration(seconds: 5), () async => future(widget.friendInteractionProvider)));

    activeUserStreamController = StreamController<AppUser?>();

    activeUserStreamController?.addStream(StreamUtils.initStreamWithInitial(
        Duration(seconds: 5), UserAuthenticationApiService.fetchUser));
  }

  List<AppUser> cachedUsers = [];
  @override
  Widget build(BuildContext context) {
    var friendListBuilder = StreamBuilder<List<AppUser>>(
      initialData: cachedUsers,
      stream: friendStreamController?.stream,
      builder: (context, snapshot) {
        List<AppUser> users = snapshot.data ?? cachedUsers;
        cachedUsers = users;

        return Wrap(
            textDirection: TextDirection.rtl,
            children: () {
              if (users.isEmpty) {
                return [const Center(heightFactor: 5, child: Text("עוד לא הוספת חברים :)"))];
              }

              List<GFListTileDirectional> allUserTiles = users
                  .map<GFListTileDirectional>((user) => getUserListing(user, context,
                      onUnfriendButtonClicked: widget.friendInteractionProvider.unfriendUser))
                  .toList();
              return allUserTiles;
            }());
      },
    );

    var bottomSheetBuilder = StreamBuilder(
      stream: activeUserStreamController?.stream,
      initialData: AppUser(),
      builder: (context, snapshot) {
        AppUser user = snapshot.hasData ? snapshot.data! : AppUser();

        return Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [getUserListing(user, context), ...buttons(onReportButtonClicked)]));
      },
    );

    var scaffold = Scaffold(
      body: friendListBuilder,
      bottomSheet: bottomSheetBuilder,
      resizeToAvoidBottomInset: true,
    );

    return scaffold;
  }

  Future<void> onReportButtonClicked() async {
    await widget.friendInteractionProvider.reportOkay();
    setState(() {});
  }
}

String parseLastSeen(int lastSeen, String gender) {
  String result = '';

  if (lastSeen == 0) {
    return Consts.notReportedYet(gender);
  }

  int delta = DateTime.now().millisecondsSinceEpoch - lastSeen;
  Duration duration = Duration(milliseconds: delta);

  result = Consts.xTimeAgo(duration);
  return result;
}

class _ReportsPageConsts {
  static const String reportNow = 'שיתוף';
  static const String deleteFriend = 'מחיקת חיבור';
  static const neutralColor = Color.fromARGB(150, 170, 170, 170);
  static const dangerColor = Colors.redAccent;
  static const safeColor = Colors.greenAccent;
}

var buttons = (Future<void> Function() onReportButtonClicked) => [
      PurpleButton(
        showProgressIndicatorAfterClick: true,
        onClick: onReportButtonClicked,
        caption: _ReportsPageConsts.reportNow,
      ),
    ];

GFListTileDirectional getUserListing(AppUser user, BuildContext context,
    {Future<void> Function({required AppUser friend})? onUnfriendButtonClicked}) {
  void Function()? onLongPress = onUnfriendButtonClicked == null
      ? null
      : () async {
          await showMenu(
              context: context,
              position: RelativeRect.fromLTRB(100, 100, 100, 100),
              items: [
                PopupMenuItem(
                  onTap: () async {
                    await onUnfriendButtonClicked(friend: user);
                    // setState(() {});
                  },
                  child: Text(_ReportsPageConsts.deleteFriend),
                )
              ]);
        };
  return GFListTileDirectional(
    title: Text(user.fullName),
    direction: TextDirection.rtl,
    margin: const EdgeInsets.fromLTRB(5, 1, 1, 5),
    onLongPress: onLongPress,
    color: chooseUserColor(user),
    icon: Text(parseLastSeen(user.lastSeen, user.gender)),
    avatar: const Icon(Icons.person_rounded),
    shadow: const BoxShadow(blurStyle: BlurStyle.solid, color: Colors.transparent),
  );
}

Color chooseUserColor(AppUser user) {
  int realTime = DateTime.now().millisecondsSinceEpoch;
  int tenMinutes = 1000 * 60 * 10;

  bool isUserMarkedSafe = user.lastAlertTime <= user.lastSeen;
  bool has10MinutesPassedSinceLastAlert = (user.lastAlertTime + tenMinutes) <= realTime;

  if (!isUserMarkedSafe) {
    return _ReportsPageConsts.dangerColor;
  } else if (isUserMarkedSafe && !has10MinutesPassedSinceLastAlert) {
    return _ReportsPageConsts.safeColor;
  } else {
    return _ReportsPageConsts.neutralColor;
  }
}
