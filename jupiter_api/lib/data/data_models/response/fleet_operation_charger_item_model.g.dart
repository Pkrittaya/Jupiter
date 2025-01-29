// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet_operation_charger_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FleetOperationChargerItemModel _$FleetOperationChargerItemModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'FleetOperationChargerItemModel',
      json,
      ($checkedConvert) {
        final val = FleetOperationChargerItemModel(
          chargerId: $checkedConvert('charger_id', (v) => v as String),
          chargerName: $checkedConvert('charger_name', (v) => v as String),
          connectorAvailable:
              $checkedConvert('connector_available', (v) => v as int),
          connectorTotal: $checkedConvert('connector_total', (v) => v as int),
          connector: $checkedConvert(
              'connector',
              (v) => (v as List<dynamic>)
                  .map((e) => FleetOperationConnectorItemModel.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'chargerId': 'charger_id',
        'chargerName': 'charger_name',
        'connectorAvailable': 'connector_available',
        'connectorTotal': 'connector_total'
      },
    );

Map<String, dynamic> _$FleetOperationChargerItemModelToJson(
        FleetOperationChargerItemModel instance) =>
    <String, dynamic>{
      'charger_id': instance.chargerId,
      'charger_name': instance.chargerName,
      'connector_available': instance.connectorAvailable,
      'connector_total': instance.connectorTotal,
      'connector': instance.connector.map((e) => e.toJson()).toList(),
    };
