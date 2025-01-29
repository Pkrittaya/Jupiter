import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/station_details_entity.dart';
import 'charger_model.dart';
import 'connector_type_power_model.dart';
import 'duration_model.dart';
import 'facility_model.dart';

part 'station_details_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class StationDetailModel extends StationDetailEntity {
  StationDetailModel({
    required super.stationId,
    required super.stationName,
    required this.facility,
    required super.position,
    required super.address,
    required super.eta,
    required super.distance,
    required this.openingHours,
    required super.images,
    required super.statusOpening,
    required super.totalConnector,
    required super.connectorAvailable,
    required this.connectorType,
    required super.statusMarker,
    required this.charger,
    required super.favorite,
    required super.lowPriorityTariff,
  }) : super(
            charger: charger,
            facility: facility,
            connectorType: connectorType,
            openingHours: openingHours);
  @override
  @JsonKey(name: 'charger')
  final List<ChargerModel> charger;
  @override
  @JsonKey(name: 'facility')
  final List<FacilityModel>? facility;
  @override
  @JsonKey(name: 'connector_type')
  final List<ConnectorTypeAndPowerModel> connectorType;
  @override
  @JsonKey(name: 'opening_hours')
  final List<DurationModel> openingHours;

  factory StationDetailModel.fromJson(Map<String, dynamic> json) =>
      _$StationDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$StationDetailModelToJson(this);
}
