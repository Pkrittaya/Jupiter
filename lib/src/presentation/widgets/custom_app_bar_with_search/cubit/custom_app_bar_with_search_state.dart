part of 'custom_app_bar_with_search_cubit.dart';

abstract class CustomAppBarWithSearchState extends Equatable {
  const CustomAppBarWithSearchState({
    this.findingStationEntity,
    this.message,
  });
  final FindingStationEntity? findingStationEntity;
  final String? message;

  @override
  List<Object> get props => [];
}

class CustomAppBarWithSearchInitial extends CustomAppBarWithSearchState {}

class CustomAppBarWithSearchLoading extends CustomAppBarWithSearchState {}

class FindingStationSuccess extends CustomAppBarWithSearchState {
  FindingStationSuccess(FindingStationEntity? findingStationEntity)
      : super(findingStationEntity: findingStationEntity);
}

class FindingStationFailure extends CustomAppBarWithSearchState {
  const FindingStationFailure(String message) : super(message: message);
}
