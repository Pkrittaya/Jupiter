import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/news_entity.dart';
part 'news_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class NewsModel extends NewsEntity {
  NewsModel(
      {required super.header,
      required super.body,
      required super.linkInformation,
      required super.adCreate,
      required super.imageUrl});

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);
  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}
