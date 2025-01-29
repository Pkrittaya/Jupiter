part of 'profile_add_tax_invoice_cubit.dart';

abstract class ProfileAddTaxInvoiceState extends Equatable {
  const ProfileAddTaxInvoiceState({
    this.message,
  });

  final String? message;

  @override
  List<Object> get props => [];
}

class ProfileAddTaxInvoiceInitial extends ProfileAddTaxInvoiceState {}

class ProfileAddTaxInvoiceLoading extends ProfileAddTaxInvoiceState {}

class ProfileAddTaxInvoiceFailure extends ProfileAddTaxInvoiceState {
  const ProfileAddTaxInvoiceFailure(String message) : super(message: message);
}

class ProfileAddTaxInvoiceSuccess extends ProfileAddTaxInvoiceState {}

class ProfileUpdateTaxInvoiceLoading extends ProfileAddTaxInvoiceState {}

class ProfileUpdateTaxInvoiceFailure extends ProfileAddTaxInvoiceState {
  const ProfileUpdateTaxInvoiceFailure(String message)
      : super(message: message);
}

class ProfileUpdateTaxInvoiceSuccess extends ProfileAddTaxInvoiceState {}
