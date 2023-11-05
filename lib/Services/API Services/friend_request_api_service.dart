import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:im_okay/Utils/http_utils.dart';
import 'package:im_okay/Models/user.dart';
import 'dart:convert';

enum FriendsController {
  route('friends'),
  reportOkay('report'),
  getFriendList('friends-status'),
  sendFriendRequest("add-friend"),
  responseToRequest("respond");

  final String value;
  const FriendsController(this.value);
  String get endpoint => '${route.value}/$value';
}

class FriendInteractionsApiService {
  static Future<void> respondToFriendRequest(
      User userToRespond, bool approveRequest) async {
    String uid = auth.FirebaseAuth.instance.currentUser!.uid;

    String endpoint = FriendsController.responseToRequest.endpoint;
    var body = {
      'uid': uid,
      'friendEmail': userToRespond.email,
      'approveRequest': approveRequest
    };

    await HttpUtils.post(endpoint: endpoint, body: body);
  }

  static Future<List<User>> getIncomingPendingRequests() async {
    String uid = auth.FirebaseAuth.instance.currentUser!.uid;
    var body = {'uid': uid};

    String endpoint = UsersController.getFriendRequests.endpoint;

    String responseBody = await HttpUtils.post(endpoint: endpoint, body: body);

    List<dynamic> list = json.decode(responseBody);
    List<User> requestors =
        list.map((dynamic element) => User.fromJson(element)).toList();
    return requestors;
  }

  static Future<List<User>> getAllFriends() async {
    String endpoint = FriendsController.getFriendList.endpoint;

    String uid = auth.FirebaseAuth.instance.currentUser!.uid;
    var body = {'uid': uid};

    String responseBody = await HttpUtils.post(endpoint: endpoint, body: body);

    List temp = json.decode(responseBody);
    List<User> users = temp.map((u) {
      return User.fromJson(u);
    }).toList();

    return users;
  }

  static Future<void> reportOkay() async {
    String endpoint = FriendsController.reportOkay.endpoint;
    String uid = auth.FirebaseAuth.instance.currentUser!.uid;
    var body = {'uid': uid};

    await HttpUtils.post(endpoint: endpoint, body: body);
  }

  // static Future<List<User>> getOutgoingPendingRequests() async {}
}
