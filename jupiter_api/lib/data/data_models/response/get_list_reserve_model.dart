import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/get_list_reserve_entity.dart';
import 'list_reserve_of_connector_model.dart';

part 'get_list_reserve_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class GetListReserveModel extends GetListReserveEntity {
  GetListReserveModel({
    required super.stationId,
    required super.chargerId,
    required super.connectorId,
    required super.connectorQrCode,
    required super.slotDate,
    required this.slot,
  }) : super(slot: slot);

  @override
  @JsonKey(name: 'slot')
  final List<ListReserveOfConnectorModel> slot;

  factory GetListReserveModel.fromJson(Map<String, dynamic> json) =>
      _$GetListReserveModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetListReserveModelToJson(this);
}
