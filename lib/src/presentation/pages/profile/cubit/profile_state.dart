part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  ProfileState({
    this.profileEntity,
  });
  final ProfileEntity? profileEntity;
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  ProfileSuccess(ProfileEntity profileEntity)
      : super(profileEntity: profileEntity);
}

class ProfileFailure extends ProfileState {}
