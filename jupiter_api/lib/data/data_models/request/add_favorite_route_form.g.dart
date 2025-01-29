// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_favorite_route_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddFavoriteRouteForm _$AddFavoriteRouteFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'AddFavoriteRouteForm',
      json,
      ($checkedConvert) {
        final val = AddFavoriteRouteForm(
          routeName: $checkedConvert('route_name', (v) => v as String),
          routeDistance: $checkedConvert('route_distance', (v) => v as int),
          routeDuration: $checkedConvert('route_duration', (v) => v as int),
          routePoint: $checkedConvert(
              'route_point',
              (v) => (v as List<dynamic>)
                  .map((e) => AddFavoriteRoutePointForm.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'routeName': 'route_name',
        'routeDistance': 'route_distance',
        'routeDuration': 'route_duration',
        'routePoint': 'route_point'
      },
    );

Map<String, dynamic> _$AddFavoriteRouteFormToJson(
        AddFavoriteRouteForm instance) =>
    <String, dynamic>{
      'route_name': instance.routeName,
      'route_distance': instance.routeDistance,
      'route_duration': instance.routeDuration,
      'route_point': instance.routePoint.map((e) => e.toJson()).toList(),
    };
