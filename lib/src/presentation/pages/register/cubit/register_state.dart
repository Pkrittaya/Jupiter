part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState({
    this.verifyAccountEntity,
    this.message,
    this.verifyAccountForm,
    this.termAndConditionEntity,
    this.signUpEntity,
    this.listCarFromService,
  });

  final VerifyAccountEntity? verifyAccountEntity;
  final String? message;
  final VerifyAccountForm? verifyAccountForm;
  final TermAndConditionEntity? termAndConditionEntity;
  final SignUpEntity? signUpEntity;
  final List<CarMasterEntity>? listCarFromService;
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class VerifyAccountSuccess extends RegisterState {
  const VerifyAccountSuccess(VerifyAccountForm? verifyAccountForm,
      VerifyAccountEntity? verifyAccountEntity)
      : super(
            verifyAccountForm: verifyAccountForm,
            verifyAccountEntity: verifyAccountEntity);
}

class VerifyAccountFailure extends RegisterState {
  const VerifyAccountFailure(String? message) : super(message: message);
}

class TermAndConditionSuccess extends RegisterState {
  const TermAndConditionSuccess(TermAndConditionEntity? termAndConditionEntity)
      : super(termAndConditionEntity: termAndConditionEntity);
}

class TermAndConditionFailure extends RegisterState {
  const TermAndConditionFailure(String? message) : super(message: message);
}

class TermAndConditionAccepted extends RegisterState {}

class SignUpSuccess extends RegisterState {
  const SignUpSuccess(SignUpEntity? signUpEntity)
      : super(signUpEntity: signUpEntity);
}

class SignUpFailure extends RegisterState {
  const SignUpFailure(String? message) : super(message: message);
}

class WaitingToActiveAccount extends RegisterState {}

class LoginLoading extends RegisterState {}

class LoginSuccess extends RegisterState {}

class LoginFailure extends RegisterState {
  const LoginFailure(String? message) : super(message: message);
}

class GetCarMasterLoading extends RegisterState {}

class GetCarMasterSuccess extends RegisterState {
  GetCarMasterSuccess(List<CarMasterEntity> listCarFromService)
      : super(listCarFromService: listCarFromService);
}

class GetCarMasterFailure extends RegisterState {
  const GetCarMasterFailure(String? message) : super(message: message);
}

class AddCarMasterLoading extends RegisterState {}

class AddCarMasterSuccess extends RegisterState {}

class AddCarMasterFailure extends RegisterState {
  const AddCarMasterFailure(String? message) : super(message: message);
}
