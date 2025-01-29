import 'package:json_annotation/json_annotation.dart';

class FleetCardItemEntity {
  FleetCardItemEntity({
    required this.fleetNo,
    required this.fleetCardNo,
    required this.statusCharging,
    required this.credit,
    required this.available,
    required this.expired,
    required this.image,
    required this.status,
    required this.fleetCardType,
  });
  @JsonKey(name: 'fleet_no')
  final int fleetNo;
  @JsonKey(name: 'fleet_card_no')
  final String fleetCardNo;
  @JsonKey(name: 'status_charging')
  final bool statusCharging;
  @JsonKey(name: 'credit')
  final double credit;
  @JsonKey(name: 'available')
  final double available;
  @JsonKey(name: 'expired')
  final String expired;
  @JsonKey(name: 'image')
  final String image;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'fleet_card_type')
  final String fleetCardType;
}
