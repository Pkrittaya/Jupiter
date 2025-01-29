part of 'map_cubit.dart';

abstract class MapState extends Equatable {
  MapState({
    this.markerData,
    this.stationDetail,
    this.filterMapType,
    this.favoriteStationEntity,
    this.data,
    this.message,
  });
  final List<StationEntity>? markerData;
  final StationDetailEntity? stationDetail;
  final List<ConnectorTypeEntity>? filterMapType;
  final FavoriteStationEntity? favoriteStationEntity;
  final RoutePlanningEntity? data;
  final String? message;
  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoadMarkerSuccess extends MapState {
  MapLoadMarkerSuccess(List<StationEntity> markerData)
      : super(markerData: markerData);
}

class MapLoadMarkerFailure extends MapState {}

class MapLoadStationDetailFailure extends MapState {}

class MapLoadStationDetailSuccess extends MapState {
  MapLoadStationDetailSuccess(StationDetailEntity stationDetail)
      : super(stationDetail: stationDetail);
}

class FilterLoading extends MapState {}

class FilterLoadSuccess extends MapState {
  FilterLoadSuccess(List<ConnectorTypeEntity> filterMapType)
      : super(filterMapType: filterMapType);
}

class FilterLoadFailure extends MapState {}

class FavoriteStationAddLoading extends MapState {}

class FavoriteStationAddSuccess extends MapState {}

class FavoriteStationAddFailure extends MapState {}

class RoutePlannerLoading extends MapState {}

class RoutePlannerSuccess extends MapState {
  RoutePlannerSuccess(RoutePlanningEntity data) : super(data: data);
}

class RoutePlannerFailure extends MapState {
  RoutePlannerFailure(String message) : super(message: message);
}
