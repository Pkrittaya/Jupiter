part of 'ev_information_add_cubit.dart';

abstract class EvInformationAddState extends Equatable {
  const EvInformationAddState({
    this.carMaster,
    this.message,
  });

  final List<CarMasterEntity>? carMaster;
  final String? message;

  @override
  List<Object> get props => [];
}

class EvInformationAddInitial extends EvInformationAddState {}

class EvInformationAddLoading extends EvInformationAddState {}

class EvInformationAddSuccess extends EvInformationAddState {}

class EvInformationAddFailure extends EvInformationAddState {
  const EvInformationAddFailure(String message) : super(message: message);
}

class EvLoadCarMasterLoading extends EvInformationAddState {}

class EvLoadCarMasterSuccess extends EvInformationAddState {
  EvLoadCarMasterSuccess(List<CarMasterEntity> carMaster)
      : super(carMaster: carMaster);
}

class EvLoadCarMasterFailure extends EvInformationAddState {}

class EvInformationEditLoading extends EvInformationAddState {}

class EvInformationEditFailure extends EvInformationAddState {
  const EvInformationEditFailure(String message) : super(message: message);
}

class EvInformationEditSuccess extends EvInformationAddState {}
