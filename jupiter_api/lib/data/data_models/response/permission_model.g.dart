// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PermissionModel _$PermissionModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PermissionModel',
      json,
      ($checkedConvert) {
        final val = PermissionModel(
          fleetOperationPermission:
              $checkedConvert('fleet_operation_permission', (v) => v as bool),
          fleetCardPermission:
              $checkedConvert('fleet_card_permission', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {
        'fleetOperationPermission': 'fleet_operation_permission',
        'fleetCardPermission': 'fleet_card_permission'
      },
    );

Map<String, dynamic> _$PermissionModelToJson(PermissionModel instance) =>
    <String, dynamic>{
      'fleet_operation_permission': instance.fleetOperationPermission,
      'fleet_card_permission': instance.fleetCardPermission,
    };
