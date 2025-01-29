import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/permission_entity.dart';

part 'permission_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class PermissionModel extends PermissionEntity {
  PermissionModel({
    required super.fleetOperationPermission,
    required super.fleetCardPermission,
  });

  factory PermissionModel.fromJson(Map<String, dynamic> json) =>
      _$PermissionModelFromJson(json);
  Map<String, dynamic> toJson() => _$PermissionModelToJson(this);
}
