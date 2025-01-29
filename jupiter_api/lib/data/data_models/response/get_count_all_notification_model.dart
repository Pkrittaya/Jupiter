import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/domain/entities/get_count_all_notification_entity.dart';

part 'get_count_all_notification_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class CountAllNotificationModel extends CountAllNotificationEntity {
  CountAllNotificationModel({required super.numberReadStatus});

  factory CountAllNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$CountAllNotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$CountAllNotificationModelToJson(this);
}
