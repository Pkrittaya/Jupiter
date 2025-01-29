import 'package:json_annotation/json_annotation.dart';

part 'validated_pin_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ValidatedPinModel {
  ValidatedPinModel({required this.validated, required this.destination});
  // @JsonKey(name: 'brand')
  // final String brand;
  // @JsonKey(name: 'model')
  // final String model;
  @JsonKey(name: 'validated')
  final bool validated;
  @JsonKey(name: 'destination')
  final String destination;

  factory ValidatedPinModel.fromJson(Map<String, dynamic> json) =>
      _$ValidatedPinModelFromJson(json);
  Map<String, dynamic> toJson() => _$ValidatedPinModelToJson(this);
}
