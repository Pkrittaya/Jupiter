import 'package:json_annotation/json_annotation.dart';

import 'billing_entity.dart';

class ListBillingEntity {
  ListBillingEntity({
    required this.username,
    required this.billing,
  });
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'billing')
  final List<BillingEntity> billing;
}
