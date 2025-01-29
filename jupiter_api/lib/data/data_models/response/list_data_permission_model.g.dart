// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_data_permission_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListDataPermissionModel _$ListDataPermissionModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ListDataPermissionModel',
      json,
      ($checkedConvert) {
        final val = ListDataPermissionModel(
          permission: $checkedConvert('permission',
              (v) => PermissionModel.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$ListDataPermissionModelToJson(
        ListDataPermissionModel instance) =>
    <String, dynamic>{
      'permission': instance.permission.toJson(),
    };
