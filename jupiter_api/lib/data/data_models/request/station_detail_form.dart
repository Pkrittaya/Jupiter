import 'package:json_annotation/json_annotation.dart';

import 'only_org_form.dart';

part 'station_detail_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class StationDetailForm extends OnlyOrgForm {
  StationDetailForm({
    required this.stationId,
    required this.latitude,
    required this.longitude,
    required this.username,
    required super.orgCode,
  });
  @JsonKey(name: 'station_id')
  final String stationId;
  @JsonKey(name: 'latitude')
  final double latitude;
  @JsonKey(name: 'longitude')
  final double longitude;
  @JsonKey(name: 'username')
  final String username;

  factory StationDetailForm.fromJson(Map<String, dynamic> json) =>
      _$StationDetailFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$StationDetailFormToJson(this);
}
