import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/list_notification_entity.dart';
import 'notification_model.dart';

part 'list_notification_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ListNotificationModel extends ListNotificationEntity {
  ListNotificationModel({
    required super.numberReadStatus,
    required this.dataNotification,
  }) : super(dataNotification: dataNotification);

  @override
  @JsonKey(name: 'data_notification')
  final List<NotiModel> dataNotification;

  factory ListNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$ListNotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$ListNotificationModelToJson(this);
}
