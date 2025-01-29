import 'package:json_annotation/json_annotation.dart';

part 'delete_account_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class DeleteAccountForm {
  DeleteAccountForm({
    required this.password,
  });
  @JsonKey(name: 'password')
  final String password;

  factory DeleteAccountForm.fromJson(Map<String, dynamic> json) =>
      _$DeleteAccountFormFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteAccountFormToJson(this);
}
