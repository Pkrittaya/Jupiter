import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/charger_entity.dart';
import 'connector_model.dart';

part 'charger_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ChargerModel extends ChargerEntity {
  ChargerModel(
      {required super.chargerId,
      required super.chargerName,
      required super.chargerBrand,
      // required super.chargerType,
      // required super.chargerStatus,
      // required super.maximumCharger,
      // required super.price,
      required super.totalConnector,
      required this.connector})
      : super(connector: connector);

  @override
  @JsonKey(name: 'connector')
  final List<ConnectorModel> connector;

  factory ChargerModel.fromJson(Map<String, dynamic> json) =>
      _$ChargerModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChargerModelToJson(this);
}
