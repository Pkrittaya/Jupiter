// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryListModel _$HistoryListModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'HistoryListModel',
      json,
      ($checkedConvert) {
        final val = HistoryListModel(
          totalCharging: $checkedConvert('total_charging', (v) => v as String),
          insteadOfTrees:
              $checkedConvert('instead_of_trees', (v) => v as String),
          data: $checkedConvert(
              'data',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      HistoryListDataModel.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'totalCharging': 'total_charging',
        'insteadOfTrees': 'instead_of_trees'
      },
    );

Map<String, dynamic> _$HistoryListModelToJson(HistoryListModel instance) =>
    <String, dynamic>{
      'total_charging': instance.totalCharging,
      'instead_of_trees': instance.insteadOfTrees,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };
