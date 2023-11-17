import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:im_okay/Enums/endpoint_enums.dart';
import 'package:im_okay/Utils/http_utils.dart';
import 'package:im_okay/Models/user.dart';
import 'dart:convert';

class FriendInteractionsApiService {
  static Future<void> respondToFriendRequest(
      User userToRespond, bool approveRequest) async {
    String uid = auth.FirebaseAuth.instance.currentUser!.uid;

    String endpoint = UsersController.responseToRequest.endpoint;
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

  static Future<List<User>> queryFriends(String searchQuery) async {
    String endpoint = UsersController.findFriends.endpoint;
    var body = {'query': searchQuery};

    String response = await HttpUtils.post(endpoint: endpoint, body: body);
    List<User> friends = List<dynamic>.from(json.decode(response))
        .map((e) => User.fromJson(e))
        .toList();
    return friends;
  }

  static Future<User> getFullUserDataByEmail({required String email}) async {
    String endpoint = UsersController.getUserData.endpoint;

    var body = {'email': email};

    String response = await HttpUtils.post(endpoint: endpoint, body: body);

    User user = User.fromJson(json.decode(response));

    return user;
  }

  static Future<List<User>> getAllFriends() async {
    String endpoint = UsersController.getFriendList.endpoint;

    String uid = auth.FirebaseAuth.instance.currentUser!.uid;
    var body = {'uid': uid};

    String responseBody = await HttpUtils.post(endpoint: endpoint, body: body);

    List temp = json.decode(responseBody);
    List<User> users = temp.map((u) {
      return User.fromJson(u);
    }).toList();

    return users;
  }

  static void sendFriendRequest({required User friend}) {
    String endpoint = UsersController.sendFriendRequest.endpoint;

    String requestorUid = auth.FirebaseAuth.instance.currentUser!.uid;
    var body = {'requestorUid': requestorUid, 'friendEmail': friend.email};

    HttpUtils.post(endpoint: endpoint, body: body);
  }

  static Future<void> reportOkay() async {
    String endpoint = UsersController.reportOkay.endpoint;
    String uid = auth.FirebaseAuth.instance.currentUser!.uid;
    var body = {'uid': uid};

    await HttpUtils.post(endpoint: endpoint, body: body);
  }

  // static Future<List<User>> getOutgoingPendingRequests() async {}
}
