import 'package:json_annotation/json_annotation.dart';

import 'permission_entity.dart';

class ListDataPermissionEntity {
  ListDataPermissionEntity({
    required this.permission,
  });

  @JsonKey(name: 'permission')
  final PermissionEntity? permission;
}
