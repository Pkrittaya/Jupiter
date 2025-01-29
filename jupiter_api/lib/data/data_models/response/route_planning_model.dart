import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/data/data_models/response/route_planning_data_model.dart';
import 'package:jupiter_api/domain/entities/route_planning_entity.dart';

part 'route_planning_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class RoutePlanningModel extends RoutePlanningEntity {
  RoutePlanningModel({
    required this.routes,
  }) : super(routes: routes);

  @override
  @JsonKey(name: 'routes')
  final List<RoutePlanningDataModel> routes;

  factory RoutePlanningModel.fromJson(Map<String, dynamic> json) =>
      _$RoutePlanningModelFromJson(json);
  Map<String, dynamic> toJson() => _$RoutePlanningModelToJson(this);
}
