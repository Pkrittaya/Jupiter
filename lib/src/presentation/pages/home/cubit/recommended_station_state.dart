part of 'recommended_station_cubit.dart';

sealed class RecommendedStationState extends Equatable {
  const RecommendedStationState({
    this.recommendedStation,
    this.message,
  });

  final String? message;
  final List<RecommendedStationEntity>? recommendedStation;

  @override
  List<Object> get props => [];
}

class RecommendedStationInitial extends RecommendedStationState {}

class RecommendedStationLoading extends RecommendedStationState {}

class RecommendedStationSuccess extends RecommendedStationState {
  RecommendedStationSuccess(List<RecommendedStationEntity> recommendedStation)
      : super(recommendedStation: recommendedStation);
}

class RecommendedStationFailure extends RecommendedStationState {}
