part of 'booking_cubit.dart';

abstract class BookingState extends Equatable {
  const BookingState({
    this.message,
    this.listReserveData,
    this.creditCardList,
    this.reserveReceiptData,
  });

  final List<CreditCardEntity>? creditCardList;
  final GetListReserveEntity? listReserveData;
  final String? message;
  final ReserveReceiptEntity? reserveReceiptData;

  @override
  List<Object> get props => [];
}

class BookingInitial extends BookingState {}

class BookingListLoading extends BookingState {}

class BookingListSuccess extends BookingState {
  const BookingListSuccess(GetListReserveEntity listReserveData)
      : super(listReserveData: listReserveData);
}

class BookingListFailure extends BookingState {
  const BookingListFailure(String message) : super(message: message);
}

class BookingCreateReserveLoading extends BookingState {}

class BookingCreateReserveSuccess extends BookingState {
  const BookingCreateReserveSuccess(ReserveReceiptEntity reserveReceiptData)
      : super(reserveReceiptData: reserveReceiptData);
}

class BookingCreateReserveFailure extends BookingState {
  const BookingCreateReserveFailure(String message) : super(message: message);
}

class BookingGetPaymentLoading extends BookingState {}

class BookingGetPaymentSuccess extends BookingState {
  const BookingGetPaymentSuccess(List<CreditCardEntity> creditCardList)
      : super(creditCardList: creditCardList);
}

class BookingGetPaymentFailure extends BookingState {
  const BookingGetPaymentFailure(String message) : super(message: message);
}
