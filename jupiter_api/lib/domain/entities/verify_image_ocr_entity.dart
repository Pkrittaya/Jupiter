import 'package:json_annotation/json_annotation.dart';

class VerifyImageOcrEntity {
  VerifyImageOcrEntity({
    required this.status,
    required this.licensePlate,
    required this.refId,
  });

  @JsonKey(name: 'status')
  final bool status;
  @JsonKey(name: 'license_plate')
  final String licensePlate;
  @JsonKey(name: 'ref_id')
  final String refId;
}
