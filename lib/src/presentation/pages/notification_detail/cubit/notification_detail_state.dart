part of 'notification_detail_cubit.dart';

abstract class NotificationDetailState extends Equatable {
  const NotificationDetailState({this.couponDetailEntity, this.message});
  final CouponDetailEntity? couponDetailEntity;
  final String? message;
  @override
  List<Object> get props => [];
}

class CouponDetailInitial extends NotificationDetailState {}

class CouponDetailLoading extends NotificationDetailState {}

class CouponDetailSuccess extends NotificationDetailState {
  CouponDetailSuccess(CouponDetailEntity? couponDetailEntity)
      : super(couponDetailEntity: couponDetailEntity);
}

class CouponDetailFailure extends NotificationDetailState {}

class CollectCouponSuccess extends NotificationDetailState {}

class CollectCouponFailure extends NotificationDetailState {
  const CollectCouponFailure(String? message) : super(message: message);
}
