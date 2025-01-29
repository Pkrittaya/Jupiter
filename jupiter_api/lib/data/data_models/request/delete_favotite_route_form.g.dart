// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_favotite_route_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteFavoriteRouteForm _$DeleteFavoriteRouteFormFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'DeleteFavoriteRouteForm',
      json,
      ($checkedConvert) {
        final val = DeleteFavoriteRouteForm(
          routeName: $checkedConvert('route_name', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'routeName': 'route_name'},
    );

Map<String, dynamic> _$DeleteFavoriteRouteFormToJson(
        DeleteFavoriteRouteForm instance) =>
    <String, dynamic>{
      'route_name': instance.routeName,
    };
