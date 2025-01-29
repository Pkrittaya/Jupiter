import 'package:json_annotation/json_annotation.dart';

import 'only_org_form.dart';

part 'get_list_reserve_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class GetListReserveForm extends OnlyOrgForm {
  GetListReserveForm({
    required super.orgCode,
    required this.stationId,
    required this.chargerId,
    required this.connectorId,
    required this.qrCodeConnector,
    required this.date,
  });
  @JsonKey(name: 'station_id')
  final String stationId;
  @JsonKey(name: 'charger_id')
  final String chargerId;
  @JsonKey(name: 'connector_id')
  final String connectorId;
  @JsonKey(name: 'qr_code_connector')
  final String qrCodeConnector;
  @JsonKey(name: 'date')
  final String date;

  factory GetListReserveForm.fromJson(Map<String, dynamic> json) =>
      _$GetListReserveFormFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GetListReserveFormToJson(this);
}
