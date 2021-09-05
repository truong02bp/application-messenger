import 'package:json_annotation/json_annotation.dart';
part 'media.g.dart';

@JsonSerializable()
class Media {
  int id;
  String name;
  String contentType;
  String url;

  Media({required this.id, required this.name, required this.contentType, required this.url});

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

  Map<String, dynamic> toJson() => _$MediaToJson(this);
}