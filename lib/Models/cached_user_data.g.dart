// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CachedUserData _$CachedUserDataFromJson(Map<String, dynamic> json) =>
    CachedUserData(
      image: json['image'] as String,
      uid: json['uid'] as String,
      phone: json['phone'] as String,
      name: json['name'] as String,
      relationship: $enumDecode(_$RelationshipEnumMap, json['relationship']),
    );

Map<String, dynamic> _$CachedUserDataToJson(CachedUserData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'uid': instance.uid,
      'phone': instance.phone,
      'image': instance.image,
      'relationship': _$RelationshipEnumMap[instance.relationship]!,
    };

const _$RelationshipEnumMap = {
  Relationship.friendsWith: 'friendsWith',
  Relationship.friendshipRequested: 'friendshipRequested',
  Relationship.noRelationship: 'noRelationship',
};
