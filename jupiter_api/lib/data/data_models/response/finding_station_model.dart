import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/finding_station_entity.dart';
import 'search_station_model.dart';

part 'finding_station_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class FindingStationModel extends FindingStationEntity {
  FindingStationModel({required super.totalStation, required this.stationList})
      : super(stationList: stationList);

  @override
  @JsonKey(name: 'station_list')
  final List<SearchStationModel> stationList;

  factory FindingStationModel.fromJson(Map<String, dynamic> json) =>
      _$FindingStationModelFromJson(json);
  Map<String, dynamic> toJson() => _$FindingStationModelToJson(this);
}
