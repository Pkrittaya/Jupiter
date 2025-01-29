import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entities/history_entity.dart';
import 'history_list_data_model.dart';

part 'history_list_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class HistoryListModel extends HistoryEntity {
  HistoryListModel({
    required super.totalCharging,
    required super.insteadOfTrees,
    required this.data,
  }) : super(data: data);
  @override
  @JsonKey(name: 'data')
  final List<HistoryListDataModel> data;

  factory HistoryListModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryListModelFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryListModelToJson(this);
}
