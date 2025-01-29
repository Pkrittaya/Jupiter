part of 'payment_cubit.dart';

abstract class PaymentState extends Equatable {
  PaymentState({this.creditCardList});
  final List<CreditCardEntity>? creditCardList;
  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentCreditCardLoading extends PaymentState {}

class PaymentCreditCardLoadingSuccess extends PaymentState {
  PaymentCreditCardLoadingSuccess(List<CreditCardEntity>? creditCardList)
      : super(creditCardList: creditCardList);
}

class PaymentCreditCardLoadingFailure extends PaymentState {}
