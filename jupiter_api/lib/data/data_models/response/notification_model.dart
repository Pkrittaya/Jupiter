import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/notification_entity.dart';
import 'notification_data_model.dart';

part 'notification_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class NotiModel extends NotiEntity {
  NotiModel({
    required super.notificationIndex,
    required this.notification,
  }) : super(notification: notification);

  @override
  @JsonKey(name: 'notification')
  final NotiDataModel notification;

  factory NotiModel.fromJson(Map<String, dynamic> json) =>
      _$NotiModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotiModelToJson(this);
}
