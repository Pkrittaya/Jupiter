part of 'select_vehicle_cubit.dart';

abstract class SelectVehicleState extends Equatable {
  const SelectVehicleState({this.message, this.carList});

  final String? message;
  final ListCarSelectFleetEntity? carList;

  @override
  List<Object> get props => [];
}

class SelectVehicleInitial extends SelectVehicleState {}

class SelectVehicleLoading extends SelectVehicleState {}

class SaveVehicleFailure extends SelectVehicleState {
  const SaveVehicleFailure(String message) : super(message: message);
}

class SaveVehicleSuccess extends SelectVehicleState {}

class LoadVehicleFailure extends SelectVehicleState {
  const LoadVehicleFailure(String message) : super(message: message);
}

class LoadVehicleSuccess extends SelectVehicleState {
  const LoadVehicleSuccess(ListCarSelectFleetEntity carList)
      : super(carList: carList);
}
