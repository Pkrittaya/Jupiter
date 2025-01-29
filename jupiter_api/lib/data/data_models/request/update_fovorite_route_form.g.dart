// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_fovorite_route_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateFavoriteRouteForm _$UpdateFavoriteRouteFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'UpdateFavoriteRouteForm',
      json,
      ($checkedConvert) {
        final val = UpdateFavoriteRouteForm(
          routeName: $checkedConvert('route_name', (v) => v as String),
          routeNameNew: $checkedConvert('route_name_new', (v) => v as String),
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
        'routeNameNew': 'route_name_new',
        'routeDistance': 'route_distance',
        'routeDuration': 'route_duration',
        'routePoint': 'route_point'
      },
    );

Map<String, dynamic> _$UpdateFavoriteRouteFormToJson(
        UpdateFavoriteRouteForm instance) =>
    <String, dynamic>{
      'route_name': instance.routeName,
      'route_name_new': instance.routeNameNew,
      'route_distance': instance.routeDistance,
      'route_duration': instance.routeDuration,
      'route_point': instance.routePoint.map((e) => e.toJson()).toList(),
    };
