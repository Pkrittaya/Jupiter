// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_charger_fleet_operation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListChargerFleetOperationModel _$ListChargerFleetOperationModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ListChargerFleetOperationModel',
      json,
      ($checkedConvert) {
        final val = ListChargerFleetOperationModel(
          charger: $checkedConvert(
              'charger',
              (v) => (v as List<dynamic>)
                  .map((e) => FleetOperationChargerItemModel.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$ListChargerFleetOperationModelToJson(
        ListChargerFleetOperationModel instance) =>
    <String, dynamic>{
      'charger': instance.charger.map((e) => e.toJson()).toList(),
    };
