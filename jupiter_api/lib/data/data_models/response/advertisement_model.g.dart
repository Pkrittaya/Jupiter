// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advertisement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvertisementModel _$AdvertisementModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'AdvertisementModel',
      json,
      ($checkedConvert) {
        final val = AdvertisementModel(
          name: $checkedConvert('name', (v) => v as String),
          lastname: $checkedConvert('lastname', (v) => v as String),
          announcement: $checkedConvert('Announcement',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          news: $checkedConvert(
              'news',
              (v) => (v as List<dynamic>)
                  .map((e) => NewsModel.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'announcement': 'Announcement'},
    );

Map<String, dynamic> _$AdvertisementModelToJson(AdvertisementModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'lastname': instance.lastname,
      'Announcement': instance.announcement,
      'news': instance.news.map((e) => e.toJson()).toList(),
    };
