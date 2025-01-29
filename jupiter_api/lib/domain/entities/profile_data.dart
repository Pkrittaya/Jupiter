import 'profile_entity.dart';

class ProfileData {
  ProfileData();
  ProfileEntity? profileEntity;
  ProfileEntity? get getProfileEntity => profileEntity;

  set setProfileEntity(ProfileEntity? profileEntity) =>
      this.profileEntity = profileEntity;
}
