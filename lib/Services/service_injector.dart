import 'package:get_it/get_it.dart';
import 'package:im_okay/Services/AlertsService/alerts_service.dart';
import 'package:im_okay/Services/AlertsService/i_alerts_service.dart';
import 'package:im_okay/Services/AuthenticationService/i_authentication_service.dart';
import 'package:im_okay/Services/ContactsService/contacts_service.dart';
import 'package:im_okay/Services/ContactsService/i_contacts_service.dart';
import 'package:im_okay/Services/KinInteractionService/i_kin_interaction_service.dart';
import 'package:im_okay/Services/KinInteractionService/kin_interaction_service.dart';
import 'package:im_okay/Services/AuthenticationService/authentication_service.dart';
import 'package:im_okay/Services/LocationService/i_location_service.dart';
import 'package:im_okay/Services/LocationService/location_service.dart';
import 'package:im_okay/Services/NotificationServices/i_notifications_service.dart';
import 'package:im_okay/Services/NotificationServices/notifications_service.dart';
import 'package:im_okay/Services/PermissionsService/i_permissions_service.dart';
import 'package:im_okay/Services/PermissionsService/permissions_service.dart';

GetIt serviceInjector = GetIt.instance;

void registerServices() {
  serviceInjector.registerSingleton<IPermissionsService>(PermissionsService());
  serviceInjector.registerSingleton<IKinInteractionsService>(KinInteractionsApiService());
  serviceInjector.registerSingleton<IAuthenticationService>(AuthenticationService());
  serviceInjector.registerSingleton<ILocationService>(LocationService());
  serviceInjector.registerSingleton<IAlertsService>(AlertsService());
  serviceInjector.registerSingleton<INotificationsService>(NotificationsService());
  serviceInjector.registerSingleton<IContactsService>(ContactsService());
}
