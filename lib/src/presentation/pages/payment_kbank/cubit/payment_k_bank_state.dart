part of 'payment_k_bank_cubit.dart';

abstract class PaymentKBankState extends Equatable {
  PaymentKBankState({this.verifyCardEntity});
  final VerifyCardEntity? verifyCardEntity;
  @override
  List<Object> get props => [];
}

class PaymentKBankInitial extends PaymentKBankState {}

class PaymentKBankVerifyCardLoading extends PaymentKBankState {}

class PaymentKBankVerifyCardLoadingSuccess extends PaymentKBankState {
  PaymentKBankVerifyCardLoadingSuccess(VerifyCardEntity? verifyCardEntity)
      : super(verifyCardEntity: verifyCardEntity);
}

class PaymentKBankVerifyCardLoadingFailure extends PaymentKBankState {}
