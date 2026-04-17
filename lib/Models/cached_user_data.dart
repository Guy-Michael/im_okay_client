import 'package:im_okay/Enums/relationship_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cached_user_data.g.dart';

@JsonSerializable()
class CachedUserData {
  String name;
  String uid;
  String phone;
  String image;
  Relationship relationship;

  CachedUserData(
      {required this.image,
      required this.uid,
      required this.phone,
      required this.name,
      required this.relationship});

  factory CachedUserData.fromJson(Map<String, dynamic> json) => _$CachedUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$CachedUserDataToJson(this);
}
