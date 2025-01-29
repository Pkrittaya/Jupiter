import 'package:json_annotation/json_annotation.dart';

class TermAndConditionEntity {
  @JsonKey(name: 'header')
  final String header;
  @JsonKey(name: 'body')
  final String body;
  @JsonKey(name: 'footer')
  final String footer;
  TermAndConditionEntity(
      {required this.header, required this.body, required this.footer});
}
