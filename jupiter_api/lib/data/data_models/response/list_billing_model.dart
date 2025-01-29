import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/list_billing_entity.dart';
import 'billing_model.dart';

part 'list_billing_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ListBillingModel extends ListBillingEntity {
  ListBillingModel({
    required super.username,
    required this.billing,
  }) : super(billing: billing);

  @override
  @JsonKey(name: 'billing')
  final List<BillingModel> billing;

  factory ListBillingModel.fromJson(Map<String, dynamic> json) =>
      _$ListBillingModelFromJson(json);
  Map<String, dynamic> toJson() => _$ListBillingModelToJson(this);
}
