import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/domain/entities/fleet_operation_charger_item_entity.dart';

class ListChargerFleetOperationEntity {
  ListChargerFleetOperationEntity({
    required this.charger,
  });

  @JsonKey(name: 'charger')
  final List<FleetOperationChargerItemEntity> charger;
}
