part of 'advertisement_home_page_cubit.dart';

sealed class AdvertisementHomePageState extends Equatable {
  const AdvertisementHomePageState({
    this.advertisementEntity,
    this.message,
  });

  final AdvertisementEntity? advertisementEntity;
  final String? message;

  @override
  List<Object> get props => [];
}

class AdvertisementHomePageInitial extends AdvertisementHomePageState {}

class AdvertisementHomePageLoading extends AdvertisementHomePageState {}

class AdvertisementHomePageSuccess extends AdvertisementHomePageState {
  AdvertisementHomePageSuccess(AdvertisementEntity advertisementEntity)
      : super(advertisementEntity: advertisementEntity);
}

class AdvertisementHomePageFailure extends AdvertisementHomePageState {}
