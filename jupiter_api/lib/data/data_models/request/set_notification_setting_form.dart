import 'package:json_annotation/json_annotation.dart';

part 'set_notification_setting_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class SetNotificationSettingForm {
  SetNotificationSettingForm(
      {required this.notificationSystem, required this.notificationNews});
  @JsonKey(name: 'notification_system')
  final bool notificationSystem;
  @JsonKey(name: 'notification_news')
  final bool notificationNews;

  factory SetNotificationSettingForm.fromJson(Map<String, dynamic> json) =>
      _$SetNotificationSettingFormFromJson(json);
  Map<String, dynamic> toJson() => _$SetNotificationSettingFormToJson(this);
}
