part of 'coupon_detail_cubit.dart';

abstract class CouponDetailState extends Equatable {
  const CouponDetailState({this.couponDetailEntity, this.message});
  final CouponDetailEntity? couponDetailEntity;
  final String? message;
  @override
  List<Object> get props => [];
}

class CouponDetailInitial extends CouponDetailState {}

class CouponDetailLoading extends CouponDetailState {}

class CouponDetailSuccess extends CouponDetailState {
  CouponDetailSuccess(CouponDetailEntity? couponDetailEntity)
      : super(couponDetailEntity: couponDetailEntity);
}

class CouponDetailFailure extends CouponDetailState {}

class CollectCouponLoading extends CouponDetailState {}

class CollectCouponSuccess extends CouponDetailState {}

class CollectCouponFailure extends CouponDetailState {
  const CollectCouponFailure(String? message) : super(message: message);
}
