part of 'check_in_cubit.dart';

abstract class CheckInState extends Equatable {
  const CheckInState(
      {this.chargerInformation,
      this.dataStartForm,
      this.token,
      this.message,
      this.couponSearch,
      this.scanQrcodeCoupon,
      this.collectCoupon});

  final ChargerInformationEntity? chargerInformation;
  final StartChargerForm? dataStartForm;
  final String? token;
  final String? message;
  final List<SearchCouponItemForUsedEntity>? couponSearch;
  final SearchCouponItemForUsedEntity? scanQrcodeCoupon;
  final CollectCouponEntity? collectCoupon;

  @override
  List<Object> get props => [];
}

class CheckInInitial extends CheckInState {}

class CheckInLoading extends CheckInState {}

class CheckInFailure extends CheckInState {
  const CheckInFailure(String message) : super(message: message);
}

class CheckInCatch extends CheckInState {}

class CheckInSuccess extends CheckInState {
  const CheckInSuccess(
      ChargerInformationEntity chargerInformation, String? token)
      : super(chargerInformation: chargerInformation, token: token);
}

class CheckInCheckStartChargingLoading extends CheckInState {}

class CheckInCheckStartChargingFailure extends CheckInState {
  const CheckInCheckStartChargingFailure(String message)
      : super(message: message);
}

class CheckInCheckStartChargingSuccess extends CheckInState {}

class CouponSearchLoading extends CheckInState {}

class CouponSearchSuccess extends CheckInState {
  CouponSearchSuccess(List<SearchCouponItemForUsedEntity>? couponSearch)
      : super(couponSearch: couponSearch);
}

class CouponSearchFailure extends CheckInState {}

class CollectCouponLoading extends CheckInState {}

class CollectCouponSuccess extends CheckInState {
  CollectCouponSuccess(CollectCouponEntity? collectCoupon)
      : super(collectCoupon: collectCoupon);
}

class CollectCouponFailure extends CheckInState {
  const CollectCouponFailure(String? message) : super(message: message);
}

class ScanQrcodeCouponLoading extends CheckInState {}

class ScanQrcodeCouponSuccess extends CheckInState {
  ScanQrcodeCouponSuccess(SearchCouponItemForUsedEntity? scanQrcodeCoupon)
      : super(scanQrcodeCoupon: scanQrcodeCoupon);
}

class ScanQrcodeCouponFailure extends CheckInState {}
