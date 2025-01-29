// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckStatusModel _$CheckStatusModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CheckStatusModel',
      json,
      ($checkedConvert) {
        final val = CheckStatusModel(
          chargingStatus: $checkedConvert('charging_status', (v) => v as bool?),
          data: $checkedConvert(
              'data',
              (v) => v == null
                  ? null
                  : ChargingInfoModel.fromJson(v as Map<String, dynamic>)),
          informationCharger: $checkedConvert(
              'information_charger',
              (v) => v == null
                  ? null
                  : ChargerRealtimeModel.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'chargingStatus': 'charging_status',
        'informationCharger': 'information_charger'
      },
    );

Map<String, dynamic> _$CheckStatusModelToJson(CheckStatusModel instance) =>
    <String, dynamic>{
      'charging_status': instance.chargingStatus,
      'data': instance.data?.toJson(),
      'information_charger': instance.informationCharger?.toJson(),
    };
