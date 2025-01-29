import 'package:json_annotation/json_annotation.dart';

import 'username_and_orgcode_form.dart';

part 'favorite_station_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class FavoriteStationForm extends UsernameAndOrgCodeForm {
  FavoriteStationForm({
    required super.username,
    required this.latitude,
    required this.longitude,
    required super.orgCode,
  });
  @JsonKey(name: 'latitude')
  final double latitude;
  @JsonKey(name: 'longitude')
  final double longitude;

  factory FavoriteStationForm.fromJson(Map<String, dynamic> json) =>
      _$FavoriteStationFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$FavoriteStationFormToJson(this);
}
