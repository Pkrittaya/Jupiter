import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/start_charging_entity.dart';
import 'car_select_model.dart';
import 'connector_information_model.dart';
import 'payment_type_model.dart';

part 'start_charging_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class StartChargingModel extends StartChargingEntity {
  StartChargingModel(
      {required this.connector,
      required this.payment_type,
      required super.optionalType,
      required super.optionalValue,
      required super.carSelect});
  final ConnectorInformationModel? connector;
  final List<PaymentTypeModel>? payment_type;

  factory StartChargingModel.fromJson(Map<String, dynamic> json) =>
      _$StartChargingModelFromJson(json);
  Map<String, dynamic> toJson() => _$StartChargingModelToJson(this);
}
