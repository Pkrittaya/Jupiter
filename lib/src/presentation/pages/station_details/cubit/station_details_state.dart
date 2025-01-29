part of 'station_details_cubit.dart';

abstract class StationDetailsState extends Equatable {
  StationDetailsState({this.stationDetailEntity, this.favoriteStationEntity});
  final StationDetailEntity? stationDetailEntity;
  final FavoriteStationEntity? favoriteStationEntity;
  @override
  List<Object> get props => [];
}

class StationDetailsInitial extends StationDetailsState {}

class StationDetailsLoading extends StationDetailsState {}

class StationDetailsSuccess extends StationDetailsState {
  StationDetailsSuccess(StationDetailEntity? stationDetailEntity)
      : super(stationDetailEntity: stationDetailEntity);
}

class StationDetailsFailure extends StationDetailsState {}

class FavoriteStationAddLoading extends StationDetailsState {}

class FavoriteStationAddSuccess extends StationDetailsState {}

class FavoriteStationAddFailure extends StationDetailsState {}
