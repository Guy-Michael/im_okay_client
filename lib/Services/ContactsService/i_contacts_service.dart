import 'package:flutter_contacts/contact.dart';
import 'package:im_okay/Models/app_contact.dart';
import 'package:im_okay/Models/search_query_response.dart';

abstract class IContactsService {
  Future<List<AppContact>> getAllContacts();

  Future<Contact?> getContact(String id);

  Future<List<String>> getNormalizedContactsPhoneNumbers();

  String normalizePhoneNumber(String number);

  Future<List<AppContact>> mapAppUserToAppContact(List<SearchQueryResponse> users);
}
