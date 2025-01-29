// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet_operation_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FleetOperationInfoModel _$FleetOperationInfoModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'FleetOperationInfoModel',
      json,
      ($checkedConvert) {
        final val = FleetOperationInfoModel(
          fleetName: $checkedConvert('fleet_name', (v) => v as String),
          fleetOperationNo:
              $checkedConvert('fleet_operation_no', (v) => v as int),
          creditMax:
              $checkedConvert('credit_max', (v) => (v as num).toDouble()),
          creditUsage:
              $checkedConvert('credit_usage', (v) => (v as num).toDouble()),
          totalEnergyCharging: $checkedConvert(
              'total_energy_charging', (v) => (v as num).toDouble()),
          billDate: $checkedConvert('bill_date', (v) => v as String),
          totalCarOperation:
              $checkedConvert('total_car_operation', (v) => v as int),
          image: $checkedConvert('image', (v) => v as String),
          fleetCar: $checkedConvert(
              'fleet_car',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      CarFleetInfoModel.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'fleetName': 'fleet_name',
        'fleetOperationNo': 'fleet_operation_no',
        'creditMax': 'credit_max',
        'creditUsage': 'credit_usage',
        'totalEnergyCharging': 'total_energy_charging',
        'billDate': 'bill_date',
        'totalCarOperation': 'total_car_operation',
        'fleetCar': 'fleet_car'
      },
    );

Map<String, dynamic> _$FleetOperationInfoModelToJson(
        FleetOperationInfoModel instance) =>
    <String, dynamic>{
      'fleet_name': instance.fleetName,
      'fleet_operation_no': instance.fleetOperationNo,
      'credit_max': instance.creditMax,
      'credit_usage': instance.creditUsage,
      'total_energy_charging': instance.totalEnergyCharging,
      'bill_date': instance.billDate,
      'total_car_operation': instance.totalCarOperation,
      'image': instance.image,
      'fleet_car': instance.fleetCar.map((e) => e.toJson()).toList(),
    };
