import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/coupon_information_form.dart';
import 'package:jupiter_api/data/data_models/request/coupon_list_form.dart';
import 'package:jupiter_api/data/data_models/request/search_coupon_form.dart';
import 'package:jupiter_api/domain/entities/coupon_entity.dart';
import 'package:jupiter_api/domain/entities/search_coupon_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/utilities.dart';

import '../../../../../constant_value.dart';

part 'coupon_state.dart';

class CouponCubit extends Cubit<CouponState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  CouponCubit(this._useCase) : super(CouponInitial());

  void loadMyCoupon() async {
    emit(CouponLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.listMyCoupon(
          accessToken, CouponListForm(username: username), ConstValue.orgCode);

      result.fold(
        (failure) {
          debugPrint("MyCoupon Failure");
          emit(MyCouponFailure());
        },
        (data) {
          debugPrint("MyCoupon Cubit Success");

          emit(MyCouponSuccess(data));
        },
      );
    }, "MyCouponList");
  }

  void loadUsedCoupon() async {
    emit(CouponLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.listUsedCoupon(
          accessToken, CouponListForm(username: username), ConstValue.orgCode);

      result.fold(
        (failure) {
          debugPrint("Used Coupon Failure");
          emit(UsedCouponFailure());
        },
        (data) {
          debugPrint("Used Coupon Cubit Success");

          emit(UsedCouponSuccess(data));
        },
      );
    }, "UsedCouponList");
  }

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

  void loadScanQrcodeCoupon({String couponCode = ''}) async {
    emit(ScanQrcodeCouponLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.scanQrcodeCoupon(
          accessToken,
          CouponInformationForm(username: username, couponCode: couponCode),
          ConstValue.orgCode);

      result.fold(
        (failure) {
          debugPrint("ScanQrcodeCoupon Failure");
          emit(ScanQrcodeCouponFailure());
        },
        (data) {
          debugPrint("ScanQrcodeCoupon Cubit Success");

          emit(ScanQrcodeCouponSuccess(data));
        },
      );
    }, "ScanQrcodeCouponSearch");
  }
}
