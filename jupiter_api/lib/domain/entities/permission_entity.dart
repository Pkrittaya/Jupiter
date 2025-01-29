import 'package:json_annotation/json_annotation.dart';

class PermissionEntity {
  PermissionEntity({
    required this.fleetOperationPermission,
    required this.fleetCardPermission,
  
  });
  @JsonKey(name: 'fleet_operation_permission')
  final bool fleetOperationPermission;
  @JsonKey(name: 'fleet_card_permission')
  final bool fleetCardPermission;
}
