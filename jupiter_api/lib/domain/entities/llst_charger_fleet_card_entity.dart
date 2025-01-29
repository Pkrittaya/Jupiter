import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/domain/entities/fleet_card_charger_item_entity.dart';

class ListChargerFleetCardEntity {
  ListChargerFleetCardEntity({
    required this.charger,
  });

  @JsonKey(name: 'charger')
  final List<FleetCardChargerItemEntity> charger;
}
