import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/domain/entities/notification_data_news_entity.dart';

part 'notification_data_news_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class NotificationNewsDataModel extends NotificationNewsDataEntity {
  NotificationNewsDataModel(
      {required super.notificationIndex,
      required super.messageType,
      required super.messageCreate,
      required super.messageTitle,
      required super.messageBody,
      required super.messageData,
      required super.linkInformation,
      required super.image,
      required super.statusRead});

  factory NotificationNewsDataModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationNewsDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationNewsDataModelToJson(this);
}
