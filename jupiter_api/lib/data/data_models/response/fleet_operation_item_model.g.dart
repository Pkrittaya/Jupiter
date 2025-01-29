// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet_operation_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FleetOperationItemModel _$FleetOperationItemModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'FleetOperationItemModel',
      json,
      ($checkedConvert) {
        final val = FleetOperationItemModel(
          fleetNo: $checkedConvert('fleet_no', (v) => v as int),
          fleetName: $checkedConvert('fleet_name', (v) => v as String),
          images: $checkedConvert('images', (v) => v as String),
          statusCharging:
              $checkedConvert('status_charging', (v) => v as String),
          connectorTotal: $checkedConvert('connector_total', (v) => v as int),
          connectorAvailable:
              $checkedConvert('connector_available', (v) => v as int),
          fleetVehicle: $checkedConvert('fleet_vehicle', (v) => v as int),
          status: $checkedConvert('status', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'fleetNo': 'fleet_no',
        'fleetName': 'fleet_name',
        'statusCharging': 'status_charging',
        'connectorTotal': 'connector_total',
        'connectorAvailable': 'connector_available',
        'fleetVehicle': 'fleet_vehicle'
      },
    );

Map<String, dynamic> _$FleetOperationItemModelToJson(
        FleetOperationItemModel instance) =>
    <String, dynamic>{
      'fleet_no': instance.fleetNo,
      'fleet_name': instance.fleetName,
      'images': instance.images,
      'status_charging': instance.statusCharging,
      'connector_total': instance.connectorTotal,
      'connector_available': instance.connectorAvailable,
      'fleet_vehicle': instance.fleetVehicle,
      'status': instance.status,
    };
