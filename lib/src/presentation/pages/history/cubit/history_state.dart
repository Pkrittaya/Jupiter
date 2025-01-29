part of 'history_cubit.dart';

abstract class HistoryState extends Equatable {
  const HistoryState({
    this.historyList,
    this.historyBookingList,
    this.message,
  });

  final HistoryEntity? historyList;
  final HistoryBookingListEntity? historyBookingList;
  final String? message;

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoadingStart extends HistoryState {}

class HistoryLoadingFailure extends HistoryState {}

class HistoryLoadingSuccess extends HistoryState {
  HistoryLoadingSuccess(HistoryEntity? historyList)
      : super(historyList: historyList);
}

class HistoryBookingLoadingStart extends HistoryState {}

class HistoryBookingLoadingFailure extends HistoryState {
  HistoryBookingLoadingFailure(String? message) : super(message: message);
}

class HistoryBookingLoadingSuccess extends HistoryState {
  HistoryBookingLoadingSuccess(HistoryBookingListEntity? historyBookingList)
      : super(historyBookingList: historyBookingList);
}
