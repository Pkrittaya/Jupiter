import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/data/data_models/request/username_and_orgcode_form.dart';
import 'package:jupiter_api/domain/entities/profile_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';

import '../../../../constant_value.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  ProfileCubit(this._useCase) : super(ProfileInitial());

  void loadProfile() async {
    emit(ProfileLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.profile(
          accessToken,
          UsernameAndOrgCodeForm(
              username: username, orgCode: ConstValue.orgCode));

      result.fold(
        (failure) {
          debugPrint("Profile Failure");
          emit(ProfileFailure());
        },
        (data) {
          debugPrint("Profile Cubit Success");
          debugPrint("Profile Cubit ${data.username} ${data.name}");

          emit(ProfileSuccess(data));
        },
      );
    }, "Profile");
  }
}
