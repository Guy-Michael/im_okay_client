import 'package:im_okay/Models/search_query_response.dart';
import 'package:im_okay/Models/app_user.dart';

abstract class IFriendInteractionsProvider {
  Future<void> respondToFriendRequest(AppUser userToRespond, bool approveRequest);

  Future<List<AppUser>> getIncomingPendingRequests();

  Future<List<SearchQueryResponse>> queryFriends(String searchQuery);

  Future<List<AppUser>> getAllFriends();

  Future<void> sendFriendRequest({required AppUser friend});

  Future<void> cancelFriendRequest({required AppUser friend});

  Future<void> unfriendUser({required AppUser friend});

  Future<void> reportOkay();
}
