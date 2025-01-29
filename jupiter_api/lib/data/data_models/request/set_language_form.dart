import 'package:json_annotation/json_annotation.dart';

part 'set_language_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class SetLanguageForm {
  SetLanguageForm({
    required this.deviceCode,
    required this.language,
  });
  @JsonKey(name: 'device_code')
  final String deviceCode;
  @JsonKey(name: 'language')
  final String language;

  factory SetLanguageForm.fromJson(Map<String, dynamic> json) =>
      _$SetLanguageFormFromJson(json);
  Map<String, dynamic> toJson() => _$SetLanguageFormToJson(this);
}
