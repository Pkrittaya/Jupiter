import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/domain/entities/notification_setting_entity.dart';

part 'notification_setting_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class NotificationSettingModel extends NotificationSettingEntity {
  NotificationSettingModel({
    required super.notificationSystem,
    required super.notificationNews,
  });

  factory NotificationSettingModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationSettingModelToJson(this);
}
