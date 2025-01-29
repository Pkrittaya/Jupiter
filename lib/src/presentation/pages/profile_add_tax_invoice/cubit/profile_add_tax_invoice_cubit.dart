import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/add_tax_invoice_form.dart';
import 'package:jupiter_api/data/data_models/request/billing_form.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/utilities.dart';

import '../../../../constant_value.dart';

part 'profile_add_tax_invoice_state.dart';

class ProfileAddTaxInvoiceCubit extends Cubit<ProfileAddTaxInvoiceState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  ProfileAddTaxInvoiceCubit(this._useCase)
      : super(ProfileAddTaxInvoiceInitial());

  void fetchAddTaxInvoice(BillingForm billing) async {
    emit(ProfileAddTaxInvoiceLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      debugPrint("Add Tax Invoice $username");
      debugPrint("Add Tax Invoice $accessToken");

      final result = await _useCase.addTaxInvoice(
        accessToken,
        AddTaxInvoiceForm(
          username: username,
          billing: billing,
          orgCode: ConstValue.orgCode,
        ),
      );
      result.fold(
        (failure) {
          debugPrint("Add Tax Invoice Failure");
          emit(ProfileAddTaxInvoiceFailure(failure.message));
        },
        (data) {
          debugPrint("Add Tax Invoice Cubit Success");

          emit(ProfileAddTaxInvoiceSuccess());
        },
      );
    }, "AddTaxInvoice");
  }

  void fetchUpdateTaxInvoice(BillingForm billing) async {
    emit(ProfileUpdateTaxInvoiceLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      debugPrint("Update Tax Invoice $username");
      debugPrint("Update Tax Invoice $accessToken");
      final result = await _useCase.updateTaxInvoice(
        accessToken,
        AddTaxInvoiceForm(
          username: username,
          billing: billing,
          orgCode: ConstValue.orgCode,
        ),
      );
      result.fold(
        (failure) {
          debugPrint("Update Tax Invoice Failure");
          emit(ProfileUpdateTaxInvoiceFailure(failure.message));
        },
        (data) {
          debugPrint("Update Tax Invoice Cubit Success");

          emit(ProfileUpdateTaxInvoiceSuccess());
        },
      );
    }, "UpdateTaxInvoice");
  }
}
