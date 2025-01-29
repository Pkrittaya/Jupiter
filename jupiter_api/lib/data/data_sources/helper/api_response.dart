import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
  fieldRename: FieldRename.snake,
)
class ApiResponse<T> {
  const ApiResponse(this.data, this.message, this.success);

  @JsonKey(name: "data")
  final T data;

  @JsonKey(name: "message")
  final String message;

  @JsonKey(name: "success")
  final bool success;

  factory ApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);
}
