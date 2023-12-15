import 'package:im_okay/Enums/friend_query_type_enum.dart';
import 'package:im_okay/Models/user.dart';

abstract class IFriendInteractionsProvider {
  Future<void> respondToFriendRequest(User userToRespond, bool approveRequest);

  Future<List<User>> getIncomingPendingRequests();

  Future<List<(User user, FriendQueryType relationship)>> queryFriends(String searchQuery);

  Future<User> getFullUserDataByEmail({required String email});

  Future<List<User>> getAllFriends();

  void sendFriendRequest({required User friend});

  Future<void> reportOkay();
}
