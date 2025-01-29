// ignore_for_file: must_be_immutable

part of 'status_charging_cubit.dart';

abstract class StatusChargingState extends Equatable {
  StatusChargingState({
    this.checkStatusEntity,
  });
  CheckStatusEntity? checkStatusEntity;

  @override
  List<Object> get props => [];
}

class StatusChargingInitial extends StatusChargingState {}

class StatusChargingLoading extends StatusChargingState {}

class StatusCharging extends StatusChargingState {
  StatusCharging(CheckStatusEntity? checkStatusEntity)
      : super(checkStatusEntity: checkStatusEntity);
}
