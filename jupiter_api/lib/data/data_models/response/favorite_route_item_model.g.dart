// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_route_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteRouteItemModel _$FavoriteRouteItemModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'FavoriteRouteItemModel',
      json,
      ($checkedConvert) {
        final val = FavoriteRouteItemModel(
          routeName: $checkedConvert('route_name', (v) => v as String),
          routeDistance: $checkedConvert('route_distance', (v) => v as int),
          routeDuration: $checkedConvert('route_duration', (v) => v as int),
          routePoint: $checkedConvert(
              'route_point',
              (v) => (v as List<dynamic>)
                  .map((e) => FavoriteRoutePointModel.fromJson(
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

Map<String, dynamic> _$FavoriteRouteItemModelToJson(
        FavoriteRouteItemModel instance) =>
    <String, dynamic>{
      'route_name': instance.routeName,
      'route_distance': instance.routeDistance,
      'route_duration': instance.routeDuration,
      'route_point': instance.routePoint.map((e) => e.toJson()).toList(),
    };
