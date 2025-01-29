import 'package:json_annotation/json_annotation.dart';

class ProfileEntity {
  ProfileEntity({
    required this.username,
    required this.name,
    required this.lastname,
    required this.gender,
    required this.dateofbirth,
    required this.telphonenumber,
    required this.images,
  });
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'lastname')
  final String lastname;
  @JsonKey(name: 'gender')
  final String gender;
  @JsonKey(name: 'dateofbirth')
  final String dateofbirth;
  @JsonKey(name: 'telphonenumber')
  final String telphonenumber;
  @JsonKey(name: 'images')
  final String images;
}
