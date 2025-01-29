import 'package:json_annotation/json_annotation.dart';

import 'only_org_form.dart';

part 'station_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class StationForm extends OnlyOrgForm {
  StationForm({
    required this.filterOpenService,
    required this.filterChargerAvailble,
    required this.filterDistance,
    required this.filterConnectorAC,
    required this.filterConnectorDC,
    required this.latitude,
    required this.longitude,
    required super.orgCode,
  });
  @JsonKey(name: 'filter_openService')
  final bool filterOpenService;
  @JsonKey(name: 'filter_charger_availble')
  final bool filterChargerAvailble;
  @JsonKey(name: 'filter_distance')
  final bool filterDistance;
  @JsonKey(name: 'filter_connector_ac')
  final List<String?> filterConnectorAC;
  @JsonKey(name: 'filter_connector_dc')
  final List<String?> filterConnectorDC;
  @JsonKey(name: 'latitude')
  final double latitude;
  @JsonKey(name: 'longitude')
  final double longitude;

  factory StationForm.fromJson(Map<String, dynamic> json) =>
      _$StationFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$StationFormToJson(this);
}
