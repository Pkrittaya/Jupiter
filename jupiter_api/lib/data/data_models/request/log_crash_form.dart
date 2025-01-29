import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/data/data_models/request/log_crash_device_info_form.dart';

import 'only_org_form.dart';

part 'log_crash_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class LogCrashForm extends OnlyOrgForm {
  LogCrashForm({
    required super.orgCode,
    required this.username,
    required this.title,
    required this.message,
    required this.stack,
    required this.deviceInfo,
  });

  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'stack')
  final String stack;
  @JsonKey(name: 'device_info')
  final LogCrashDeviceInfoForm deviceInfo;

  factory LogCrashForm.fromJson(Map<String, dynamic> json) =>
      _$LogCrashFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$LogCrashFormToJson(this);
}
