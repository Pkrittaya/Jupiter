import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/advertisement_entity.dart';
import 'news_model.dart';

part 'advertisement_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class AdvertisementModel extends AdvertisementEntity {
  AdvertisementModel(
      {required super.name,
      required super.lastname,
      required super.announcement,
      required this.news})
      : super(news: news);

  @override
  @JsonKey(name: 'news')
  final List<NewsModel> news;

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) =>
      _$AdvertisementModelFromJson(json);
  Map<String, dynamic> toJson() => _$AdvertisementModelToJson(this);
}
