import 'package:im_okay/Models/search_query_response.dart';
import 'package:im_okay/Models/app_user.dart';

abstract class IKinInteractionsService {
  Future<void> respondToKinRequest(AppUser userToRespond, bool approveRequest);

  Future<List<AppUser>> getIncomingPendingRequests();

  Future<List<SearchQueryResponse>> queryFriends(String searchQuery);

  Future<List<AppUser>> getAllKin();

  Future<void> sendFriendRequest({required AppUser user});

  Future<void> cancelFriendRequest({required AppUser user});

  Future<void> unfriendUser({required AppUser friend});

  Future<void> reportOkay();
}
