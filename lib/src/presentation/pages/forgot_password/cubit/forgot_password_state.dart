part of 'forgot_password_cubit.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.message,
  });

  final String? message;
  @override
  List<Object> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordSendEmailLoading extends ForgotPasswordState {}

class ForgotPasswordSendEmailFailure extends ForgotPasswordState {
  const ForgotPasswordSendEmailFailure(String message)
      : super(message: message);
}

class ForgotPasswordSendEmailSuccess extends ForgotPasswordState {}

class VerifySendEmailFailure extends ForgotPasswordState {
  const VerifySendEmailFailure(String message) : super(message: message);
}

class VerifySendEmailSuccess extends ForgotPasswordState {}
