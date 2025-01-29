import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/favorite_station_entity.dart';
import 'favorite_station_list_model.dart';

part 'favorite_station_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class FavoriteStationModel extends FavoriteStationEntity {
  FavoriteStationModel({required super.totalStation, required this.stationList})
      : super(stationList: stationList);

  @override
  @JsonKey(name: 'station_list')
  final List<FavoriteStationListModel> stationList;

  factory FavoriteStationModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteStationModelFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteStationModelToJson(this);
}
