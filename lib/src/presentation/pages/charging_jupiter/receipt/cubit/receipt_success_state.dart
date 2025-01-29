part of 'receipt_success_cubit.dart';

abstract class ReceiptSuccessState extends Equatable {
  const ReceiptSuccessState(
      {this.checkStatusEntity, this.listPayment, this.message});
  final CheckStatusEntity? checkStatusEntity;
  final List<dynamic>? listPayment;
  final String? message;
  @override
  List<Object> get props => [];
}

class ReceiptSuccessInitial extends ReceiptSuccessState {}

class ConfirmTransactionLoading extends ReceiptSuccessState {}

class ConfirmTransactionSuccess extends ReceiptSuccessState {}

class ConfirmTransactionFailure extends ReceiptSuccessState {}

class ReceiptSuccessCheckStatusLoading extends ReceiptSuccessState {}

class ReceiptSuccessCheckStatusFailure extends ReceiptSuccessState {}

class ReceiptSuccessCheckStatusSuccess extends ReceiptSuccessState {
  const ReceiptSuccessCheckStatusSuccess(CheckStatusEntity? checkStatusEntity)
      : super(checkStatusEntity: checkStatusEntity);
}

class ChargingGetPaymentLoading extends ReceiptSuccessState {}

class ChargingGetPaymentFailure extends ReceiptSuccessState {}

class ChargingGetPaymentSuccess extends ReceiptSuccessState {
  const ChargingGetPaymentSuccess(
    List<dynamic>? listPayment,
  ) : super(listPayment: listPayment);
}

class ChargingUpdatePaymentLoading extends ReceiptSuccessState {}

class ChargingUpdatePaymentFailure extends ReceiptSuccessState {
  const ChargingUpdatePaymentFailure(String message) : super(message: message);
}

class ChargingUpdatePaymentSuccess extends ReceiptSuccessState {}

class PaymentChargingLoading extends ReceiptSuccessState {}

class PaymentChargingFailure extends ReceiptSuccessState {
  const PaymentChargingFailure(String message) : super(message: message);
}

class PaymentChargingSuccess extends ReceiptSuccessState {}

class ChargingRealtimeInitial extends ReceiptSuccessState {}
