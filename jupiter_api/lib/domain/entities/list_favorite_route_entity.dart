import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/domain/entities/favorite_route_item_entity.dart';

class ListFavoriteRouteEntity {
  ListFavoriteRouteEntity({
    required this.data,
  });

  @JsonKey(name: 'data')
  final List<FavoriteRouteItemEntity> data;
}
