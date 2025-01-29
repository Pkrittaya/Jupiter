part of 'scan_qr_code_cubit.dart';

abstract class ScanQrCodeState extends Equatable {
  const ScanQrCodeState({this.chargerInformationEntity, this.message});
  final ChargerInformationEntity? chargerInformationEntity;
  final String? message;
  @override
  List<Object> get props => [];
}

class ScanQrCodeInitial extends ScanQrCodeState {}

class ScanQrCodeLoading extends ScanQrCodeState {}

class ScanQrCodeLoadChargerInformationSuccess extends ScanQrCodeState {
  const ScanQrCodeLoadChargerInformationSuccess(
      ChargerInformationEntity chargerInformationEntity)
      : super(chargerInformationEntity: chargerInformationEntity);
}

class ScanQrCodeLoadChargerInformationFailure extends ScanQrCodeState {
  ScanQrCodeLoadChargerInformationFailure(String message)
      : super(message: message);
}
