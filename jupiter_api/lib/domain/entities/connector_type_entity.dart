import 'package:json_annotation/json_annotation.dart';

class ConnectorTypeEntity {
  ConnectorTypeEntity({
    required this.connectorType,
    required this.total,
  });
  @JsonKey(name: 'connector_type')
  final String connectorType;
  @JsonKey(name: 'total')
  final int total;
}
