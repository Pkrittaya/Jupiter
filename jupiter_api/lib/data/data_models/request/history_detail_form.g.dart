// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_detail_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryDetailForm _$HistoryDetailFormFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'HistoryDetailForm',
      json,
      ($checkedConvert) {
        final val = HistoryDetailForm(
          username: $checkedConvert('username', (v) => v as String),
          orgCode: $checkedConvert('org_code', (v) => v as String),
          transaction: $checkedConvert('transaction', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'orgCode': 'org_code'},
    );

Map<String, dynamic> _$HistoryDetailFormToJson(HistoryDetailForm instance) =>
    <String, dynamic>{
      'org_code': instance.orgCode,
      'username': instance.username,
      'transaction': instance.transaction,
    };
