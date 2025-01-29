import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/term_and_condition_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';

part 'policy_state.dart';

class PolicyCubit extends Cubit<PolicyState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  PolicyCubit(this._useCase) : super(PolicyInitial());

  void getPolicy() async {
    emit(PolicyLoading());
    final result = await _useCase.termAndCondition(ConstValue.orgCode);
    result.fold(
      (failure) {
        emit(PolicyFailure(failure.message));
      },
      (data) {
        emit(PolicySuccess(data));
      },
    );
  }

  void resetStatetoInital() {
    emit(PolicyInitial());
  }
}
