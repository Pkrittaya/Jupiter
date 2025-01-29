// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/car_select_form.dart';
import 'package:jupiter_api/data/data_models/request/check_in_fleet_form.dart';
import 'package:jupiter_api/data/data_models/request/collect_coupon.dart';
import 'package:jupiter_api/data/data_models/request/coupon_information_form.dart';
import 'package:jupiter_api/data/data_models/request/optional_detail_form.dart';
import 'package:jupiter_api/data/data_models/request/charger_information_form.dart';
import 'package:jupiter_api/data/data_models/request/payment_coupon_form.dart';
import 'package:jupiter_api/data/data_models/request/payment_type_form.dart';
import 'package:jupiter_api/data/data_models/request/remote_start_fleet_form.dart';
import 'package:jupiter_api/data/data_models/request/search_coupon_form.dart';
import 'package:jupiter_api/data/data_models/request/start_charger_form.dart';
import 'package:jupiter_api/domain/entities/charger_information_entity.dart';
import 'package:jupiter_api/domain/entities/collect_coupon_entity.dart';
import 'package:jupiter_api/domain/entities/search_coupon_for_used_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/utilities.dart';

import '../../../../../../constant_value.dart';

part 'check_in_state.dart';

class CheckInCubit extends Cubit<CheckInState> {
  @FactoryMethod()
  final UserManagementUseCase _useCase;
  CheckInCubit(this._useCase) : super(CheckInInitial());

