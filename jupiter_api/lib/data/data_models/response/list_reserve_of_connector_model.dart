import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/list_reserve_of_connector_entity.dart';

part 'list_reserve_of_connector_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ListReserveOfConnectorModel extends ListReserveOfConnectorEntity {
  ListReserveOfConnectorModel({
    required super.startTimeReserve,
    required super.endTimeReserve,
  });

  factory ListReserveOfConnectorModel.fromJson(Map<String, dynamic> json) =>
      _$ListReserveOfConnectorModelFromJson(json);
  Map<String, dynamic> toJson() => _$ListReserveOfConnectorModelToJson(this);
}
