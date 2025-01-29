import 'package:json_annotation/json_annotation.dart';

import 'username_and_orgcode_form.dart';

part 'profile_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ProfileForm extends UsernameAndOrgCodeForm {
  ProfileForm({
    required super.username,
    required super.orgCode,
    required this.name,
    required this.lastname,
    required this.gender,
    required this.dateofbirth,
    required this.telphonenumber,
  });
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

  factory ProfileForm.fromJson(Map<String, dynamic> json) =>
      _$ProfileFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ProfileFormToJson(this);
}
