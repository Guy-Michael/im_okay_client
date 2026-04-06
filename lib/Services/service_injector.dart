import 'package:get_it/get_it.dart';
import 'package:im_okay/Services/ApiServices/AlertsService/alerts_service.dart';
import 'package:im_okay/Services/ApiServices/AlertsService/i_alerts_service.dart';
import 'package:im_okay/Services/ApiServices/AuthenticationService/i_authentication_service.dart';
import 'package:im_okay/Services/ApiServices/KinInteractionService/i_kin_interaction_service.dart';
import 'package:im_okay/Services/ApiServices/KinInteractionService/kin_interaction_service.dart';
import 'package:im_okay/Services/ApiServices/AuthenticationService/authentication_service.dart';
import 'package:im_okay/Services/LocationService/i_location_service.dart';
import 'package:im_okay/Services/LocationService/location_service.dart';

GetIt serviceInjector = GetIt.instance;

void registerServices() {
  serviceInjector.registerSingleton<IKinInteractionsService>(KinInteractionsApiService());
  serviceInjector.registerSingleton<IAuthenticationService>(AuthenticationService());
  serviceInjector.registerSingleton<ILocationService>(LocationService());
  serviceInjector.registerSingleton<IAlertsService>(AlertsService());
}
