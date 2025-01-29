part of 'main_menu_cubit.dart';

abstract class MainMenuState extends Equatable {
  MainMenuState({
    this.profileEntity,
  });
  final ProfileEntity? profileEntity;
  @override
  List<Object> get props => [];
}

class MainMenuInitial extends MainMenuState {}

class MainMenuSetStateForChangeLanguage extends MainMenuState {}
