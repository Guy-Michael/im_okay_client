import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:im_okay/Enums/endpoint_enums.dart';
import 'package:im_okay/Models/app_contact.dart';
import 'package:im_okay/Models/cached_user_data.dart';
import 'package:im_okay/Models/search_query_response.dart';
import 'package:im_okay/Services/ContactsService/i_contacts_service.dart';
import 'package:im_okay/Services/KinInteractionService/i_kin_interaction_service.dart';
import 'package:im_okay/Services/service_injector.dart';
import 'package:im_okay/Utils/http_utils.dart';
import 'package:im_okay/Models/app_user.dart';
import 'dart:convert';

class KinInteractionsApiService implements IKinInteractionsService {
  late final IContactsService _contactsService;

  KinInteractionsApiService() {
    _contactsService = serviceInjector.get<IContactsService>();
  }

  @override
  Future<void> respondToKinRequest(AppUser userToRespond, bool approveRequest) async {
    String endpoint = SocialController.responseToRequest.endpoint;
    var body = {'uid': userToRespond.uid, 'isApproved': approveRequest};

    await HttpUtils.post(endpoint: endpoint, body: body);
  }

  @override
  Future<List<AppUser>> getIncomingPendingRequests() async {
    String uid = auth.FirebaseAuth.instance.currentUser!.uid;
    var body = {'uid': uid};

    String endpoint = SocialController.getFriendRequests.endpoint;

    String responseBody = await HttpUtils.post(endpoint: endpoint, body: body);

    List<dynamic> list = json.decode(responseBody);
    List<AppUser> requestors = list.map((dynamic element) => AppUser.fromJson(element)).toList();
    return requestors;
  }

  @override
  Future<List<SearchQueryResponse>> queryFriends(String searchQuery) async {
    String endpoint = SocialController.findFriends.endpoint;
    var queryParams = {'query': searchQuery};

    String response = await HttpUtils.get(endpoint: endpoint, queryParams: queryParams);
    List<SearchQueryResponse> queryResponse = SearchQueryResponse.parseList(response);

    return queryResponse;
  }

  @override
  Future<List<AppUser>> getAllKin() async {
    String endpoint = SocialController.getFriendList.endpoint;

    String responseBody = await HttpUtils.get(endpoint: endpoint);

    List temp = json.decode(responseBody);
    List<AppUser> users = temp.map((u) {
      return AppUser.fromJson(u);
    }).toList();

    return users;
  }

  @override
  Future<void> sendFriendRequest({required CachedUserData user}) async {
    String endpoint = SocialController.sendFriendRequest.endpoint;

    var body = {'uid': user.uid};

    await HttpUtils.post(endpoint: endpoint, body: body);
  }

  @override
  Future<void> reportOkay() async {
    String endpoint = SocialController.reportOkay.endpoint;

    await HttpUtils.get(endpoint: endpoint);
  }

  @override
  Future<void> cancelFriendRequest({required CachedUserData user}) async {
    String endpoint = SocialController.cancelFriendRequest.endpoint;
    throw Exception("Change this to uid and not email!");
    // var body = {'friendEmail': user.email};

    // await HttpUtils.post(endpoint: endpoint, body: body);
  }

  @override
  Future<void> unfriendUser({required AppUser friend}) async {
    String endpoint = SocialController.unfriend.endpoint;
    var body = {'friendEmail': friend.email};

    await HttpUtils.post(endpoint: endpoint, body: body);
  }

  @override
  Future<List<CachedUserData>> getContactToAppUserAssociations() async {
    List<AppContact> contacts = await _contactsService.getAllContacts();
    List<String> phoneNumbers = contacts.map((contact) => contact.normalizedPhoneNumber).toList();

    //TODO: uncomment encryption
    // List<String> encryptedPhoneNumbers = phoneNumbers.map(EncryptionUtils.encrypt).toList();
    // var body = {'phoneNumbers': encryptedPhoneNumbers};

    var body = {'phoneNumbers': phoneNumbers};

    String endpoint = SocialController.associateContactToUser.endpoint;

    String responseBody = await HttpUtils.post(endpoint: endpoint, body: body);
    List temp = json.decode(responseBody);
    List<SearchQueryResponse> queryResponses = SearchQueryResponse.parseList(responseBody);

    List<CachedUserData> usersData =
        await _contactsService.mapAppUserToAppContact(queryResponses, contacts: contacts);
    return usersData;
  }
}
