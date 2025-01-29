import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/llst_station_fleet_card_entity.dart';
import 'fleet_card_station_item_model.dart';

part 'list_station_fleet_card_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ListStationFleetCardModel extends ListStationFleetCardEntity {
  ListStationFleetCardModel({
    required this.station,
  }) : super(station: station);

  @override
  @JsonKey(name: 'station')
  final List<FleetCardStationItemModel> station;

  factory ListStationFleetCardModel.fromJson(Map<String, dynamic> json) =>
      _$ListStationFleetCardModelFromJson(json);
  Map<String, dynamic> toJson() => _$ListStationFleetCardModelToJson(this);
}
