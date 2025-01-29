// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_status_checkin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealtimeStatusCheckinModel _$RealtimeStatusCheckinModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'RealtimeStatusCheckinModel',
      json,
      ($checkedConvert) {
        final val = RealtimeStatusCheckinModel(
          chargerName: $checkedConvert('charger_name', (v) => v as String?),
          connectorStatus:
              $checkedConvert('connector_status', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'chargerName': 'charger_name',
        'connectorStatus': 'connector_status'
      },
    );

Map<String, dynamic> _$RealtimeStatusCheckinModelToJson(
        RealtimeStatusCheckinModel instance) =>
    <String, dynamic>{
      'charger_name': instance.chargerName,
      'connector_status': instance.connectorStatus,
    };
