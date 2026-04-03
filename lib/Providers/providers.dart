import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/kin_interaction_service.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
import 'package:im_okay/Utils/stream_utils.dart';

final _kinInteractionService = KinInteractionsApiService();

final userProvider = StreamProvider.autoDispose((_) {
  return StreamUtils.initStream(
      func: UserAuthenticationApiService.fetchUser, duration: Duration(seconds: 10));
});

final kinProvider = StreamProvider.autoDispose(
  (_) {
    return StreamUtils.initStream(
        func: _kinInteractionService.getAllKin, duration: Duration(seconds: 5));
  },
);
