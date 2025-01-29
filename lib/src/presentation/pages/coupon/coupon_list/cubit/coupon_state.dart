part of 'coupon_cubit.dart';

abstract class CouponState extends Equatable {
  const CouponState(
      {this.couponEntity, this.couponSearch, this.scanQrcodeCoupon});
  final List<CouponItemEntity>? couponEntity;
  final List<SearchCouponItemEntity>? couponSearch;
  final SearchCouponItemEntity? scanQrcodeCoupon;
  @override
  List<Object> get props => [];
}

class CouponInitial extends CouponState {}

class CouponLoading extends CouponState {}

class MyCouponSuccess extends CouponState {
  MyCouponSuccess(List<CouponItemEntity>? couponEntity)
      : super(couponEntity: couponEntity);
}

class MyCouponFailure extends CouponState {}

class UsedCouponSuccess extends CouponState {
  UsedCouponSuccess(List<CouponItemEntity>? couponEntity)
      : super(couponEntity: couponEntity);
}

class UsedCouponFailure extends CouponState {}

class CouponSearchLoading extends CouponState {}

class CouponSearchSuccess extends CouponState {
  CouponSearchSuccess(List<SearchCouponItemEntity>? couponSearch)
      : super(couponSearch: couponSearch);
}

class CouponSearchFailure extends CouponState {}

class ScanQrcodeCouponLoading extends CouponState {}

class ScanQrcodeCouponSuccess extends CouponState {
  ScanQrcodeCouponSuccess(SearchCouponItemEntity? scanQrcodeCoupon)
      : super(scanQrcodeCoupon: scanQrcodeCoupon);
}

class ScanQrcodeCouponFailure extends CouponState {}