  void loadInfomation(String qrCode) async {
    emit(CheckInLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.chargerInformation(
          accessToken,
          ChargerInformationForm(
            username: username,
            qrCodeConnector: qrCode,
            deviceCode: deviceCode,
            orgCode: ConstValue.orgCode,
          ));

      result.fold(
        (failure) {
          emit(CheckInFailure(failure.message));
        },
        (data) {
          emit(CheckInSuccess(data, accessToken));
        },
      );
    }, 'GetChargerInformation');
  }

  void startCharging({
    String? chargerId,
    String? connectorId,
    int? connectorIndex,
    String? chargingType,
    String? chargerType,
    OptionalDetailForm? optionalCharging,
    String? qrCode,
    required String orgCode,
    required CarSelectForm? carSelected,
    required PaymentTypeForm paymentSelected,
    required ChargerInformationEntity data,
    required PaymentCouponForm? couponSelected,
  }) async {
    emit(CheckInCheckStartChargingLoading());

    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.startCharging(
          accessToken,
          StartChargerForm(
              username: username,
              orgCode: orgCode,
              qrCodeConnector: qrCode ?? '',
              chargerId: chargerId ?? '',
              connectorId: connectorId ?? '',
              connectorIndex: connectorIndex ?? 0,
              deviceCode: deviceCode,
              chargingType: chargingType ?? '',
              chargerType: chargerType ?? '',
              optionalCharging: optionalCharging ??
                  OptionalDetailForm(
                      optionalType: '', optionalValue: 0, optionalUnit: ''),
              carSelect: carSelected == null
                  ? null
                  : CarSelectForm(
                      vehicleNo: carSelected.vehicleNo,
                      currentPercentBattery: carSelected.currentPercentBattery,
                      batteryCapacity: carSelected.batteryCapacity,
                      brand: carSelected.brand,
                      image: carSelected.image,
                      licensePlate: carSelected.licensePlate,
                      maximumChargingPowerAc:
                          carSelected.maximumChargingPowerAc,
                      maximumChargingPowerDc:
                          carSelected.maximumChargingPowerDc,
                      model: carSelected.model,
                      province: carSelected.province,
                      maxDistance: carSelected.maxDistance,
                    ),
              paymentType: PaymentTypeForm(
                brand: paymentSelected.brand,
                display: paymentSelected.display,
                token: paymentSelected.token,
                type: paymentSelected.type,
                name: paymentSelected.name,
              ),
              paymentCoupon: couponSelected));

      result.fold(
        (failure) {
          emit(CheckInCheckStartChargingFailure(failure.message));
        },
        (data) {
          emit(CheckInCheckStartChargingSuccess());
        },
      );
    }, 'StartCharging');
  }

  void fleetStartChargingOperation({
    String? chargerId,
    String? connectorId,
    int? connectorIndex,
    String? chargingType,
    String? chargerType,
    OptionalDetailForm? optionalCharging,
    String? qrCode,
    required String orgCode,
    required CarSelectForm carSelected,
    required PaymentTypeForm paymentSelected,
    required ChargerInformationEntity data,
    required PaymentCouponForm? couponSelected,
    required int fleetNo,
    required String fleetType,
  }) async {
    emit(CheckInCheckStartChargingLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.remoteStartFleetOperation(
        accessToken,
        RemoteStartFleetForm(
          username: username,
          orgCode: orgCode,
          qrCodeConnector: qrCode ?? '',
          chargerId: chargerId ?? '',
          connectorId: connectorId ?? '',
          connectorIndex: connectorIndex ?? 0,
          deviceCode: deviceCode,
          chargingType: chargingType ?? '',
          chargerType: chargerType ?? '',
          fleetNo: fleetNo,
          fleetType: fleetType,
          optionalCharging: optionalCharging ??
              OptionalDetailForm(
                  optionalType: '', optionalValue: 0, optionalUnit: ''),
          carSelect: CarSelectForm(
              vehicleNo: carSelected.vehicleNo,
              currentPercentBattery: carSelected.currentPercentBattery,
              batteryCapacity: carSelected.batteryCapacity,
              brand: carSelected.brand,
              image: carSelected.image,
              licensePlate: carSelected.licensePlate,
              maximumChargingPowerAc: carSelected.maximumChargingPowerAc,
              maximumChargingPowerDc: carSelected.maximumChargingPowerDc,
              model: carSelected.model,
              province: carSelected.province,
              maxDistance: carSelected.maxDistance),
          paymentType: PaymentTypeForm(
            brand: paymentSelected.brand,
            display: paymentSelected.display,
            token: paymentSelected.token,
            type: paymentSelected.type,
            name: paymentSelected.name,
          ),
          paymentCoupon: couponSelected,
        ),
      );
      result.fold(
        (failure) {
          emit(CheckInCheckStartChargingFailure(failure.message));
        },
        (data) {
          emit(CheckInCheckStartChargingSuccess());
        },
      );
    }, 'FleetStartChargingOperation');
  }

  void fleetStartChargingCard({
    String? chargerId,
    String? connectorId,
    int? connectorIndex,
    String? chargingType,
    String? chargerType,
    OptionalDetailForm? optionalCharging,
    String? qrCode,
    required String orgCode,
    required CarSelectForm carSelected,
    required PaymentTypeForm paymentSelected,
    required ChargerInformationEntity data,
    required PaymentCouponForm? couponSelected,
    required int fleetNo,
    required String fleetType,
  }) async {
    emit(CheckInCheckStartChargingLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.remoteStartFleetCard(
        accessToken,
        RemoteStartFleetForm(
          username: username,
          orgCode: orgCode,
          qrCodeConnector: qrCode ?? '',
          chargerId: chargerId ?? '',
          connectorId: connectorId ?? '',
          connectorIndex: connectorIndex ?? 0,
          deviceCode: deviceCode,
          chargingType: chargingType ?? '',
          chargerType: chargerType ?? '',
          fleetNo: fleetNo,
          fleetType: fleetType,
          optionalCharging: optionalCharging ??
              OptionalDetailForm(
                  optionalType: '', optionalValue: 0, optionalUnit: ''),
          carSelect: CarSelectForm(
              vehicleNo: carSelected.vehicleNo,
              currentPercentBattery: carSelected.currentPercentBattery,
              batteryCapacity: carSelected.batteryCapacity,
              brand: carSelected.brand,
              image: carSelected.image,
              licensePlate: carSelected.licensePlate,
              maximumChargingPowerAc: carSelected.maximumChargingPowerAc,
              maximumChargingPowerDc: carSelected.maximumChargingPowerDc,
              model: carSelected.model,
              province: carSelected.province,
              maxDistance: carSelected.maxDistance),
          paymentType: PaymentTypeForm(
            brand: paymentSelected.brand,
            display: paymentSelected.display,
            token: paymentSelected.token,
            type: paymentSelected.type,
            name: paymentSelected.name,
          ),
          paymentCoupon: couponSelected,
        ),
      );
      result.fold(
        (failure) {
          emit(CheckInCheckStartChargingFailure(failure.message));
        },
        (data) {
          emit(CheckInCheckStartChargingSuccess());
        },
      );
    }, 'FleetStartChargingCard');
  }

  void loadCouponSearch() async {
    emit(CouponSearchLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.searchCouponCheckinPage(accessToken,
          SearchCouponForm(username: username), ConstValue.orgCode);

      result.fold(
        (failure) {
          emit(CouponSearchFailure());
        },
        (data) {
          emit(CouponSearchSuccess(data));
        },
      );
    }, 'CouponSearch');
  }

  void collectCoupon({
    required String couponCode,
  }) async {
    emit(CollectCouponLoading());

    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.collectCoupon(
        accessToken,
        CollectCouponForm(username: username, couponCode: couponCode),
        ConstValue.orgCode,
      );

      result.fold(
        (failure) {
          emit(CollectCouponFailure(failure.message));
        },
        (data) {
          emit(CollectCouponSuccess(data));
        },
      );
    }, 'collectCoupon');
  }

  void loadScanQrcodeCoupon({String couponCode = ''}) async {
    emit(ScanQrcodeCouponLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.scanQrcodeCouponCheckinPage(
          accessToken,
          CouponInformationForm(username: username, couponCode: couponCode),
          ConstValue.orgCode);

      result.fold(
        (failure) {
          emit(ScanQrcodeCouponFailure());
        },
        (data) {
          emit(ScanQrcodeCouponSuccess(data));
        },
      );
    }, 'ScanQrcodeCouponSearch');
  }

  void fetchCheckInFleetOperation(String qrCode, int fleetNo) async {
    emit(CheckInLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.checkInFleetOperation(
          accessToken,
          CheckInFleetForm(
            username: username,
            qrCodeConnector: qrCode,
            deviceCode: deviceCode,
            fleetNo: fleetNo,
            orgCode: ConstValue.orgCode,
          ));

      result.fold(
        (failure) {
          emit(CheckInFailure(failure.message));
        },
        (data) {
          emit(CheckInSuccess(data, accessToken));
        },
      );
    }, 'CheckInFleetOperation');
  }

  void fetchCheckInFleetCard(String qrCode, int fleetNo) async {
    emit(CheckInLoading());
    Utilities.requestAccessToken(_useCase, (
        {required accessToken, required deviceCode, required username}) async {
      final result = await _useCase.checkInFleetCard(
          accessToken,
          CheckInFleetForm(
            username: username,
            qrCodeConnector: qrCode,
            deviceCode: deviceCode,
            fleetNo: fleetNo,
            orgCode: ConstValue.orgCode,
          ));

      result.fold(
        (failure) {
          emit(CheckInFailure(failure.message));
        },
        (data) {
          emit(CheckInSuccess(data, accessToken));
        },
      );
    }, 'CheckInFleetCard');
  }

  void fetchResetCubitToInital() {
    emit(CheckInInitial());
  }
}
