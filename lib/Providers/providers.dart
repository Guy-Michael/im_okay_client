import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:im_okay/Services/AuthenticationService/i_authentication_service.dart';
import 'package:im_okay/Services/KinInteractionService/i_kin_interaction_service.dart';
import 'package:im_okay/Services/LocationService/i_location_service.dart';
import 'package:im_okay/Services/service_injector.dart';
import 'package:im_okay/Utils/stream_utils.dart';

IKinInteractionsService _kinInteractionService = serviceInjector.get<IKinInteractionsService>();
IAuthenticationService _authService = serviceInjector.get<IAuthenticationService>();
ILocationService _locationService = serviceInjector.get<ILocationService>();

final userProvider = StreamProvider.autoDispose((_) {
  return StreamUtils.initStream(func: _authService.fetchUser, duration: Duration(seconds: 10));
});

final kinProvider = StreamProvider.autoDispose(
  (_) {
    return StreamUtils.initStream(
        func: _kinInteractionService.getAllKin, duration: Duration(seconds: 5));
  },
);

final alertZoneProvider = StreamProvider.autoDispose((_) {
  return StreamUtils.initStream(
      func: _locationService.getUserAlertZone, duration: Duration(seconds: 30));
});
