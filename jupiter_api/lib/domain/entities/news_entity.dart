import 'package:json_annotation/json_annotation.dart';

class NewsEntity {
  NewsEntity({
    required this.header,
    required this.body,
    required this.linkInformation,
    required this.adCreate,
    required this.imageUrl,
  });
  @JsonKey(name: 'header')
  final String header;
  @JsonKey(name: 'body')
  final String body;
  @JsonKey(name: 'link_information')
  final String linkInformation;
  @JsonKey(name: 'ad_create')
  final String adCreate;
  @JsonKey(name: 'images_url')
  final String imageUrl;
}
