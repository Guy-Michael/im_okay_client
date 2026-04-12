import 'package:flutter_contacts/contact.dart';

abstract class IContactsService {
  Future<List<Contact>> getAllContacts();

  Future<Contact?> getContact(String id);

  Future<List<String>> getNormalizedContactsPhoneNumbers();

  String normalizePhoneNumber(String number);
}
