import 'package:json_annotation/json_annotation.dart';

part 'active_notification_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ActiveNotificationForm {
  ActiveNotificationForm({
    required this.notificationIndex,
    required this.notificationType,
  });
  @JsonKey(name: 'notification_index')
  final int notificationIndex;
  @JsonKey(name: 'notification_type')
  final String notificationType;

  factory ActiveNotificationForm.fromJson(Map<String, dynamic> json) =>
      _$ActiveNotificationFormFromJson(json);
  Map<String, dynamic> toJson() => _$ActiveNotificationFormToJson(this);
}
