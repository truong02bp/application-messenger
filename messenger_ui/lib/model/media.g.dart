// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Media _$MediaFromJson(Map<String, dynamic> json) {
  return Media(
    id: json['id'] as int,
    name: json['name'] as String,
    contentType: json['contentType'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'contentType': instance.contentType,
      'url': instance.url,
    };
