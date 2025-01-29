import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/llst_station_fleet_operation_entity.dart';
import 'fleet_operation_station_item_model.dart';

part 'list_station_fleet_operation_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ListStationFleetOperationModel extends ListStationFleetOperationEntity {
  ListStationFleetOperationModel({
    required this.station,
  }) : super(station: station);

  @override
  @JsonKey(name: 'station')
  final List<FleetOperationStationItemModel> station;

  factory ListStationFleetOperationModel.fromJson(Map<String, dynamic> json) =>
      _$ListStationFleetOperationModelFromJson(json);
  Map<String, dynamic> toJson() => _$ListStationFleetOperationModelToJson(this);
}
