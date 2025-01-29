// ignore_for_file: unused_field

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/domain/entities/profile_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';

part 'main_menu_state.dart';

class MainMenuCubit extends Cubit<MainMenuState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  MainMenuCubit(this._useCase) : super(MainMenuInitial());

  void setStateForChangeLanguage() {
    emit(MainMenuSetStateForChangeLanguage());
  }

  void resetMainMenuStateInitial() {
    emit(MainMenuInitial());
  }
}
