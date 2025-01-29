// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connector_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectorTypeModel _$ConnectorTypeModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ConnectorTypeModel',
      json,
      ($checkedConvert) {
        final val = ConnectorTypeModel(
          connectorType: $checkedConvert('connector_type', (v) => v as String),
          total: $checkedConvert('total', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {'connectorType': 'connector_type'},
    );

Map<String, dynamic> _$ConnectorTypeModelToJson(ConnectorTypeModel instance) =>
    <String, dynamic>{
      'connector_type': instance.connectorType,
      'total': instance.total,
    };
