part of 'payment_detail_cubit.dart';

abstract class PaymentDetailState extends Equatable {
  const PaymentDetailState({
    this.creditCardList,
    this.message,
  });
  final List<CreditCardEntity>? creditCardList;
  final String? message;
  @override
  List<Object> get props => [];
}

class PaymentDetailInitial extends PaymentDetailState {}

class PaymentCreditCardDeleteStart extends PaymentDetailState {}

class PaymentCreditCardDeleteSuccess extends PaymentDetailState {}

class PaymentCreditCardDeleteFailure extends PaymentDetailState {
  const PaymentCreditCardDeleteFailure(String message)
      : super(message: message);
}

class PaymentSetDefaultCardLoading extends PaymentDetailState {}

class PaymentSetDefaultCardSuccess extends PaymentDetailState {}

class PaymentSetDefaultCardFailure extends PaymentDetailState {
  const PaymentSetDefaultCardFailure(String message) : super(message: message);
}
