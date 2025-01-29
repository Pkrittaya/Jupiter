import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/profile_entity.dart';

part 'profile_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ProfileModel extends ProfileEntity {
  ProfileModel(
      {required super.username,
      required super.name,
      required super.lastname,
      required super.gender,
      required super.dateofbirth,
      required super.telphonenumber,
      required super.images});

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
