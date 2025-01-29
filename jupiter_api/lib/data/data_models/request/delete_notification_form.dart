import 'package:json_annotation/json_annotation.dart';

part 'delete_notification_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class DeleteNotificationForm {
  DeleteNotificationForm({
    required this.notificationOperator,
    required this.notificationIndex,
    required this.notificationType,
  });
  @JsonKey(name: 'notification_operator')
  final String notificationOperator;
  @JsonKey(name: 'notification_index')
  final int notificationIndex;
  @JsonKey(name: 'notification_type')
  final String notificationType;

  factory DeleteNotificationForm.fromJson(Map<String, dynamic> json) =>
      _$DeleteNotificationFormFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteNotificationFormToJson(this);
}
