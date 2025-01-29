part of 'coupon_search_cubit.dart';

abstract class CouponSearchState extends Equatable {
  const CouponSearchState(
      {this.couponSearch, this.collectCoupon, this.message});
  final List<SearchCouponItemEntity>? couponSearch;
  final CollectCouponEntity? collectCoupon;
  final String? message;
  @override
  List<Object> get props => [];
}

class CouponSearchInitial extends CouponSearchState {}

class CouponSearchLoading extends CouponSearchState {}

class CouponSearchSuccess extends CouponSearchState {
  CouponSearchSuccess(List<SearchCouponItemEntity>? couponSearch)
      : super(couponSearch: couponSearch);
}

class CouponSearchFailure extends CouponSearchState {}

class CollectCouponLoading extends CouponSearchState {}

class CollectCouponSuccess extends CouponSearchState {
  CollectCouponSuccess(CollectCouponEntity? collectCoupon)
      : super(collectCoupon: collectCoupon);
}

class CollectCouponFailure extends CouponSearchState {
  const CollectCouponFailure(String? message) : super(message: message);
}
