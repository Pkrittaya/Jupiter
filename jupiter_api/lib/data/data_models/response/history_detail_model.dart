import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/data/data_models/response/car_select_model.dart';

import '../../../domain/entities/history_detail_entity.dart';

part 'history_detail_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class HistoryDetailModel extends HistoryDetailEntity {
  HistoryDetailModel({
    required super.stationName,
    required super.chargerId,
    required super.chargerName,
    // required super.chargerType,
    required super.connectorId,
    required super.connectorType,
    required super.connectorPosition,
    required super.connectorStatusActive,
    required super.totalConnector,
    required super.startTime,
    required super.endTime,
    required super.energy,
    required super.distance,
    required super.pricePerUnit,
    required super.charingFee,
    required super.reserveStatus,
    required super.reserveDiscount,
    required super.statusAddCoupon,
    required super.statusUseCoupon,
    required super.couponDiscount,
    required super.tax,
    required super.grandTotal,
    required super.paymentMethod,
    required super.priceBeforeTax,
    required this.carSelect,
  }) : super(carSelect: carSelect);

  @override
  @JsonKey(name: 'car_select')
  final CarSelectModel? carSelect;

  factory HistoryDetailModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryDetailModelToJson(this);
}
