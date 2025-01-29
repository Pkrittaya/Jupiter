import 'package:json_annotation/json_annotation.dart';

import 'news_entity.dart';

class AdvertisementEntity {
  AdvertisementEntity({
    required this.name,
    required this.lastname,
    required this.announcement,
    required this.news,
  });
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'lastname')
  final String lastname;
  @JsonKey(name: 'Announcement')
  final List<String> announcement;
  @JsonKey(name: 'news')
  final List<NewsEntity> news;
}
