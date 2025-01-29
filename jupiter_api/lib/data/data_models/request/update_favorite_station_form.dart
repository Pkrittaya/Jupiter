import 'package:json_annotation/json_annotation.dart';

import 'username_and_orgcode_form.dart';

part 'update_favorite_station_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class UpdateFavoriteStationForm extends UsernameAndOrgCodeForm {
  UpdateFavoriteStationForm({
    required super.username,
    required super.orgCode,
    required this.stationId,
    required this.stationName,
  });
  @JsonKey(name: 'station_id')
  final String stationId;
  @JsonKey(name: 'station_name')
  final String stationName;

  factory UpdateFavoriteStationForm.fromJson(Map<String, dynamic> json) =>
      _$UpdateFavoriteStationFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$UpdateFavoriteStationFormToJson(this);
}
