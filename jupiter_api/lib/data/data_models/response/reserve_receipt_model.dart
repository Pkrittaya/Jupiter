import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/reserve_receipt_entity.dart';

part 'reserve_receipt_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ReserveReceiptModel extends ReserveReceiptEntity {
  ReserveReceiptModel({
    required super.stationName,
    required super.chargeName,
    required super.connectorName,
    required super.startTimeReserve,
    required super.endTimeReserve,
    required super.reserveTimeCreate,
    required super.reserveTimeExpired,
    required super.reserveTimeMinute,
    required super.reserveRate,
    required super.reserveTax,
    required super.reserveBeforeTax,
    required super.reservePrice,
    required super.paymentMethod,
  });

  factory ReserveReceiptModel.fromJson(Map<String, dynamic> json) =>
      _$ReserveReceiptModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReserveReceiptModelToJson(this);
}
