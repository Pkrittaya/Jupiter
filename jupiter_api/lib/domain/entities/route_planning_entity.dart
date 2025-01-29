import 'package:json_annotation/json_annotation.dart';

class RoutePlanningEntity {
  RoutePlanningEntity({
    required this.routes,
  });

  @JsonKey(name: 'routes')
  final List<RoutePlanningDataModelEntity> routes;
}

class RoutePlanningDataModelEntity {
  RoutePlanningDataModelEntity({
    required this.legs,
    required this.polyline,
    required this.distanceMeters,
    required this.duration,
    required this.staticDuration,
  });

  @JsonKey(name: 'legs')
  final List<RoutesLegsItemEntity> legs;
  @JsonKey(name: 'polyline')
  final RoutesLegsPointsEntity polyline;
  @JsonKey(name: 'distanceMeters')
  final int distanceMeters;
  @JsonKey(name: 'duration')
  final String duration;
  @JsonKey(name: 'staticDuration')
  final String staticDuration;
}

class RoutesLegsItemEntity {
  RoutesLegsItemEntity(
      {required this.distanceMeters,
      required this.duration,
      required this.staticDuration,
      required this.polyline,
      required this.startLocation,
      required this.endLocation});

  @JsonKey(name: 'distanceMeters')
  final int distanceMeters;
  @JsonKey(name: 'duration')
  final String duration;
  @JsonKey(name: 'staticDuration')
  final String staticDuration;
  @JsonKey(name: 'polyline')
  final RoutesLegsPointsEntity polyline;
  @JsonKey(name: 'startLocation')
  final RoutesLegsLatLngEntity startLocation;
  @JsonKey(name: 'endLocation')
  final RoutesLegsLatLngEntity endLocation;
}

class RoutesLegsLocationEntity {
  RoutesLegsLocationEntity({
    required this.lat,
    required this.lng,
  });
  @JsonKey(name: 'latitude')
  final double lat;
  @JsonKey(name: 'longitude')
  final double lng;
}

class RoutesLegsPointsEntity {
  RoutesLegsPointsEntity({
    required this.encodedPolyline,
  });

  @JsonKey(name: 'encodedPolyline')
  final String encodedPolyline;
}

class RoutesLegsLatLngEntity {
  RoutesLegsLatLngEntity({
    required this.latLng,
  });
  @JsonKey(name: 'latLng')
  final RoutesLegsLocationEntity latLng;
}
