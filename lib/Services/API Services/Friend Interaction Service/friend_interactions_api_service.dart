import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:im_okay/Enums/endpoint_enums.dart';
import 'package:im_okay/Models/search_query_response.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/Utils/http_utils.dart';
import 'package:im_okay/Models/app_user.dart';
import 'dart:convert';

class FriendInteractionsApiService implements IFriendInteractionsProvider {
  @override
  Future<void> respondToFriendRequest(AppUser userToRespond, bool approveRequest) async {
    String endpoint = UsersController.responseToRequest.endpoint;
    var body = {'friendEmail': userToRespond.email, 'isApproved': approveRequest};

    await HttpUtils.post(endpoint: endpoint, body: body);
  }

  @override
  Future<List<AppUser>> getIncomingPendingRequests() async {
    String uid = auth.FirebaseAuth.instance.currentUser!.uid;
    var body = {'uid': uid};

    String endpoint = UsersController.getFriendRequests.endpoint;

    String responseBody = await HttpUtils.post(endpoint: endpoint, body: body);

    List<dynamic> list = json.decode(responseBody);
    List<AppUser> requestors = list.map((dynamic element) => AppUser.fromJson(element)).toList();
    return requestors;
  }

  @override
  Future<List<SearchQueryResponse>> queryFriends(String searchQuery) async {
    String endpoint = UsersController.findFriends.endpoint;
    var queryParams = {'query': searchQuery};

    String response = await HttpUtils.get(endpoint: endpoint, queryParams: queryParams);
    List<SearchQueryResponse> queryResponse = SearchQueryResponse.parseList(response);

    return queryResponse;
  }

  @override
  Future<List<AppUser>> getAllFriends() async {
    String endpoint = UsersController.getFriendList.endpoint;

    String responseBody = await HttpUtils.get(endpoint: endpoint);

    List temp = json.decode(responseBody);
    List<AppUser> users = temp.map((u) {
      return AppUser.fromJson(u);
    }).toList();

    return users;
  }

  @override
  Future<void> sendFriendRequest({required AppUser friend}) async {
    String endpoint = UsersController.sendFriendRequest.endpoint;

    var body = {'friendEmail': friend.email};

    await HttpUtils.post(endpoint: endpoint, body: body);
  }

  @override
  Future<void> reportOkay() async {
    String endpoint = UsersController.reportOkay.endpoint;

    await HttpUtils.get(endpoint: endpoint);
  }

  @override
  Future<void> cancelFriendRequest({required AppUser friend}) async {
    String endpoint = UsersController.cancelFriendRequest.endpoint;

    var body = {'friendEmail': friend.email};

    await HttpUtils.post(endpoint: endpoint, body: body);
  }

  @override
  Future<void> unfriendUser({required AppUser friend}) async {
    String endpoint = UsersController.unfriend.endpoint;
    var body = {'friendEmail': friend.email};

    await HttpUtils.post(endpoint: endpoint, body: body);
  }
}
