import 'package:json_annotation/json_annotation.dart';

import 'history_data_entity.dart';

class HistoryEntity {
  HistoryEntity({
    required this.totalCharging,
    required this.insteadOfTrees,
    required this.data,
  });
  @JsonKey(name: 'total_charging')
  final String totalCharging;
  @JsonKey(name: 'instead_of_trees')
  final String insteadOfTrees;
  @JsonKey(name: 'data')
  final List<HistoryDataEntity> data;
}
