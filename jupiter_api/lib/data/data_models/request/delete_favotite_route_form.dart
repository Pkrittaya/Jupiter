import 'package:json_annotation/json_annotation.dart';

part 'delete_favotite_route_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class DeleteFavoriteRouteForm {
  DeleteFavoriteRouteForm({
    required this.routeName,
  });
  @JsonKey(name: 'route_name')
  final String routeName;

  factory DeleteFavoriteRouteForm.fromJson(Map<String, dynamic> json) =>
      _$DeleteFavoriteRouteFormFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteFavoriteRouteFormToJson(this);
}
