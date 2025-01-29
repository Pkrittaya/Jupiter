import 'package:json_annotation/json_annotation.dart';
import 'package:jupiter_api/domain/entities/verify_image_ocr_entity.dart';

part 'verify_image_ocr_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class VerifyImageOcrModel extends VerifyImageOcrEntity {
  VerifyImageOcrModel({
    required super.status,
    required super.licensePlate,
    required super.refId,
  });

  factory VerifyImageOcrModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyImageOcrModelFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyImageOcrModelToJson(this);
}
