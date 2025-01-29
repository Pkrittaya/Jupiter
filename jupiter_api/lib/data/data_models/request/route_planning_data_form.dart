import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/data/data_models/request/route_planning_location_form.dart';
import 'package:jupiter_api/data/data_models/request/route_planning_modifiers_form.dart';

part 'route_planning_data_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class RoutePlanningDataForm {
  RoutePlanningDataForm({
    required this.origin,
    required this.destination,
    required this.intermediates,
    required this.travelMode,
    required this.routingPreference,
    required this.computeAlternativeRoutes,
    required this.routeModifiers,
    required this.languageCode,
  });

  @JsonKey(name: 'origin')
  final RoutePlanningLocationForm origin;
  @JsonKey(name: 'destination')
  final RoutePlanningLocationForm destination;
  @JsonKey(name: 'intermediates')
  final List<RoutePlanningLocationForm> intermediates;
  @JsonKey(name: 'travelMode')
  final String travelMode;
  @JsonKey(name: 'routingPreference')
  final String routingPreference;
  @JsonKey(name: 'computeAlternativeRoutes')
  final bool computeAlternativeRoutes;
  @JsonKey(name: 'routeModifiers')
  final RoutePlanningModifiersForm routeModifiers;
  @JsonKey(name: 'languageCode')
  final String languageCode;

  factory RoutePlanningDataForm.fromJson(Map<String, dynamic> json) =>
      _$RoutePlanningDataFormFromJson(json);
  Map<String, dynamic> toJson() => _$RoutePlanningDataFormToJson(this);
}
