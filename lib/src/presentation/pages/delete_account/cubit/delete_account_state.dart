part of 'delete_account_cubit.dart';

abstract class DeleteAccountState extends Equatable {
  const DeleteAccountState({
    this.message,
  });

  final String? message;
  @override
  List<Object> get props => [];
}

class DeleteAccountInitial extends DeleteAccountState {}

class DeleteAccountLoading extends DeleteAccountState {}

class DeleteAccountFailure extends DeleteAccountState {
  const DeleteAccountFailure(String message) : super(message: message);
}

class DeleteAccountSuccess extends DeleteAccountState {}
