// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_billing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListBillingModel _$ListBillingModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ListBillingModel',
      json,
      ($checkedConvert) {
        final val = ListBillingModel(
          username: $checkedConvert('username', (v) => v as String),
          billing: $checkedConvert(
              'billing',
              (v) => (v as List<dynamic>)
                  .map((e) => BillingModel.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$ListBillingModelToJson(ListBillingModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'billing': instance.billing.map((e) => e.toJson()).toList(),
    };
