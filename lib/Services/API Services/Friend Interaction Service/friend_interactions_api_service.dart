import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:im_okay/Enums/endpoint_enums.dart';
import 'package:im_okay/Enums/friend_query_type_enum.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
import 'package:im_okay/Utils/http_utils.dart';
import 'package:im_okay/Models/user.dart';
import 'dart:convert';

class FriendInteractionsApiService implements IFriendInteractionsProvider {
  @override
  Future<void> respondToFriendRequest(User userToRespond, bool approveRequest) async {
    String uid = auth.FirebaseAuth.instance.currentUser!.uid;

    String endpoint = UsersController.responseToRequest.endpoint;
    var body = {'uid': uid, 'friendEmail': userToRespond.email, 'approveRequest': approveRequest};

    await HttpUtils.post(endpoint: endpoint, body: body);
  }

  @override
  Future<List<User>> getIncomingPendingRequests() async {
    String uid = auth.FirebaseAuth.instance.currentUser!.uid;
    var body = {'uid': uid};

    String endpoint = UsersController.getFriendRequests.endpoint;

    String responseBody = await HttpUtils.post(endpoint: endpoint, body: body);

    List<dynamic> list = json.decode(responseBody);
    List<User> requestors = list.map((dynamic element) => User.fromJson(element)).toList();
    return requestors;
  }

  Future<List<(User user, FriendQueryType relationship)>> queryFriends(String searchQuery) async {
    String endpoint = UsersController.findFriends.endpoint;
    String requestorUid = UserAuthenticationApiService.firebaseUser!.uid;
    var body = {'requestorUid': requestorUid, 'query': searchQuery};

    String response = await HttpUtils.post(endpoint: endpoint, body: body);
    List<dynamic> map = json.decode(response);
    List<(User user, FriendQueryType relationship)> fri = map.map((friend) {
      dynamic user = friend['user'];
      var json1 = User.fromJson(user);
      return (json1, FriendQueryType.parse(friend['relationship'].toString()));
    }).toList();
    return fri;
  }

  @override
  Future<User> getFullUserDataByEmail({required String email}) async {
    String endpoint = UsersController.getUserData.endpoint;

    var body = {'email': email};

    String response = await HttpUtils.post(endpoint: endpoint, body: body);

    User user = User.fromJson(json.decode(response));

    return user;
  }

  @override
  Future<List<User>> getAllFriends() async {
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

  @override
  Future<void> sendFriendRequest({required User friend}) async {
    String endpoint = UsersController.sendFriendRequest.endpoint;

    String requestorUid = auth.FirebaseAuth.instance.currentUser!.uid;
    var body = {'requestorUid': requestorUid, 'friendEmail': friend.email};

    await HttpUtils.post(endpoint: endpoint, body: body);
  }

  @override
  Future<void> reportOkay() async {
    String endpoint = UsersController.reportOkay.endpoint;
    String uid = auth.FirebaseAuth.instance.currentUser!.uid;
    var body = {'uid': uid};

    await HttpUtils.post(endpoint: endpoint, body: body);
  }
}
