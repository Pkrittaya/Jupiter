import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/data/data_models/request/delete_tax_invoice_form.dart';
import 'package:jupiter_api/data/data_models/request/profile_form.dart';
import 'package:jupiter_api/data/data_models/request/username_and_orgcode_form.dart';
import 'package:jupiter_api/domain/entities/billing_entity.dart';
import 'package:jupiter_api/domain/entities/list_billing_entity.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';

part 'profie_edit_state.dart';

class ProfileEditCubit extends Cubit<ProfileEditState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  ProfileEditCubit(this._useCase) : super(ProfileEditInitial());

  void updateProfilePicture(File imagesFile) async {
    // final fileBytes = await imagesFile.readAsBytes();

    emit(ProfileEditImageLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      debugPrint('UpdateProfile $username');
      debugPrint('UpdateProfile $imagesFile ');
      debugPrint('UpdateProfile $accessToken');

      final result = await _useCase.updateProfilePicture(
          accessToken, imagesFile, Utilities.toJwt({}));

      result.fold(
        (failure) {
          debugPrint('Profile Failure');
          emit(ProfileEditImageFailure());
        },
        (data) {
          debugPrint('Profile Cubit Success');

          emit(ProfileEditImageSuccess());
        },
      );
    }, 'UpdateProfilePicture');
  }

  void updateProfile(ProfileForm profileForm) async {
    // final fileBytes = await imagesFile.readAsBytes();

    emit(ProfileEditSaveLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.updateProfile(accessToken, profileForm);

      result.fold(
        (failure) {
          debugPrint('Profile Failure');
          emit(ProfileEditSaveFailure());
        },
        (data) {
          debugPrint('Profile Cubit Success');

          emit(ProfileEditSaveSuccess());
        },
      );
    }, 'UpdateProfile');
  }

  void fetchTaxInvoice() async {
    emit(ProfileEditGetTaxInvoiceLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.getTaxInvoice(
          accessToken,
          UsernameAndOrgCodeForm(
              username: username, orgCode: ConstValue.orgCode));

      result.fold(
        (failure) {
          debugPrint('GetTaxInvoice Failure');
          emit(ProfileEditGetTaxInvoiceFailure(failure.message));
        },
        (data) {
          debugPrint('GetTaxInvoice Cubit Success');

          emit(ProfileEditGetTaxInvoiceSuccess(data));
        },
      );
    }, 'GetTaxInvoice');
  }

  void fetchDeleteTaxInvoice(BillingEntity billing) async {
    emit(ProfileEditDeleteTaxInvoiceLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.deleteTaxInvoice(
          accessToken,
          DeleteTaxInvoiceForm(
            username: username,
            billingId: billing.billingId,
            billingName: billing.billingName,
            orgCode: ConstValue.orgCode,
          ));

      result.fold(
        (failure) {
          debugPrint('DeleteTaxInvoice Failure');
          emit(ProfileEditDeleteTaxInvoiceFailure(failure.message));
        },
        (data) {
          debugPrint('DeleteTaxInvoice Cubit Success');

          emit(ProfileEditDeleteTaxInvoiceSuccess());
        },
      );
    }, 'DeleteTaxInvoice');
  }

  void resetStateProfileEdit() {
    emit(ProfileEditInitial());
  }
}
