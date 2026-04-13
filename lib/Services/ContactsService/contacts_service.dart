import 'dart:async';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:im_okay/Models/app_contact.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/Models/search_query_response.dart';
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
  Future<List<AppContact>> getAllContacts() async {
    bool permissionGranted = await _permissionsService.requestContactsPermission();
    if (!permissionGranted) {
      return List.empty();
    }

    List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true);
    List<AppContact> appContacts = contacts.map((contact) {
      String phone = _getPhoneNumber(contact);
      return AppContact(
          firstName: contact.name.first, lastName: contact.name.last, normalizedPhoneNumber: phone);
    }).toList();
    return appContacts;
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
    List<String> appContacts = (await getAllContacts())
        .map((contact) => contact.normalizedPhoneNumber)
        .where((number) => number != "")
        .toList();

    return appContacts;
  }

  @override
  String normalizePhoneNumber(String number) {
    return PhoneNumber.parse(number, callerCountry: IsoCode.IL).international;
  }

  String _getPhoneNumber(Contact contact) {
    if (contact.phones.isEmpty) {
      return "";
    }

    String phone = contact.phones[0].number;
    return PhoneNumber.parse(phone, callerCountry: IsoCode.IL).international;
  }

  @override
  Future<List<AppContact>> mapAppUserToAppContact(List<SearchQueryResponse> users) async {
    List<AppContact> contacts = await getAllContacts();
    List<String> phones = users.map((user) => user.user.phoneNumber).toList();

    // var a = contacts.where((contact) => phones.contains(contact.normalizedPhoneNumber)).toList();
    List<(AppContact, SearchQueryResponse)> results = [];

    for (SearchQueryResponse response in users) {
      String phone = response.user.phoneNumber;
      AppContact contact = contacts.firstWhere((element) => element.normalizedPhoneNumber == phone);
      var model = {
        'name': response.user.fullName,
        'uid': response.user.uid,
        'phone': contact.normalizedPhoneNumber,
        'image': response.user.imageUrl,
        'relationship': response.relationship.value
      };
      results.add((contact, response));
    }

    // var model = {uid, name, image, relationship};
    return [];
  }
}
