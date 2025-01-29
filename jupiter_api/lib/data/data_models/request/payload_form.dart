import 'package:json_annotation/json_annotation.dart';

part 'payload_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class PayloadForm {
  PayloadForm({
    required this.payload,
  });
  @JsonKey(name: 'payload')
  final String payload;

  factory PayloadForm.fromJson(Map<String, dynamic> json) =>
      _$PayloadFormFromJson(json);
  Map<String, dynamic> toJson() => _$PayloadFormToJson(this);
}
