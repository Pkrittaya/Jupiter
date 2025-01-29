import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/data/data_models/request/add_fovorite_route_point_form.dart';

part 'add_favorite_route_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class AddFavoriteRouteForm {
  AddFavoriteRouteForm({
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
  final List<AddFavoriteRoutePointForm> routePoint;

  factory AddFavoriteRouteForm.fromJson(Map<String, dynamic> json) =>
      _$AddFavoriteRouteFormFromJson(json);

  Map<String, dynamic> toJson() => _$AddFavoriteRouteFormToJson(this);
}
