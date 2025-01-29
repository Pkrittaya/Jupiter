import 'package:json_annotation/json_annotation.dart';

part 'route_planning_modifiers_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class RoutePlanningModifiersForm {
  RoutePlanningModifiersForm({
    required this.avoidHighways,
    required this.avoidTolls,
    required this.avoidFerries,
  });
  @JsonKey(name: 'avoidHighways')
  final bool avoidHighways;
  @JsonKey(name: 'avoidTolls')
  final bool avoidTolls;
  @JsonKey(name: 'avoidFerries')
  final bool avoidFerries;

  factory RoutePlanningModifiersForm.fromJson(Map<String, dynamic> json) =>
      _$RoutePlanningModifiersFormFromJson(json);
  Map<String, dynamic> toJson() => _$RoutePlanningModifiersFormToJson(this);
}
