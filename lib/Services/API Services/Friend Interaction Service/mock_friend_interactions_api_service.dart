import 'package:im_okay/Enums/friend_query_type_enum.dart';
import 'package:im_okay/Models/user.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/Utils/Consts/consts.dart';

class MockFriendInteractionsApiService implements IFriendInteractionsProvider {
  final List<AppUser> _userList = [
    AppUser(
        firstName: 'Test 1',
        lastName: 'User 1',
        email: 'fake@imokay.com',
        gender: Gender.male,
        lastSeen: 0),
    AppUser(
        firstName: 'Test 2',
        lastName: 'User 2',
        email: 'fake@imokay.com',
        gender: Gender.male,
        lastSeen: 0),
    AppUser(
        firstName: 'Test 3',
        lastName: 'User 3',
        email: 'fake@imokay.com',
        gender: Gender.male,
        lastSeen: 0),
  ];

  final AppUser _singleUser = AppUser(
      firstName: 'Kamila',
      lastName: 'Flowers',
      email: 'kamila@imokay.com',
      gender: Gender.female,
      lastSeen: 0);

  Future<void> _waitASec() async {
    await Future.delayed(const Duration(seconds: 1));
    return;
  }

  @override
  Future<List<AppUser>> getAllFriends() async {
    await _waitASec();

    return _userList;
  }

  @override
  Future<AppUser> getFullUserDataByEmail({required String email}) async {
    await _waitASec();

    return _singleUser;
  }

  @override
  Future<List<AppUser>> getIncomingPendingRequests() async {
    await _waitASec();

    return _userList;
  }

  @override
  Future<List<(AppUser user, FriendQueryType relationship)>> queryFriends(
      String searchQuery) async {
    return _userList.map((e) => (e, FriendQueryType.noRelationship)).toList();
  }

  @override
  Future<void> reportOkay() async {
    return;
  }

  @override
  Future<void> respondToFriendRequest(AppUser userToRespond, bool approveRequest) async {
    return;
  }

  @override
  Future<void> sendFriendRequest({required AppUser friend}) async {
    return;
  }
}
