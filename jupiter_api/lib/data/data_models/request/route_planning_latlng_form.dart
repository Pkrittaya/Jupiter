import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/data/data_models/request/route_planning_latlng_data_form.dart';

part 'route_planning_latlng_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class RoutePlanningLatLngForm {
  RoutePlanningLatLngForm({required this.latLng});
  @JsonKey(name: 'latLng')
  final RoutePlanningLatLngDataForm latLng;

  factory RoutePlanningLatLngForm.fromJson(Map<String, dynamic> json) =>
      _$RoutePlanningLatLngFormFromJson(json);
  Map<String, dynamic> toJson() => _$RoutePlanningLatLngFormToJson(this);
}
