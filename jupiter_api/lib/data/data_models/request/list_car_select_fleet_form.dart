import 'package:json_annotation/json_annotation.dart';

part 'list_car_select_fleet_form.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ListCarSelectFleetForm {
  ListCarSelectFleetForm({
    required this.fleetNo,
  });
  @JsonKey(name: 'fleet_no')
  final int fleetNo;

  factory ListCarSelectFleetForm.fromJson(Map<String, dynamic> json) =>
      _$ListCarSelectFleetFormFromJson(json);
  Map<String, dynamic> toJson() => _$ListCarSelectFleetFormToJson(this);
}
