import 'package:im_okay/Enums/friend_query_type_enum.dart';
import 'package:im_okay/Models/user.dart';

abstract class IFriendInteractionsProvider {
  Future<void> respondToFriendRequest(AppUser userToRespond, bool approveRequest);

  Future<List<AppUser>> getIncomingPendingRequests();

  Future<List<(AppUser user, FriendQueryType relationship)>> queryFriends(String searchQuery);

  Future<AppUser> getFullUserDataByEmail({required String email});

  Future<List<AppUser>> getAllFriends();

  Future<void> sendFriendRequest({required AppUser friend});

  Future<void> reportOkay();
}
