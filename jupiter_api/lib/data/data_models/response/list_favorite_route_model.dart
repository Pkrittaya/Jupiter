import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/data/data_models/response/favorite_route_item_model.dart';
import 'package:jupiter_api/domain/entities/list_favorite_route_entity.dart';

part 'list_favorite_route_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ListFavoriteRouteModel extends ListFavoriteRouteEntity {
  ListFavoriteRouteModel({
    required this.data,
  }) : super(data: data);

  @override
  @JsonKey(name: 'data')
  final List<FavoriteRouteItemModel> data;

  factory ListFavoriteRouteModel.fromJson(Map<String, dynamic> json) =>
      _$ListFavoriteRouteModelFromJson(json);
  Map<String, dynamic> toJson() => _$ListFavoriteRouteModelToJson(this);
}
