// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet_card_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FleetCardInfoModel _$FleetCardInfoModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'FleetCardInfoModel',
      json,
      ($checkedConvert) {
        final val = FleetCardInfoModel(
          fleetCardNo: $checkedConvert('fleet_card_no', (v) => v as String),
          creditMax:
              $checkedConvert('credit_max', (v) => (v as num).toDouble()),
          creditUsage:
              $checkedConvert('credit_usage', (v) => (v as num).toDouble()),
          totalEnergyCharging: $checkedConvert(
              'total_energy_charging', (v) => (v as num).toDouble()),
          billDate: $checkedConvert('bill_date', (v) => v as String),
          image: $checkedConvert('image', (v) => v as String),
          fleetCar: $checkedConvert('fleet_car',
              (v) => CarFleetInfoModel.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'fleetCardNo': 'fleet_card_no',
        'creditMax': 'credit_max',
        'creditUsage': 'credit_usage',
        'totalEnergyCharging': 'total_energy_charging',
        'billDate': 'bill_date',
        'fleetCar': 'fleet_car'
      },
    );

Map<String, dynamic> _$FleetCardInfoModelToJson(FleetCardInfoModel instance) =>
    <String, dynamic>{
      'fleet_card_no': instance.fleetCardNo,
      'credit_max': instance.creditMax,
      'credit_usage': instance.creditUsage,
      'total_energy_charging': instance.totalEnergyCharging,
      'bill_date': instance.billDate,
      'image': instance.image,
      'fleet_car': instance.fleetCar.toJson(),
    };
