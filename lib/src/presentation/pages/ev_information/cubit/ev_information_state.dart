part of 'ev_information_cubit.dart';

abstract class EvInformationState extends Equatable {
  const EvInformationState({
    this.carList,
    this.message,
  });
  final List<CarEntity>? carList;
  final String? message;
  @override
  List<Object> get props => [];
}

class EvInformationInitial extends EvInformationState {}

class EvInformationCarLoading extends EvInformationState {}

class EvInformationCarLoadingFailure extends EvInformationState {}

class EvInformationCarLoadingSuccess extends EvInformationState {
  EvInformationCarLoadingSuccess(List<CarEntity>? carList)
      : super(carList: carList);
}

class EvInformationCarDeleteStart extends EvInformationState {}

class EvInformationCarDeleteFailure extends EvInformationState {
  EvInformationCarDeleteFailure(String? message) : super(message: message);
}

class EvInformationCarDeleteSuccess extends EvInformationState {}
