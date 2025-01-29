// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charger_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargerModel _$ChargerModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ChargerModel',
      json,
      ($checkedConvert) {
        final val = ChargerModel(
          chargerId: $checkedConvert('charger_id', (v) => v as String),
          chargerName: $checkedConvert('charger_name', (v) => v as String),
          chargerBrand: $checkedConvert('charger_brand', (v) => v as String),
          totalConnector: $checkedConvert('total_connector', (v) => v as int),
          connector: $checkedConvert(
              'connector',
              (v) => (v as List<dynamic>)
                  .map(
                      (e) => ConnectorModel.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'chargerId': 'charger_id',
        'chargerName': 'charger_name',
        'chargerBrand': 'charger_brand',
        'totalConnector': 'total_connector'
      },
    );

Map<String, dynamic> _$ChargerModelToJson(ChargerModel instance) =>
    <String, dynamic>{
      'charger_id': instance.chargerId,
      'charger_name': instance.chargerName,
      'charger_brand': instance.chargerBrand,
      'total_connector': instance.totalConnector,
      'connector': instance.connector.map((e) => e.toJson()).toList(),
    };
