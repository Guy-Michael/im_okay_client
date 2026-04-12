import 'dart:async';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart' as lib_phone_number;
import 'package:im_okay/Services/ContactsService/i_contacts_service.dart';
import 'package:im_okay/Services/PermissionsService/i_permissions_service.dart';
import 'package:im_okay/Services/service_injector.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

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

  @override
  Future<List<String>> getNormalizedContactsPhoneNumbers() async {
    List<String> cannonicalNumbers = (await getAllContacts())
        .map(
          (e) {
            if (e.phones.isEmpty) {
              return "";
            }

            String phone = e.phones[0].number;
            return PhoneNumber.parse(phone, callerCountry: IsoCode.IL).international;
          },
        )
        .where((number) => number != "")
        .toList();

    return cannonicalNumbers;
  }

  @override
  String normalizePhoneNumber(String number) {
    return PhoneNumber.parse(number, callerCountry: IsoCode.IL).international;
  }
}
