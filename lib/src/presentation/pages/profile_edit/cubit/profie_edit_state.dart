part of 'profile_edit_cubit.dart';

abstract class ProfileEditState extends Equatable {
  const ProfileEditState({
    this.message,
    this.listBilling,
  });

  final String? message;
  final ListBillingEntity? listBilling;

  @override
  List<Object> get props => [];
}

class ProfileEditInitial extends ProfileEditState {}

class ProfileEditLoading extends ProfileEditState {}

class ProfileEditSaveLoading extends ProfileEditState {}

class ProfileEditSaveSuccess extends ProfileEditState {}

class ProfileEditSaveFailure extends ProfileEditState {}

class ProfileEditImageLoading extends ProfileEditState {}

class ProfileEditImageSuccess extends ProfileEditState {}

class ProfileEditImageFailure extends ProfileEditState {}

class ProfileEditGetTaxInvoiceLoading extends ProfileEditState {}

class ProfileEditGetTaxInvoiceSuccess extends ProfileEditState {
  const ProfileEditGetTaxInvoiceSuccess(ListBillingEntity listBilling)
      : super(listBilling: listBilling);
}

class ProfileEditGetTaxInvoiceFailure extends ProfileEditState {
  const ProfileEditGetTaxInvoiceFailure(String message)
      : super(message: message);
}

class ProfileEditDeleteTaxInvoiceLoading extends ProfileEditState {}

class ProfileEditDeleteTaxInvoiceSuccess extends ProfileEditState {}

class ProfileEditDeleteTaxInvoiceFailure extends ProfileEditState {
  const ProfileEditDeleteTaxInvoiceFailure(String message)
      : super(message: message);
}
