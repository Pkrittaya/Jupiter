import 'package:json_annotation/json_annotation.dart';

class FacilityEntity {
  FacilityEntity({
    required this.facilityName,
    required this.image,
  });
  @JsonKey(name: 'facility_name')
  final String facilityName;
  @JsonKey(name: 'image')
  final String image;
}
