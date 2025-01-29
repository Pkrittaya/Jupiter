import 'package:json_annotation/json_annotation.dart';

class NotiDataEntity {
  NotiDataEntity({
    required this.title,
    required this.body,
    required this.readStatus,
    required this.messageCreate,
  });
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'body')
  final String body;
  @JsonKey(name: 'read_status')
  final bool? readStatus;
  @JsonKey(name: 'message_create')
  final String? messageCreate;
}
