import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/collect_coupon.dart';
import 'package:jupiter_api/data/data_models/request/coupon_information_form.dart';
import 'package:jupiter_api/domain/entities/coupon_detail_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/utilities.dart';

import '../../../../constant_value.dart';

part 'notification_detail_state.dart';

class NotificationDetailCubit extends Cubit<NotificationDetailState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  NotificationDetailCubit(this._useCase) : super(CouponDetailInitial());

  void loadCouponDetail({
    String couponCode = '',
  }) async {
    emit(CouponDetailLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.couponDetail(
          accessToken,
          CouponInformationForm(username: username, couponCode: couponCode),
          ConstValue.orgCode);

      result.fold(
        (failure) {
          emit(CouponDetailFailure());
        },
        (data) {
          emit(CouponDetailSuccess(data));
        },
      );
    }, "NotificationCouponList");
  }

  void collectCoupon({
    required String couponCode,
  }) async {
    emit(CouponDetailLoading());

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

          emit(CollectCouponSuccess());
        },
      );
    }, "NotificationCollectCoupon");
  }
}
