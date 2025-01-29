import 'package:json_annotation/json_annotation.dart';

import 'only_org_form.dart';

part 'finding_station_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class FindingStationForm extends OnlyOrgForm {
  FindingStationForm({
    required this.latitude,
    required this.longitude,
    required super.orgCode,
  });
  @JsonKey(name: 'latitude')
  final double latitude;
  @JsonKey(name: 'longitude')
  final double longitude;

  factory FindingStationForm.fromJson(Map<String, dynamic> json) =>
      _$FindingStationFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$FindingStationFormToJson(this);
}
