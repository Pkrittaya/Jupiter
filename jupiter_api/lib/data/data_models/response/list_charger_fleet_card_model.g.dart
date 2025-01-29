// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_charger_fleet_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListChargerFleetCardModel _$ListChargerFleetCardModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ListChargerFleetCardModel',
      json,
      ($checkedConvert) {
        final val = ListChargerFleetCardModel(
          charger: $checkedConvert(
              'charger',
              (v) => (v as List<dynamic>)
                  .map((e) => FleetCardChargerItemModel.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$ListChargerFleetCardModelToJson(
        ListChargerFleetCardModel instance) =>
    <String, dynamic>{
      'charger': instance.charger.map((e) => e.toJson()).toList(),
    };
