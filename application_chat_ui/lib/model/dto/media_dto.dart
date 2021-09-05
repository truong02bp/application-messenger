import 'package:json_annotation/json_annotation.dart';
part 'media_dto.g.dart';

@JsonSerializable()
class MediaDto {
  String name;
  String? contentType;
  String? url;
  String bytes;

  MediaDto({required this.name, this.contentType, this.url, required this.bytes});

  factory MediaDto.fromJson(Map<String, dynamic> json) => _$MediaDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MediaDtoToJson(this);

}