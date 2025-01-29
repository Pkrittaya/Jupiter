import 'package:json_annotation/json_annotation.dart';

part 'verify_account_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class VerifyAccountForm {
  const VerifyAccountForm(
      {required this.username,
      required this.password,
      required this.name,
      required this.lastname,
      required this.telphonenumber,
      required this.gender,
      required this.dateofbirth,
      required this.orgCode,
      required this.language});

  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'lastname')
  final String lastname;
  @JsonKey(name: 'telphonenumber')
  final String telphonenumber;
  @JsonKey(name: 'gender')
  final String gender;
  @JsonKey(name: 'dateofbirth')
  final DateTime dateofbirth;
  @JsonKey(name: 'org_code')
  final String orgCode;
  @JsonKey(name: 'language')
  final String language;

  factory VerifyAccountForm.fromJson(Map<String, dynamic> json) =>
      _$VerifyAccountFormFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyAccountFormToJson(this);
}
