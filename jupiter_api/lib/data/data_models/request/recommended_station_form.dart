import 'package:json_annotation/json_annotation.dart';

import 'only_org_form.dart';

part 'recommended_station_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class RecommendedStationForm extends OnlyOrgForm {
  RecommendedStationForm({
    required this.filterOpenService,
    required this.filterDistance,
    required this.filterConnectorDC,
    required this.latitude,
    required this.longitude,
    required super.orgCode,
  });
  @JsonKey(name: 'filter_openService')
  final bool filterOpenService;
  @JsonKey(name: 'filter_distance')
  final bool filterDistance;
  @JsonKey(name: 'filter_connector_dc')
  final List<String?> filterConnectorDC;
  @JsonKey(name: 'latitude')
  final double latitude;
  @JsonKey(name: 'longitude')
  final double longitude;

  factory RecommendedStationForm.fromJson(Map<String, dynamic> json) =>
      _$RecommendedStationFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RecommendedStationFormToJson(this);
}
