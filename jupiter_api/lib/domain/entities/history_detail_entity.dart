import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/domain/entities/car_select_entity.dart';

class HistoryDetailEntity {
  HistoryDetailEntity(
      {required this.stationName,
      required this.chargerId,
      required this.chargerName,
      // required this.chargerType,
      required this.connectorId,
      required this.connectorType,
      required this.connectorPosition,
      required this.connectorStatusActive,
      required this.totalConnector,
      required this.startTime,
      required this.endTime,
      required this.energy,
      required this.distance,
      required this.carSelect,
      required this.pricePerUnit,
      required this.charingFee,
      required this.reserveStatus,
      required this.reserveDiscount,
      required this.statusAddCoupon,
      required this.statusUseCoupon,
      required this.couponDiscount,
      required this.tax,
      required this.grandTotal,
      required this.paymentMethod,
      required this.priceBeforeTax});
  @JsonKey(name: 'station_name')
  final String stationName;
  @JsonKey(name: 'charger_id')
  final String chargerId;
  @JsonKey(name: 'charger_name')
  final String chargerName;
  // @JsonKey(name: 'charger_type')
  // final String chargerType;
  @JsonKey(name: 'connector_id')
  final String connectorId;
  @JsonKey(name: 'connector_type')
  final String connectorType;
  @JsonKey(name: 'connector_position')
  final String connectorPosition;
  @JsonKey(name: 'connector_status_active')
  final String connectorStatusActive;
  @JsonKey(name: 'total_connector')
  final int totalConnector;
  @JsonKey(name: 'start_time')
  final DateTime startTime;
  @JsonKey(name: 'end_time')
  final DateTime endTime;
  @JsonKey(name: 'energy')
  final double energy;
  @JsonKey(name: 'distance')
  final String distance;
  @JsonKey(name: 'car_select')
  final CarSelectEntity? carSelect;
  @JsonKey(name: 'price_per_unit')
  final double pricePerUnit;
  @JsonKey(name: 'charing_fee')
  final double charingFee;
  @JsonKey(name: 'reserve_status')
  final bool reserveStatus;
  @JsonKey(name: 'reserve_discount')
  final double reserveDiscount;
  @JsonKey(name: 'status_add_coupon')
  final bool statusAddCoupon;
  @JsonKey(name: 'status_use_coupon')
  final bool statusUseCoupon;
  @JsonKey(name: 'coupon_discount')
  final double couponDiscount;
  @JsonKey(name: 'tax')
  final double tax;
  @JsonKey(name: 'grand_total')
  final double grandTotal;
  @JsonKey(name: 'payment_method')
  final String paymentMethod;
  @JsonKey(name: 'price_before_tax')
  final double priceBeforeTax;
}
