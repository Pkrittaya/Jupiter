part of 'forgot_pincode_cubit.dart';

abstract class ForgotPincodeState extends Equatable {
  const ForgotPincodeState({
    this.message,
    this.requestOtpdata,
  });

  final String? message;
  final RequestOtpForgotPinEntity? requestOtpdata;
  @override
  List<Object> get props => [];
}

class ForgotPincodeInitial extends ForgotPincodeState {}

class RequestOtpToResetPinLoading extends ForgotPincodeState {}

class RequestOtpToResetPinFailure extends ForgotPincodeState {
  const RequestOtpToResetPinFailure(String message) : super(message: message);
}

class RequestOtpToResetPinSuccess extends ForgotPincodeState {
  const RequestOtpToResetPinSuccess(RequestOtpForgotPinEntity requestOtpdata)
      : super(requestOtpdata: requestOtpdata);
}

class SendOtpVerifyToResetPinLoading extends ForgotPincodeState {}

class SendOtpVerifyToResetPinFailure extends ForgotPincodeState {
  const SendOtpVerifyToResetPinFailure(String message)
      : super(message: message);
}

class SendOtpVerifyToResetPinSuccess extends ForgotPincodeState {}
