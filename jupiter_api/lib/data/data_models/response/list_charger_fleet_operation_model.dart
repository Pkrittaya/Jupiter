import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/data/data_models/response/fleet_operation_charger_item_model.dart';
import 'package:jupiter_api/domain/entities/llst_charger_fleet_operation_entity.dart';

part 'list_charger_fleet_operation_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ListChargerFleetOperationModel extends ListChargerFleetOperationEntity {
  ListChargerFleetOperationModel({
    required this.charger,
  }) : super(charger: charger);

  @override
  @JsonKey(name: 'charger')
  final List<FleetOperationChargerItemModel> charger;

  factory ListChargerFleetOperationModel.fromJson(Map<String, dynamic> json) =>
      _$ListChargerFleetOperationModelFromJson(json);
  Map<String, dynamic> toJson() => _$ListChargerFleetOperationModelToJson(this);
}
