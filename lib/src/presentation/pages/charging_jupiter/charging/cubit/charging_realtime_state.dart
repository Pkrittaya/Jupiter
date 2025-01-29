part of 'charging_realtime_cubit.dart';

abstract class ChargingRealtimeState extends Equatable {
  const ChargingRealtimeState(
      {this.checkStatusEntity, this.listPayment, this.message});

  final List<dynamic>? listPayment;
  final CheckStatusEntity? checkStatusEntity;
  final String? message;

  @override
  List<Object> get props => [];
}

class ChargingRealtimeInitial extends ChargingRealtimeState {}

class ChargingGetPaymentLoading extends ChargingRealtimeState {}

class ChargingGetPaymentFailure extends ChargingRealtimeState {}

class ChargingGetPaymentSuccess extends ChargingRealtimeState {
  const ChargingGetPaymentSuccess(
    List<dynamic>? listPayment,
  ) : super(listPayment: listPayment);
}

class ChargingUpdatePaymentLoading extends ChargingRealtimeState {}

class ChargingUpdatePaymentFailure extends ChargingRealtimeState {
  const ChargingUpdatePaymentFailure(String message) : super(message: message);
}

class ChargingUpdatePaymentSuccess extends ChargingRealtimeState {}

class ChargingUpdateBatteryLoading extends ChargingRealtimeState {}

class ChargingUpdateBatteryFailure extends ChargingRealtimeState {
  const ChargingUpdateBatteryFailure(String message) : super(message: message);
}

class ChargingUpdateBatterySuccess extends ChargingRealtimeState {}

class ChargingCheckStatusLoading extends ChargingRealtimeState {}

class ChargingCheckStatusFailure extends ChargingRealtimeState {}

class ChargingCheckStatusSuccess extends ChargingRealtimeState {
  const ChargingCheckStatusSuccess(CheckStatusEntity? checkStatusEntity)
      : super(checkStatusEntity: checkStatusEntity);
}

class ChargingStopChargingLoading extends ChargingRealtimeState {}

class ChargingStopChargingFailure extends ChargingRealtimeState {
  const ChargingStopChargingFailure(String message) : super(message: message);
}

class ChargingStopChargingSuccess extends ChargingRealtimeState {}
