enum AuthController {
  route('auth'),
  registerEndpoint('register'),
  fetchUserEndpoint('fetch-user'),
  deleteUser('delete');

  final String value;
  const AuthController(this.value);
  String get endpoint {
    return '${route.value}/$value';
  }
}

enum UsersController {
  route('social'),
  reportOkay('report'),
  findFriends('query'),
  getFriendList('friends-status'),
  sendFriendRequest("add-friend"),
  cancelFriendRequest('cancel-request'),
  unfriend('unfriend'),
  responseToRequest('respond'),
  getFriendRequests('get-requests');

  final String value;
  const UsersController(this.value);
  String get endpoint => '${route.value}/$value';
}

enum AlertsController {
  route('alerts'),
  reportActiveAlert('user-alert');

  final String value;
  const AlertsController(this.value);
  String get endpoint => '${route.value}/$value';
}
