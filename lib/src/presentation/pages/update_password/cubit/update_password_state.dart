part of 'update_password_cubit.dart';

abstract class UpdatePasswordState extends Equatable {
  const UpdatePasswordState({
    this.profileEntity,
    this.message,
    this.requestOtpdata,
  });

  final ProfileEntity? profileEntity;
  final String? message;
  final RequestOtpForgotPinEntity? requestOtpdata;
  @override
  List<Object> get props => [];
}

class UpdatePasswordInitial extends UpdatePasswordState {}

class UpdatePasswordLoading extends UpdatePasswordState {}

class LoadProfileSuccess extends UpdatePasswordState {
  LoadProfileSuccess(ProfileEntity profileEntity)
      : super(profileEntity: profileEntity);
}

class LoadProfileFailure extends UpdatePasswordState {
  const LoadProfileFailure(String message) : super(message: message);
}

class RequestOtpSuccess extends UpdatePasswordState {
  const RequestOtpSuccess(RequestOtpForgotPinEntity requestOtpdata)
      : super(requestOtpdata: requestOtpdata);
}

class RequestOtpFailure extends UpdatePasswordState {
  const RequestOtpFailure(String message) : super(message: message);
}

class VerifyOtpSuccess extends UpdatePasswordState {}

class VerifyOtpFailure extends UpdatePasswordState {
  const VerifyOtpFailure(String message) : super(message: message);
}

class UpdatePasswordSuccess extends UpdatePasswordState {}

class UpdatePasswordFailure extends UpdatePasswordState {
  const UpdatePasswordFailure(String message) : super(message: message);
}
