part of 'favorite_cubit.dart';

abstract class FavoriteStationState extends Equatable {
  const FavoriteStationState({
    this.favoriteStationEntity,
    this.listFavoriteRouteEntity,
    this.message,
  });

  final FavoriteStationEntity? favoriteStationEntity;
  final List<FavoriteRouteItemEntity>? listFavoriteRouteEntity;
  final String? message;

  @override
  List<Object> get props => [];
}

class FavoriteStationInitial extends FavoriteStationState {}

class FavoriteStationLoading extends FavoriteStationState {}

class FavoriteStationSuccess extends FavoriteStationState {
  FavoriteStationSuccess(FavoriteStationEntity? favoriteStationEntity)
      : super(favoriteStationEntity: favoriteStationEntity);
}

class FavoriteStationFailure extends FavoriteStationState {}

class FavoriteRouteSuccess extends FavoriteStationState {
  FavoriteRouteSuccess(List<FavoriteRouteItemEntity>? listFavoriteRouteEntity)
      : super(listFavoriteRouteEntity: listFavoriteRouteEntity);
}

class FavoriteRouteFailure extends FavoriteStationState {}

class DeleteFavoriteRouteSuccess extends FavoriteStationState {}

class DeleteFavoriteRouteFailure extends FavoriteStationState {
  const DeleteFavoriteRouteFailure(String message) : super(message: message);
}

class DeleteFavoriteStationSuccess extends FavoriteStationState {}

class DeleteFavoriteStationFailure extends FavoriteStationState {
  const DeleteFavoriteStationFailure(String message) : super(message: message);
}
