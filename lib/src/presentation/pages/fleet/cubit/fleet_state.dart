part of 'fleet_cubit.dart';

sealed class FleetState extends Equatable {
  const FleetState(
      {this.message,
      this.listFleetCardEntity,
      this.listFleetOperationEntity,
      this.fleetCardEntity,
      this.fleetOperationEntity,
      this.fleetCardStationEntity,
      this.fleetOperationStationEntity,
      this.checkStatusEntity,
      this.fleetCardChargerEntity,
      this.fleetOperationChargerEntity,
      this.historyList});

  final String? message;
  final List<FleetCardItemEntity>? listFleetCardEntity;
  final List<FleetOperationItemEntity>? listFleetOperationEntity;
  final FleetCardInfoEntity? fleetCardEntity;
  final FleetOperationInfoEntity? fleetOperationEntity;
  final ListStationFleetCardEntity? fleetCardStationEntity;
  final ListStationFleetOperationEntity? fleetOperationStationEntity;
  final CheckStatusEntity? checkStatusEntity;
  final List<HistoryFleetDataEntity>? historyList;
  final ListChargerFleetCardEntity? fleetCardChargerEntity;
  final ListChargerFleetOperationEntity? fleetOperationChargerEntity;

  @override
  List<Object> get props => [];
}

class FleetInitial extends FleetState {}

class FleetLoading extends FleetState {}

class FleetCardListLoadingSuccess extends FleetState {
  FleetCardListLoadingSuccess(List<FleetCardItemEntity> listFleetCardEntity)
      : super(listFleetCardEntity: listFleetCardEntity);
}

class FleetCardListLoadingFailure extends FleetState {
  FleetCardListLoadingFailure(String message) : super(message: message);
}

class FleetOperationListLoadingSuccess extends FleetState {
  FleetOperationListLoadingSuccess(
      List<FleetOperationItemEntity> listFleetOperationEntity)
      : super(listFleetOperationEntity: listFleetOperationEntity);
}

class FleetOperationListLoadingFailure extends FleetState {
  FleetOperationListLoadingFailure(String message) : super(message: message);
}

class FleetCardDetailSuccess extends FleetState {
  FleetCardDetailSuccess(FleetCardInfoEntity fleetCardEntity)
      : super(fleetCardEntity: fleetCardEntity);
}

class FleetCardDetailFailure extends FleetState {
  FleetCardDetailFailure(String message) : super(message: message);
}

class FleetOperationDetailSuccess extends FleetState {
  FleetOperationDetailSuccess(FleetOperationInfoEntity fleetOperationEntity)
      : super(fleetOperationEntity: fleetOperationEntity);
}

class FleetOperationDetailFailure extends FleetState {
  FleetOperationDetailFailure(String message) : super(message: message);
}

class FleetTabLoading extends FleetState {}

class FleetCardStationSuccess extends FleetState {
  FleetCardStationSuccess(ListStationFleetCardEntity fleetCardStationEntity)
      : super(fleetCardStationEntity: fleetCardStationEntity);
}

class FleetCardStationFailure extends FleetState {
  FleetCardStationFailure(String message) : super(message: message);
}

class FleetOperationStationSuccess extends FleetState {
  FleetOperationStationSuccess(
      ListStationFleetOperationEntity fleetOperationStationEntity)
      : super(fleetOperationStationEntity: fleetOperationStationEntity);
}

class FleetOperationStationFailure extends FleetState {
  FleetOperationStationFailure(String message) : super(message: message);
}

class FleetCheckStatusLoading extends FleetState {}

class FleetCheckStatusSuccess extends FleetState {
  const FleetCheckStatusSuccess(CheckStatusEntity? checkStatusEntity)
      : super(checkStatusEntity: checkStatusEntity);
}

class FleetCheckStatusFailure extends FleetState {
  FleetCheckStatusFailure(String message) : super(message: message);
}

class FleetHistoryListSuccess extends FleetState {
  const FleetHistoryListSuccess(List<HistoryFleetDataEntity> historyList)
      : super(historyList: historyList);
}

class FleetHistoryListFailure extends FleetState {
  FleetHistoryListFailure(String message) : super(message: message);
}

class FleetVerifyLoading extends FleetState {}

class FleetVerifySuccess extends FleetState {}

class FleetVerifyFailure extends FleetState {
  FleetVerifyFailure(String message) : super(message: message);
}

class FleetChargerLoading extends FleetState {}

class FleetCardChargerSuccess extends FleetState {
  FleetCardChargerSuccess(ListChargerFleetCardEntity fleetCardChargerEntity)
      : super(fleetCardChargerEntity: fleetCardChargerEntity);
}

class FleetCardChargerFailure extends FleetState {
  FleetCardChargerFailure(String message) : super(message: message);
}

class FleetOperationChargerSuccess extends FleetState {
  FleetOperationChargerSuccess(
      ListChargerFleetOperationEntity fleetOperationChargerEntity)
      : super(fleetOperationChargerEntity: fleetOperationChargerEntity);
}

class FleetOperationChargerFailure extends FleetState {
  FleetOperationChargerFailure(String message) : super(message: message);
}
