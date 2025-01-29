import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/data/data_models/response/fleet_card_charger_item_model.dart';
import 'package:jupiter_api/domain/entities/llst_charger_fleet_card_entity.dart';

part 'list_charger_fleet_card_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ListChargerFleetCardModel extends ListChargerFleetCardEntity {
  ListChargerFleetCardModel({
    required this.charger,
  }) : super(charger: charger);

  @override
  @JsonKey(name: 'charger')
  final List<FleetCardChargerItemModel> charger;

  factory ListChargerFleetCardModel.fromJson(Map<String, dynamic> json) =>
      _$ListChargerFleetCardModelFromJson(json);
  Map<String, dynamic> toJson() => _$ListChargerFleetCardModelToJson(this);
}
