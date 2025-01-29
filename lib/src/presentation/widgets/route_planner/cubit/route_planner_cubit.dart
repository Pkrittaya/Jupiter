import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/data/data_models/request/add_favorite_route_form.dart';
import 'package:jupiter_api/data/data_models/request/add_fovorite_route_point_form.dart';
import 'package:jupiter_api/data/data_models/request/delete_favotite_route_form.dart';
import 'package:jupiter_api/data/data_models/request/update_fovorite_route_form.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';

part 'route_planner_state.dart';

class RoutePlannerCubit extends Cubit<RoutePlannerState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  RoutePlannerCubit(this._useCase) : super(RoutePlannerInitial());

  void deleteFavoriteRoute({
    required String routeName,
  }) async {
    emit(RoutePlannerLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.deleteFavoriteRoute(
          accessToken,
          DeleteFavoriteRouteForm(
            routeName: routeName,
          ));
      result.fold(
        (failure) {
          debugPrint("deleteFavoriteRoute Failure");
          emit(DeleteFavoriteRouteFailure(failure.message));
        },
        (data) {
          debugPrint("deleteFavoriteRoute Cubit Success");
          emit(DeleteFavoriteRouteSuccess());
        },
      );
    }, "DeleteFavoriteRoute");
  }

  void addFavoriteRoute(
      {required String routeName,
      required int routeDistance,
      required int routeDuration,
      required List<AddFavoriteRoutePointForm> routePoint}) async {
    emit(RoutePlannerLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.addFavoriteRoute(
          accessToken,
          AddFavoriteRouteForm(
              routeName: routeName,
              routeDistance: routeDistance,
              routeDuration: routeDuration,
              routePoint: routePoint));
      result.fold(
        (failure) {
          debugPrint("addFavoriteRoute Failure");
          emit(AddFavoriteRouteFailure(failure.message));
        },
        (data) {
          debugPrint("addFavoriteRoute Cubit Success");
          emit(AddFavoriteRouteSuccess());
        },
      );
    }, "AddFavoriteRoute");
  }

  void updateFavoriteRoute(
      {required String routeName,
      required String routeNameNew,
      required int routeDistance,
      required int routeDuration,
      required List<AddFavoriteRoutePointForm> routePoint}) async {
    emit(RoutePlannerLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.updateFavoriteRoute(
          accessToken,
          UpdateFavoriteRouteForm(
              routeName: routeName,
              routeNameNew: routeNameNew,
              routeDistance: routeDistance,
              routeDuration: routeDuration,
              routePoint: routePoint));
      result.fold(
        (failure) {
          debugPrint("updateFavoriteRoute Failure");
          emit(UpdateFavoriteRouteFailure(failure.message));
        },
        (data) {
          debugPrint("updateFavoriteRoute Cubit Success");
          emit(UpdateFavoriteRouteSuccess());
        },
      );
    }, "UpdateFavoriteRoute");
  }

  void resetStateInitial() {
    emit(RoutePlannerInitial());
  }
}
