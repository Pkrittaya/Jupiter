// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_favorite_route_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListFavoriteRouteModel _$ListFavoriteRouteModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ListFavoriteRouteModel',
      json,
      ($checkedConvert) {
        final val = ListFavoriteRouteModel(
          data: $checkedConvert(
              'data',
              (v) => (v as List<dynamic>)
                  .map((e) => FavoriteRouteItemModel.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$ListFavoriteRouteModelToJson(
        ListFavoriteRouteModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };
