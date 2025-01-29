import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/domain/entities/favorite_route_point_entity.dart';

class FavoriteRouteItemEntity {
  FavoriteRouteItemEntity({
    required this.routeName,
    required this.routeDistance,
    required this.routeDuration,
    required this.routePoint,
  });

  @JsonKey(name: 'route_name')
  final String routeName;
  @JsonKey(name: 'route_distance')
  final int routeDistance;
  @JsonKey(name: 'route_duration')
  final int routeDuration;
  @JsonKey(name: 'route_point')
  final List<FavoriteRoutePointEntity> routePoint;
}
