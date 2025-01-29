import 'package:json_annotation/json_annotation.dart';

part 'route_planning_latlng_data_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class RoutePlanningLatLngDataForm {
  RoutePlanningLatLngDataForm(
      {required this.latitude, required this.longitude});
  @JsonKey(name: 'latitude')
  final double latitude;
  @JsonKey(name: 'longitude')
  final double longitude;

  factory RoutePlanningLatLngDataForm.fromJson(Map<String, dynamic> json) =>
      _$RoutePlanningLatLngDataFormFromJson(json);
  Map<String, dynamic> toJson() => _$RoutePlanningLatLngDataFormToJson(this);
}
