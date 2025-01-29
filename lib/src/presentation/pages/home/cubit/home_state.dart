part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState({
    this.permissionEntity,
    this.message,
    this.hasChargingFleetEntity,
  });

  final ListDataPermissionEntity? permissionEntity;
  final String? message;
  final HasChargingFleetEntity? hasChargingFleetEntity;

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeGetPermissionFleetSuccess extends HomeState {
  HomeGetPermissionFleetSuccess(ListDataPermissionEntity permissionEntity)
      : super(permissionEntity: permissionEntity);
}

class HomeGetPermissionFleetFailure extends HomeState {
  HomeGetPermissionFleetFailure(String message) : super(message: message);
}

class HomeHasChargingFleetCardSuccess extends HomeState {
  HomeHasChargingFleetCardSuccess(HasChargingFleetEntity hasChargingFleetEntity)
      : super(hasChargingFleetEntity: hasChargingFleetEntity);
}

class HomeHasChargingFleetCardFailure extends HomeState {
  HomeHasChargingFleetCardFailure(String message) : super(message: message);
}

class HomeHasChargingFleetOperationSuccess extends HomeState {
  HomeHasChargingFleetOperationSuccess(
      HasChargingFleetEntity hasChargingFleetEntity)
      : super(hasChargingFleetEntity: hasChargingFleetEntity);
}

class HomeHasChargingFleetOperationFailure extends HomeState {
  HomeHasChargingFleetOperationFailure(String message)
      : super(message: message);
}
