part of 'route_planner_cubit.dart';

abstract class RoutePlannerState extends Equatable {
  const RoutePlannerState({
    this.message,
  });
  final String? message;

  @override
  List<Object> get props => [];
}

class RoutePlannerInitial extends RoutePlannerState {}

class RoutePlannerLoading extends RoutePlannerState {}

class AddFavoriteRouteSuccess extends RoutePlannerState {}

class AddFavoriteRouteFailure extends RoutePlannerState {
  const AddFavoriteRouteFailure(String message) : super(message: message);
}

class DeleteFavoriteRouteSuccess extends RoutePlannerState {}

class DeleteFavoriteRouteFailure extends RoutePlannerState {
  const DeleteFavoriteRouteFailure(String message) : super(message: message);
}

class UpdateFavoriteRouteSuccess extends RoutePlannerState {}

class UpdateFavoriteRouteFailure extends RoutePlannerState {
  const UpdateFavoriteRouteFailure(String message) : super(message: message);
}
