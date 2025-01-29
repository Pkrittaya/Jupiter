// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) => $checkedCreate(
      'NewsModel',
      json,
      ($checkedConvert) {
        final val = NewsModel(
          header: $checkedConvert('header', (v) => v as String),
          body: $checkedConvert('body', (v) => v as String),
          linkInformation:
              $checkedConvert('link_information', (v) => v as String),
          adCreate: $checkedConvert('ad_create', (v) => v as String),
          imageUrl: $checkedConvert('images_url', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'linkInformation': 'link_information',
        'adCreate': 'ad_create',
        'imageUrl': 'images_url'
      },
    );

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) => <String, dynamic>{
      'header': instance.header,
      'body': instance.body,
      'link_information': instance.linkInformation,
      'ad_create': instance.adCreate,
      'images_url': instance.imageUrl,
    };
