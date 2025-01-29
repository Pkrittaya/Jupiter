import 'package:json_annotation/json_annotation.dart';

import 'username_and_orgcode_form.dart';

part 'favorite_route_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class FavoriteRouteForm extends UsernameAndOrgCodeForm {
  FavoriteRouteForm({
    required super.username,
    required this.latitude,
    required this.longitude,
    required super.orgCode,
  });
  @JsonKey(name: 'latitude')
  final double latitude;
  @JsonKey(name: 'longitude')
  final double longitude;

  factory FavoriteRouteForm.fromJson(Map<String, dynamic> json) =>
      _$FavoriteRouteFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$FavoriteRouteFormToJson(this);
}
