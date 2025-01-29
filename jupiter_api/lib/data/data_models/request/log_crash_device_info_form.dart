import 'package:json_annotation/json_annotation.dart';

part 'log_crash_device_info_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class LogCrashDeviceInfoForm {
  LogCrashDeviceInfoForm({
    required this.deviceCode,
    required this.platform,
    required this.model,
    required this.osVersion,
    required this.appVersion,
  });

  @JsonKey(name: 'device_code')
  final String deviceCode;
  @JsonKey(name: 'platform')
  final String platform;
  @JsonKey(name: 'model')
  final String model;
  @JsonKey(name: 'os_version')
  final String osVersion;
  @JsonKey(name: 'app_version')
  final String appVersion;

  factory LogCrashDeviceInfoForm.fromJson(Map<String, dynamic> json) =>
      _$LogCrashDeviceInfoFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$LogCrashDeviceInfoFormToJson(this);
}
