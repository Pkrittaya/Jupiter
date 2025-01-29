part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState({this.signInEntity, this.message});
  final SignInEntity? signInEntity;
  final String? message;

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  const LoginSuccess(SignInEntity signInEntity)
      : super(signInEntity: signInEntity);
}

class LoginFailure extends LoginState {
  const LoginFailure(String? message) : super(message: message);
}
