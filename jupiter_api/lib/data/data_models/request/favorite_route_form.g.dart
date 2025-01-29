// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_route_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteRouteForm _$FavoriteRouteFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'FavoriteRouteForm',
      json,
      ($checkedConvert) {
        final val = FavoriteRouteForm(
          username: $checkedConvert('username', (v) => v as String),
          latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
          longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
          orgCode: $checkedConvert('org_code', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'orgCode': 'org_code'},
    );

Map<String, dynamic> _$FavoriteRouteFormToJson(FavoriteRouteForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
