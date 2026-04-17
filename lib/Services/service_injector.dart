import 'package:get_it/get_it.dart';
import 'package:im_okay/Logger/i_logger.dart';
import 'package:im_okay/Logger/logger.dart';
import 'package:im_okay/Services/AlertsService/alerts_service.dart';
import 'package:im_okay/Services/AlertsService/i_alerts_service.dart';
import 'package:im_okay/Services/AuthenticationService/i_authentication_service.dart';
import 'package:im_okay/Services/CacheService/Abstract/i_cache_service.dart';
import 'package:im_okay/Services/CacheService/Concrete/cache_service.dart';
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

Future<void> registerServices() async {
  _registerService<ILogger, Logger>(Logger());
  _registerService<IPermissionsService, PermissionsService>(PermissionsService());
  _registerService<IContactsService, ContactsService>(ContactsService());
  _registerService<IKinInteractionsService, KinInteractionsApiService>(KinInteractionsApiService());
  _registerService<IAuthenticationService, AuthenticationService>(AuthenticationService());
  _registerService<ILocationService, LocationService>(LocationService());
  _registerService<IAlertsService, AlertsService>(AlertsService());
  _registerService<INotificationsService, NotificationsService>(await NotificationsService.init());
  _registerService<ICacheService, CacheService>(CacheService());
}

void _registerService<IT extends Object, T extends IT>(T implementation) {
  if (!serviceInjector.isRegistered<IT>()) serviceInjector.registerSingleton<IT>(implementation);
}
