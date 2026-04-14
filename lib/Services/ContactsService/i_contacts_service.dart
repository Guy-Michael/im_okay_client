import 'package:im_okay/Models/app_contact.dart';
import 'package:im_okay/Models/cached_user_data.dart';
import 'package:im_okay/Models/search_query_response.dart';

abstract class IContactsService {
  Future<List<AppContact>> getAllContacts();

  Future<List<String>> getNormalizedContactsPhoneNumbers();

  String normalizePhoneNumber(String number);

  Future<List<CachedUserData>> mapAppUserToAppContact(List<SearchQueryResponse> users,
      {List<AppContact>? contacts});
}
