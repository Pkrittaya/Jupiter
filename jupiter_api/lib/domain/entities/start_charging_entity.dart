import 'package:json_annotation/json_annotation.dart';

import '../../data/data_models/response/car_select_model.dart';

class StartChargingEntity {
  StartChargingEntity({
    required this.optionalType,
    required this.optionalValue,
    required this.carSelect,
  });
  @JsonKey(name: 'optional_type')
  final String optionalType;
  @JsonKey(name: 'optional_value')
  final double optionalValue;
  @JsonKey(name: 'car_select')
  final List<CarSelectModel> carSelect;
}
