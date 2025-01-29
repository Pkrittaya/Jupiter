import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/domain/entities/car_select_fleet_entity.dart';

class ListCarSelectFleetEntity {
  ListCarSelectFleetEntity({
    required this.carSelect,
  });

  @JsonKey(name: 'car_select')
  final List<CarSelectFleetEntity> carSelect;
}
