import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/data/data_models/response/car_select_fleet_model.dart';
import 'package:jupiter_api/domain/entities/list_car_select_fleet_entity.dart';

part 'list_car_select_fleet_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ListCarSelectFleetModel extends ListCarSelectFleetEntity {
  ListCarSelectFleetModel({
    required this.carSelect,
  }) : super(carSelect: carSelect);

  @override
  @JsonKey(name: 'car_select')
  final List<CarSelectFleetModel> carSelect;

  factory ListCarSelectFleetModel.fromJson(Map<String, dynamic> json) =>
      _$ListCarSelectFleetModelFromJson(json);
  Map<String, dynamic> toJson() => _$ListCarSelectFleetModelToJson(this);
}
