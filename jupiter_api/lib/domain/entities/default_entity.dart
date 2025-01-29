import 'package:json_annotation/json_annotation.dart';

class DefaultEntity {
  @JsonKey(name: 'message')
  final String message;
  DefaultEntity({required this.message});
}
