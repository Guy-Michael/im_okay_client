enum AuthController {
  route('auth'),
  registerEndpoint('register'),
  loginEndpoint('login'),
  deleteUser('delete');

  final String value;
  const AuthController(this.value);
  String get endpoint {
    return '${route.value}/$value';
  }
}

enum UsersController {
  route('friends'),
  reportOkay('report'),
  findFriends('find-friends'),
  getUserData('full-user-data'),
  getFriendList('friends-status'),
  sendFriendRequest("add-friend"),
  responseToRequest("respond"),
  getFriendRequests('get-requests');

  final String value;
  const UsersController(this.value);
  String get endpoint => '${route.value}/$value';
}
