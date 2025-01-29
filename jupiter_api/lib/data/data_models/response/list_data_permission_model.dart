import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/list_data_permission_entity.dart';
import 'permission_model.dart';

part 'list_data_permission_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ListDataPermissionModel extends ListDataPermissionEntity {
  ListDataPermissionModel({
    required this.permission,
  }) : super(permission: permission);

  @override
  @JsonKey(name: 'permission')
  final PermissionModel permission;

  factory ListDataPermissionModel.fromJson(Map<String, dynamic> json) =>
      _$ListDataPermissionModelFromJson(json);
  Map<String, dynamic> toJson() => _$ListDataPermissionModelToJson(this);
}
