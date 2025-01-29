import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/data/data_models/response/notification_data_news_model.dart';
import 'package:jupiter_api/domain/entities/notification_news.dart';

part 'notification_news_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class NotificationNewsModel extends NotificationNewsEntity {
  NotificationNewsModel({
    required super.numberReadStatus,
    required this.dataNotification,
  }) : super(dataNotification: dataNotification);

  @override
  @JsonKey(name: 'data_notification')
  final List<NotificationNewsDataModel> dataNotification;

  factory NotificationNewsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationNewsModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationNewsModelToJson(this);
}
