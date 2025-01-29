part of 'setting_privacy_cubit.dart';

abstract class SettingPrivacyState extends Equatable {
  const SettingPrivacyState({
    this.message,
  });

  final String? message;
  @override
  List<Object> get props => [];
}

class SettingPrivacyInitial extends SettingPrivacyState {}

class SettingPrivacyLoading extends SettingPrivacyState {}

class SettingPrivacySuccess extends SettingPrivacyState {}

class SettingPrivacyFailure extends SettingPrivacyState {
  const SettingPrivacyFailure(String? message) : super(message: message);
}
