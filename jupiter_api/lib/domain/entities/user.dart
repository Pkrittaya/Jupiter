import 'package:json_annotation/json_annotation.dart';

class User {
  @JsonKey(name: 'full_name')
  final String fullName;
  @JsonKey(name: 'mobile')
  final String mobile;

  User({
    required this.fullName,
    required this.mobile,
  });
}
