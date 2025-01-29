import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/connector_type_entity.dart';
part 'connector_type_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ConnectorTypeModel extends ConnectorTypeEntity {
  ConnectorTypeModel({required super.connectorType, required super.total});

  factory ConnectorTypeModel.fromJson(Map<String, dynamic> json) =>
      _$ConnectorTypeModelFromJson(json);
  Map<String, dynamic> toJson() => _$ConnectorTypeModelToJson(this);
}
