import 'package:json_annotation/json_annotation.dart';

part 'request_access_key_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class RequestAccessKeyForm {
  const RequestAccessKeyForm(
      {required this.username,
      required this.refreshToken,
      required this.deviceCode,
      required this.orgCode});
  @JsonKey(name: 'org_code')
  final String orgCode;
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @JsonKey(name: 'device_code')
  final String deviceCode;

  factory RequestAccessKeyForm.fromJson(Map<String, dynamic> json) =>
      _$RequestAccessKeyFormFromJson(json);
  Map<String, dynamic> toJson() => _$RequestAccessKeyFormToJson(this);
}
