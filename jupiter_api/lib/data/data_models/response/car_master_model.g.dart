// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_master_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarMasterModel _$CarMasterModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CarMasterModel',
      json,
      ($checkedConvert) {
        final val = CarMasterModel(
          brand: $checkedConvert('brand', (v) => v as String),
          model: $checkedConvert(
              'model',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      CarModelMasterModel.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$CarMasterModelToJson(CarMasterModel instance) =>
    <String, dynamic>{
      'brand': instance.brand,
      'model': instance.model.map((e) => e.toJson()).toList(),
    };
