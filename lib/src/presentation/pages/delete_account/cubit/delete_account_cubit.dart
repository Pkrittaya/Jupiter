import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/delete_account_form.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/utilities.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  DeleteAccountCubit(this._useCase) : super(DeleteAccountInitial());

  void fetchdeleteAccount(String password) async {
    emit(DeleteAccountLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.deleteAccount(
          accessToken, DeleteAccountForm(password: password));
      result.fold(
        (failure) {
          emit(DeleteAccountFailure(failure.message));
        },
        (data) {
          emit(DeleteAccountSuccess());
        },
      );
    }, 'DeleteAccount');
  }
}
