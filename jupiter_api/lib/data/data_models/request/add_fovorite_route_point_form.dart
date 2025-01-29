import 'package:json_annotation/json_annotation.dart';

part 'add_fovorite_route_point_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class AddFavoriteRoutePointForm {
  AddFavoriteRoutePointForm({
    required this.name,
    required this.pointNo,
    required this.latitude,
    required this.longitude,
    required this.stationId,
  });
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'point_no')
  final int pointNo;
  @JsonKey(name: 'latitude')
  final double latitude;
  @JsonKey(name: 'longitude')
  final double longitude;
  @JsonKey(name: 'station_id')
  final String stationId;

  factory AddFavoriteRoutePointForm.fromJson(Map<String, dynamic> json) =>
      _$AddFavoriteRoutePointFormFromJson(json);

  Map<String, dynamic> toJson() => _$AddFavoriteRoutePointFormToJson(this);
}
