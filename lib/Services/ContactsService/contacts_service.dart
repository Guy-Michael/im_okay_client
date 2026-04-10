import 'dart:async';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:im_okay/Services/ContactsService/i_contacts_service.dart';
import 'package:im_okay/Services/PermissionsService/i_permissions_service.dart';
import 'package:im_okay/Services/service_injector.dart';

class ContactsService implements IContactsService {
  late final IPermissionsService _permissionsService;
  ContactsService() {
    _permissionsService = serviceInjector.get<IPermissionsService>();
  }

  @override
  Future<List<Contact>> getAllContacts() async {
    bool permissionGranted = await _permissionsService.requestContactsPermission();
    if (!permissionGranted) {
      return List.empty();
    }

    List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true);
    return contacts;
  }

  @override
  Future<Contact?> getContact(String id) async {
    bool permissionGranted = await _permissionsService.requestContactsPermission();
    if (!permissionGranted) {
      return null;
    }
    return await FlutterContacts.getContact(id);
  }
}
