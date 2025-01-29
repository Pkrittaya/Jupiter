import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/data/data_models/request/route_planning_latlng_form.dart';

part 'route_planning_location_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class RoutePlanningLocationForm {
  RoutePlanningLocationForm({required this.location});
  @JsonKey(name: 'location')
  final RoutePlanningLatLngForm location;

  factory RoutePlanningLocationForm.fromJson(Map<String, dynamic> json) =>
      _$RoutePlanningLocationFormFromJson(json);
  Map<String, dynamic> toJson() => _$RoutePlanningLocationFormToJson(this);
}
