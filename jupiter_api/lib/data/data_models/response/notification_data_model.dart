import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/notification_data_entity.dart';

part 'notification_data_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class NotiDataModel extends NotiDataEntity {
  NotiDataModel({
    required super.title,
    required super.body,
    required super.readStatus,
    required super.messageCreate,
  });

  factory NotiDataModel.fromJson(Map<String, dynamic> json) =>
      _$NotiDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotiDataModelToJson(this);
}
