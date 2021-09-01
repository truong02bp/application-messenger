import 'package:json_annotation/json_annotation.dart';
part 'reaction.g.dart';

@JsonSerializable()
class Reaction {
  int id;
  String code;
  String name;

  Reaction({required this.id, required this.code, required this.name});

  factory Reaction.fromJson(Map<String, dynamic> json) => _$ReactionFromJson(json);

  Map<String, dynamic> toJson() => _$ReactionToJson(this);
}