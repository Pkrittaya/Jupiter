import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/data/data_models/request/route_planning_data_form.dart';

part 'route_planning_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class RoutePlanningForm {
  RoutePlanningForm({
    required this.data,
  });

  @JsonKey(name: 'data')
  final RoutePlanningDataForm data;

  factory RoutePlanningForm.fromJson(Map<String, dynamic> json) =>
      _$RoutePlanningFormFromJson(json);
  Map<String, dynamic> toJson() => _$RoutePlanningFormToJson(this);
}
