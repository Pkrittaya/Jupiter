import 'package:json_annotation/json_annotation.dart';

import 'only_org_form.dart';

part 'status_charger_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class StatusChargerForm extends OnlyOrgForm {
  StatusChargerForm({
    required super.orgCode,
    required this.username,
    required this.deviceCode,
  });
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'device_code')
  final String deviceCode;

  factory StatusChargerForm.fromJson(Map<String, dynamic> json) =>
      _$StatusChargerFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$StatusChargerFormToJson(this);
}
