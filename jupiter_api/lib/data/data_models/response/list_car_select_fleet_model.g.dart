// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_car_select_fleet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListCarSelectFleetModel _$ListCarSelectFleetModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ListCarSelectFleetModel',
      json,
      ($checkedConvert) {
        final val = ListCarSelectFleetModel(
          carSelect: $checkedConvert(
              'car_select',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      CarSelectFleetModel.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'carSelect': 'car_select'},
    );

Map<String, dynamic> _$ListCarSelectFleetModelToJson(
        ListCarSelectFleetModel instance) =>
    <String, dynamic>{
      'car_select': instance.carSelect.map((e) => e.toJson()).toList(),
    };
