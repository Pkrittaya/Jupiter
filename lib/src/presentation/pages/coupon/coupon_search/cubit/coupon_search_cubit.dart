import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/collect_coupon.dart';
import 'package:jupiter_api/data/data_models/request/search_coupon_form.dart';
import 'package:jupiter_api/domain/entities/collect_coupon_entity.dart';
import 'package:jupiter_api/domain/entities/search_coupon_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/utilities.dart';

import '../../../../../constant_value.dart';

part 'coupon_search_state.dart';

class CouponSearchCubit extends Cubit<CouponSearchState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  CouponSearchCubit(this._useCase) : super(CouponSearchInitial());

  void loadCouponSearch() async {
    emit(CouponSearchLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.searchCoupon(accessToken,
          SearchCouponForm(username: username), ConstValue.orgCode);

      result.fold(
        (failure) {
          debugPrint("Coupon Failure");
          emit(CouponSearchFailure());
        },
        (data) {
          debugPrint("Coupon Cubit Success");

          emit(CouponSearchSuccess(data));
        },
      );
    }, "CouponSearch");
  }

  void collectCoupon({
    required String couponCode,
  }) async {
    emit(CollectCouponLoading());

    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.collectCoupon(
        accessToken,
        CollectCouponForm(username: username, couponCode: couponCode),
        ConstValue.orgCode,
      );

      result.fold(
        (failure) {
          debugPrint("collectCoupon Failure");
          emit(CollectCouponFailure(failure.message));
        },
        (data) {
          debugPrint("collectCoupon Cubit Success");

          emit(CollectCouponSuccess(data));
        },
      );
    }, "collectCoupon");
  }
}
