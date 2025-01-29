import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/sign_in_entity.dart';
import 'token_model.dart';

part 'sign_in_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class SignInModel extends SignInEntity {
  SignInModel(this.token, {required String message})
      : super(token, message: message);
  @override
  @JsonKey(name: 'token')
  final TokenModel token;
  factory SignInModel.fromJson(Map<String, dynamic> json) =>
      _$SignInModelFromJson(json);
  Map<String, dynamic> toJson() => _$SignInModelToJson(this);
}
