part of 'history_detail_cubit.dart';

abstract class HistoryDetailState extends Equatable {
  const HistoryDetailState({
    this.historyDetail,
    this.historyBookingDetail,
  });
  final HistoryDetailEntity? historyDetail;
  final HistoryBookingDetailEntity? historyBookingDetail;
  @override
  List<Object> get props => [];
}

class HistoryDetailInitial extends HistoryDetailState {}

class HistoryDetailLoadingStart extends HistoryDetailState {}

class HistoryDetailLoadingFailure extends HistoryDetailState {}

class HistoryDetailLoadingSuccess extends HistoryDetailState {
  HistoryDetailLoadingSuccess(HistoryDetailEntity? historyDetail)
      : super(historyDetail: historyDetail);
}

class HistoryBookingDetailLoadingStart extends HistoryDetailState {}

class HistoryBookingDetailLoadingFailure extends HistoryDetailState {}

class HistoryBookingDetailLoadingSuccess extends HistoryDetailState {
  HistoryBookingDetailLoadingSuccess(
      HistoryBookingDetailEntity? historyBookingDetail)
      : super(historyBookingDetail: historyBookingDetail);
}
