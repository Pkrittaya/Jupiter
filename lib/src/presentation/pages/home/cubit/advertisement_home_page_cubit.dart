import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/username_and_orgcode_form.dart';
import 'package:jupiter_api/domain/entities/advertisement_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/utilities.dart';

import '../../../../constant_value.dart';

part 'advertisement_home_page_state.dart';

class AdvertisementHomePageCubit extends Cubit<AdvertisementHomePageState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  AdvertisementHomePageCubit(this._useCase)
      : super(AdvertisementHomePageInitial());

  void loadAdvertisement() async {
    emit(AdvertisementHomePageLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.advertisement(
          accessToken,
          UsernameAndOrgCodeForm(
              username: username, orgCode: ConstValue.orgCode));
      result.fold(
        (failure) {
          debugPrint('HomeLoadAdvertiseFailure Failure');
          emit(AdvertisementHomePageFailure());
        },
        (data) {
          debugPrint('HomeLoadAdvertiseSuccess Cubit Success');
          emit(AdvertisementHomePageSuccess(data));
        },
      );
    }, 'Advertisement');
  }
}
