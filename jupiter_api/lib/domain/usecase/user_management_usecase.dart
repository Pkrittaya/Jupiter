import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jupiter_api/data/data_models/request/add_ev_car_charging_form.dart';
import 'package:jupiter_api/data/data_models/request/add_favorite_route_form.dart';
import 'package:jupiter_api/data/data_models/request/delete_favotite_route_form.dart';
import 'package:jupiter_api/data/data_models/request/fleet_charger_form.dart';
import 'package:jupiter_api/data/data_models/request/history_fleet_card_form.dart';
import 'package:jupiter_api/data/data_models/request/log_crash_form.dart';
import 'package:jupiter_api/data/data_models/request/object_empty_form.dart';
import 'package:jupiter_api/data/data_models/request/route_planning_form.dart';
import 'package:jupiter_api/data/data_models/request/set_notification_setting_form.dart';
import 'package:jupiter_api/data/data_models/request/update_fovorite_route_form.dart';
import 'package:jupiter_api/data/data_models/request/verify_email_form.dart';
import 'package:jupiter_api/data/data_models/response/list_car_select_fleet_model.dart';
import 'package:jupiter_api/domain/entities/favorite_route_item_entity.dart';
import 'package:jupiter_api/domain/entities/get_count_all_notification_entity.dart';
import 'package:jupiter_api/domain/entities/llst_charger_fleet_card_entity.dart';
import 'package:jupiter_api/domain/entities/llst_charger_fleet_operation_entity.dart';
import 'package:jupiter_api/domain/entities/notification_news.dart';
import 'package:jupiter_api/domain/entities/notification_setting_entity.dart';
import 'package:jupiter_api/domain/entities/route_planning_entity.dart';
import 'package:jupiter_api/domain/entities/verify_image_ocr_entity.dart';
import '../../data/data_models/request/active_notification_form.dart';
import '../../data/data_models/request/add_ev_car_form.dart';
import '../../data/data_models/request/add_tax_invoice_form.dart';
import '../../data/data_models/request/change_password_form.dart';
import '../../data/data_models/request/charger_information_form.dart';
import '../../data/data_models/request/check_in_fleet_form.dart';
import '../../data/data_models/request/check_status_fleet_form.dart';
import '../../data/data_models/request/collect_coupon.dart';
import '../../data/data_models/request/confirm_transaction_fleet_form.dart';
import '../../data/data_models/request/coupon_information_form.dart';
import '../../data/data_models/request/coupon_list_form.dart';
import '../../data/data_models/request/create_reserve_form.dart';
import '../../data/data_models/request/delete_account_form.dart';
import '../../data/data_models/request/delete_card_payment_form.dart';
import '../../data/data_models/request/delete_ev_car_form.dart';
import '../../data/data_models/request/delete_ev_car_image_form.dart';
import '../../data/data_models/request/delete_notification_form.dart';
import '../../data/data_models/request/delete_tax_invoice_form.dart';
import '../../data/data_models/request/edit_ev_car_form.dart';
import '../../data/data_models/request/favorite_station_form.dart';
import '../../data/data_models/request/finding_station_form.dart';
import '../../data/data_models/request/fleet_detail_card_form.dart';
import '../../data/data_models/request/fleet_no_form.dart';
import '../../data/data_models/request/get_list_reserve_form.dart';
import '../../data/data_models/request/history_booking_detail_form.dart';
import '../../data/data_models/request/history_booking_list_form.dart';
import '../../data/data_models/request/history_detail_form.dart';
import '../../data/data_models/request/history_list_form.dart';
import '../../data/data_models/request/list_payment_form.dart';
import '../../data/data_models/request/manage_charger_form.dart';
import '../../data/data_models/request/payment_charging_form.dart';
import '../../data/data_models/request/profile_form.dart';
import '../../data/data_models/request/recommended_station_form.dart';
import '../../data/data_models/request/remote_start_fleet_form.dart';
import '../../data/data_models/request/remote_stop_fleet_form.dart';
import '../../data/data_models/request/request_access_key_form.dart';
import '../../data/data_models/request/request_otp_forgot_pin_form.dart';
import '../../data/data_models/request/search_coupon_form.dart';
import '../../data/data_models/request/send_email_forgot_password_form.dart';
import '../../data/data_models/request/set_default_card_form.dart';
import '../../data/data_models/request/set_language_form.dart';
import '../../data/data_models/request/signin_account_form.dart';
import '../../data/data_models/request/signout_account_form.dart';
import '../../data/data_models/request/signup_account_form.dart';
import '../../data/data_models/request/start_charger_form.dart';
import '../../data/data_models/request/station_detail_form.dart';
import '../../data/data_models/request/station_form.dart';
import '../../data/data_models/request/status_charger_form.dart';
import '../../data/data_models/request/update_current_battery_form.dart';
import '../../data/data_models/request/update_favorite_station_form.dart';
import '../../data/data_models/request/update_select_payment_form.dart';
import '../../data/data_models/request/username_and_orgcode_form.dart';
import '../../data/data_models/request/verify_account_form.dart';
import '../../data/data_models/request/verify_card_form.dart';
import '../../data/data_models/request/verify_fleet_card_form.dart';
import '../../data/data_models/request/verify_otp_forgot_pin_form.dart';
import '../../data/data_sources/helper/failure.dart';
import '../entities/advertisement_entity.dart';
import '../entities/car_entity.dart';
import '../entities/car_master_entity.dart';
import '../entities/charger_information_entity.dart';
import '../entities/check_status_entity.dart';
import '../entities/collect_coupon_entity.dart';
import '../entities/connector_type_entity.dart';
import '../entities/coupon_detail_entity.dart';
import '../entities/coupon_entity.dart';
import '../entities/credit_card_entity.dart';
import '../entities/default_entity.dart';
import '../entities/favorite_station_entity.dart';
import '../entities/finding_station_entity.dart';
import '../entities/fleet_card_info_entity.dart';
import '../entities/fleet_card_item_entity.dart';
import '../entities/fleet_operation_info_entity.dart';
import '../entities/fleet_operation_item_entity.dart';
import '../entities/get_list_reserve_entity.dart';
import '../entities/has_charging_fleet_card_entity.dart';
import '../entities/history_booking_detail_entity.dart';
import '../entities/history_booking_list_entity.dart';
import '../entities/history_detail_entity.dart';
import '../entities/history_entity.dart';
import '../entities/history_fleet_entity.dart';
import '../entities/list_billing_entity.dart';
import '../entities/list_data_permission_entity.dart';
import '../entities/list_notification_entity.dart';
import '../entities/llst_station_fleet_card_entity.dart';
import '../entities/llst_station_fleet_operation_entity.dart';
import '../entities/profile_entity.dart';
import '../entities/recommended_station_entity.dart';
import '../entities/request_access_key_entity.dart';
import '../entities/request_otp_forgot_pin_entity.dart';
import '../entities/reserve_receipt_entity.dart';
import '../entities/search_coupon_entity.dart';
import '../entities/search_coupon_for_used_entity.dart';
import '../entities/sign_in_entity.dart';
import '../entities/sign_up_entity.dart';
import '../entities/station_details_entity.dart';
import '../entities/station_entity.dart';
import '../entities/term_and_condition_entity.dart';
import '../entities/verify_account_entity.dart';
import '../entities/verify_card_entity.dart';
import '../repositories/user_management_repository.dart';

@LazySingleton()
class UserManagementUseCase {
  @FactoryMethod()
  final UserManagementRepository repo;

  UserManagementUseCase(this.repo);

  Future<Either<Failure, VerifyAccountEntity>> verifyAccount(
      VerifyAccountForm verifyAccountForm) {
    return repo.verifyAccount(verifyAccountForm);
  }

  Future<Either<Failure, dynamic>> sendEmailForgotPassword(
      SendEmailForgotPasswordForm sendEmailForgotPasswordForm) {
    return repo.sendEmailForgotPassword(sendEmailForgotPasswordForm);
  }

  Future<Either<Failure, TermAndConditionEntity>> termAndCondition(
      String orgCode) {
    return repo.registerConsent(orgCode);
  }

  Future<Either<Failure, SignUpEntity>> signUp(
      SignupAccountForm signupAccountForm) {
    return repo.signUp(signupAccountForm);
  }

  Future<Either<Failure, SignInEntity>> signIn(
      SignInAccountForm signInAccountForm) {
    return repo.signIn(signInAccountForm);
  }

  Future<Either<Failure, DefaultEntity>> signOut(
      SignOutAccountForm signOutAccountForm) {
    return repo.signOut(signOutAccountForm);
  }

  Future<Either<Failure, RequestAccessKeyEntity>> requestAccessToken(
      RequestAccessKeyForm requestAccessKeyForm) {
    return repo.requestAccessToken(requestAccessKeyForm);
  }

  Future<Either<Failure, List<StationEntity>>> listAllMarkerStations(
      String accessToken, StationForm StationForm) {
    return repo.listAllMarkerStation(accessToken, StationForm);
  }

  Future<Either<Failure, StationDetailEntity>> stationDetail(
      String accessToken, StationDetailForm stationDetailForm) {
    return repo.stationDetail(accessToken, stationDetailForm);
  }

  Future<Either<Failure, FindingStationEntity>> findingStation(
      String accessToken, FindingStationForm findingStationForm) {
    return repo.findingStation(accessToken, findingStationForm);
  }

  Future<Either<Failure, FavoriteStationEntity>> favoriteStation(
      String accessToken, FavoriteStationForm favoriteStationForm) {
    return repo.favoriteStation(accessToken, favoriteStationForm);
  }

  Future<Either<Failure, dynamic>> updateFavoriteStation(
      String accessToken, UpdateFavoriteStationForm updatefavoriteStationForm) {
    return repo.updateFavoriteStation(accessToken, updatefavoriteStationForm);
  }

  Future<Either<Failure, AdvertisementEntity>> advertisement(
      String accessToken, UsernameAndOrgCodeForm advertisementForm) {
    return repo.advertisement(accessToken, advertisementForm);
  }

  Future<Either<Failure, ChargerInformationEntity>> chargerInformation(
      String accessToken, ChargerInformationForm chargerInformationForm) {
    return repo.chargerInformation(accessToken, chargerInformationForm);
  }

  Future<Either<Failure, dynamic>> listPayment(
      String accessToken, ListPaymentForm listPaymentForm) {
    return repo.listPayment(accessToken, listPaymentForm);
  }

  Future<Either<Failure, dynamic>> updateSelectPayment(
      String accessToken, UpdateSelectPaymentForm updateSelectPaymentForm) {
    return repo.updateSelectPayment(accessToken, updateSelectPaymentForm);
  }

  Future<Either<Failure, dynamic>> paymentCharging(
      String accessToken, PaymentChargingForm paymentChargingForm) {
    return repo.paymentCharging(accessToken, paymentChargingForm);
  }

  Future<Either<Failure, dynamic>> updateCurrentBattery(
      String accessToken, UpdateCurrentBatteryForm updateCurrentBatteryForm) {
    return repo.updateCurrentBattery(accessToken, updateCurrentBatteryForm);
  }

  Future<Either<Failure, List<ConnectorTypeEntity>>> filterMapType(
      String accessToken) {
    return repo.filterMapType(accessToken);
  }

  Future<Either<Failure, DefaultEntity>> startCharging(
      String accessToken, StartChargerForm startChargerForm) {
    return repo.startCharging(accessToken, startChargerForm);
  }

  Future<Either<Failure, DefaultEntity>> stopCharging(
      String accessToken, ManageChargerForm manageChargerForm) {
    return repo.stopCharging(accessToken, manageChargerForm);
  }

  Future<Either<Failure, DefaultEntity>> confirmCharging(
      String accessToken, ManageChargerForm manageChargerForm) {
    return repo.confirmCharging(accessToken, manageChargerForm);
  }

  Future<Either<Failure, CheckStatusEntity>> statusCharging(
      String accessToken, StatusChargerForm statusChargerForm) {
    return repo.statusCharing(accessToken, statusChargerForm);
  }

  Future<Either<Failure, ProfileEntity>> profile(
      String accessToken, UsernameAndOrgCodeForm usernameAndOrgCodeForm) {
    return repo.profile(accessToken, usernameAndOrgCodeForm);
  }

  Future<Either<Failure, DefaultEntity>> updateProfile(
      String accessToken, ProfileForm profileForm) {
    return repo.updateProfile(accessToken, profileForm);
  }

  Future<Either<Failure, DefaultEntity>> updateProfilePicture(
      String accessToken, File file, String payload) {
    return repo.updateProfilePicture(accessToken, file, payload);
  }

  Future<Either<Failure, List<CreditCardEntity>>> creditCardList(
      String accessToken, UsernameAndOrgCodeForm usernameAndOrgCodeForm) {
    return repo.creditCardList(accessToken, usernameAndOrgCodeForm);
  }

  Future<Either<Failure, List<CarEntity>>> carList(
      String accessToken, UsernameAndOrgCodeForm usernameAndOrgCodeForm) {
    return repo.carList(accessToken, usernameAndOrgCodeForm);
  }

  Future<Either<Failure, List<CarMasterEntity>>> carMaster(
      String accessToken, String orgCode) {
    return repo.carMaster(accessToken, orgCode);
  }

  Future<Either<Failure, VerifyCardEntity>> verifyCard(
      String accessToken, VerifyCardForm verifyCardForm) {
    return repo.verifyCard(accessToken, verifyCardForm);
  }

  Future<Either<Failure, DefaultEntity>> addCar(
      String accessToken, AddEvCarForm addEvCarForm) {
    return repo.addCar(accessToken, addEvCarForm);
  }

  Future<Either<Failure, DefaultEntity>> deleteCar(
      String accessToken, DeleteEvCarForm deleteEvCarForm) {
    return repo.deleteCar(accessToken, deleteEvCarForm);
  }

  Future<Either<Failure, DefaultEntity>> addCarImage(
      String accessToken, String brand, String model, File file) {
    return repo.addCarImage(accessToken, brand, model, file);
  }

  Future<Either<Failure, DefaultEntity>> deleteCarImage(
      String accessToken, DeleteEvCarImageForm form) {
    return repo.deleteCarImage(accessToken, form);
  }

  Future<Either<Failure, HistoryEntity>> getHistoryList(
      String accessToken, HistoryListForm form) {
    return repo.getHistoryList(accessToken, form);
  }

  Future<Either<Failure, HistoryBookingListEntity>> getHistoryBookingList(
      String accessToken, HistoryBookingListForm historyBookingListForm) {
    return repo.getHistoryBookingList(accessToken, historyBookingListForm);
  }

  Future<Either<Failure, HistoryDetailEntity>> getHistoryDetail(
      String accessToken, HistoryDetailForm form) {
    return repo.getHistoryDetail(accessToken, form);
  }

  Future<Either<Failure, HistoryBookingDetailEntity>> getHistoryBookingDetail(
      String accessToken, HistoryBookingDetailForm historyBookingDetailForm) {
    return repo.getHistoryBookingDetail(accessToken, historyBookingDetailForm);
  }

  Future<Either<Failure, DefaultEntity>> editCar(
      String accessToken, EditEvCarForm editEvCarForm) {
    return repo.editCar(accessToken, editEvCarForm);
  }

  Future<Either<Failure, DefaultEntity>> addTaxInvoice(
      String accessToken, AddTaxInvoiceForm addTaxInvoiceForm) {
    return repo.addTaxInvoice(accessToken, addTaxInvoiceForm);
  }

  Future<Either<Failure, DefaultEntity>> updateTaxInvoice(
      String accessToken, AddTaxInvoiceForm updateTaxInvoiceeForm) {
    return repo.updateTaxInvoice(accessToken, updateTaxInvoiceeForm);
  }

  Future<Either<Failure, ListBillingEntity>> getTaxInvoice(
      String accessToken, UsernameAndOrgCodeForm usernameAndOrgCodeForm) {
    return repo.getTaxInvoice(accessToken, usernameAndOrgCodeForm);
  }

  Future<Either<Failure, DefaultEntity>> deleteTaxInvoice(
      String accessToken, DeleteTaxInvoiceForm deleteTaxInvoiceForm) {
    return repo.deleteTaxInvoice(accessToken, deleteTaxInvoiceForm);
  }

  Future<Either<Failure, DefaultEntity>> setDefaultCard(
      String accessToken, SetDefaultCardForm setDefaultCardForm) {
    return repo.setDefaultCard(accessToken, setDefaultCardForm);
  }

  Future<Either<Failure, DefaultEntity>> deletePaymentCard(
      String accessToken, DeleteCardPaymentForm deleteCardPaymentForm) {
    return repo.deletePaymentCard(accessToken, deleteCardPaymentForm);
  }

  Future<Either<Failure, RequestOtpForgotPinEntity>> requestOtpForgotPin(
      RequestOtpForgotPinForm requestOtpForgotPinForm) {
    return repo.requestOtpForgotPin(requestOtpForgotPinForm);
  }

  Future<Either<Failure, DefaultEntity>> verifyOtpForgotPin(
      VerifyOtpForgotPinForm verifyOtpForgotPinForm) {
    return repo.verifyOtpForgotPin(verifyOtpForgotPinForm);
  }

  Future<Either<Failure, List<CouponItemEntity>>> listMyCoupon(
      String accessToken, CouponListForm couponList, String orgCode) {
    return repo.listMyCoupon(accessToken, couponList, orgCode);
  }

  Future<Either<Failure, List<CouponItemEntity>>> listUsedCoupon(
      String accessToken, CouponListForm couponList, String orgCode) {
    return repo.listUsedCoupon(accessToken, couponList, orgCode);
  }

  Future<Either<Failure, CouponDetailEntity>> couponDetail(
      String accessToken, CouponInformationForm couponDetail, orgCode) {
    return repo.couponDetail(accessToken, couponDetail, orgCode);
  }

  Future<Either<Failure, List<SearchCouponItemEntity>>> searchCoupon(
      String accessToken, SearchCouponForm searchCoupon, String orgCode) {
    return repo.searchCoupon(accessToken, searchCoupon, orgCode);
  }

  Future<Either<Failure, List<SearchCouponItemForUsedEntity>>>
      searchCouponCheckinPage(
          String accessToken, SearchCouponForm searchCoupon, String orgCode) {
    return repo.searchCouponCheckinPage(accessToken, searchCoupon, orgCode);
  }

  Future<Either<Failure, CollectCouponEntity>> collectCoupon(
      String accessToken, CollectCouponForm collectCouponForm, String orgCode) {
    return repo.collectCoupon(accessToken, collectCouponForm, orgCode);
  }

  Future<Either<Failure, SearchCouponItemEntity>> scanQrcodeCoupon(
      String accessToken,
      CouponInformationForm scanQrcodeCoupon,
      String orgCode) {
    return repo.scanQrcodeCoupon(accessToken, scanQrcodeCoupon, orgCode);
  }

  Future<Either<Failure, SearchCouponItemForUsedEntity>>
      scanQrcodeCouponCheckinPage(String accessToken,
          CouponInformationForm scanQrcodeCoupon, String orgCode) {
    return repo.scanQrcodeCouponCheckinPage(
        accessToken, scanQrcodeCoupon, orgCode);
  }

  Future<Either<Failure, GetListReserveEntity>> listReserve(String accessToken,
      GetListReserveForm getListReserveForm, String orgCode) {
    return repo.listReserve(accessToken, getListReserveForm, orgCode);
  }

  Future<Either<Failure, ReserveReceiptEntity>> createReserve(
      String accessToken, CreateReserveForm createReserveForm, String orgCode) {
    return repo.createReserve(accessToken, createReserveForm, orgCode);
  }

  Future<Either<Failure, DefaultEntity>> changePassword(
      String accessToken, ChangePasswordForm changePasswordForm) {
    return repo.changePassword(accessToken, changePasswordForm);
  }

  Future<Either<Failure, DefaultEntity>> deleteAccount(
      String accessToken, DeleteAccountForm deleteAccountForm) {
    return repo.deleteAccount(accessToken, deleteAccountForm);
  }

  Future<Either<Failure, ListDataPermissionEntity>> permissionFleet(
      String accessToken) {
    return repo.permissionFleet(accessToken);
  }

  Future<Either<Failure, List<FleetCardItemEntity>>> listFleetCard(
      String accessToken, String orgCode) {
    return repo.listFleetCard(accessToken, orgCode);
  }

  Future<Either<Failure, List<FleetOperationItemEntity>>> listFleetOperation(
      String accessToken, String orgCode) {
    return repo.listFleetOperation(accessToken, orgCode);
  }

  Future<Either<Failure, FleetCardInfoEntity>> fleetCardInfo(String accessToken,
      FleetDetailCardForm fleetDetailCardForm, String orgCode) {
    return repo.fleetCardInfo(accessToken, fleetDetailCardForm, orgCode);
  }

  Future<Either<Failure, FleetOperationInfoEntity>> fleetOperationInfo(
      String accessToken, FleetNoForm fleetNoForm, String orgCode) {
    return repo.fleetOperationInfo(accessToken, fleetNoForm, orgCode);
  }

  Future<Either<Failure, ListStationFleetCardEntity>> fleetCardStation(
      String accessToken, FleetNoForm fleetNoForm, String orgCode) {
    return repo.fleetCardStation(accessToken, fleetNoForm, orgCode);
  }

  Future<Either<Failure, ListStationFleetOperationEntity>>
      fleetOperationStation(
          String accessToken, FleetNoForm fleetNoForm, String orgCode) {
    return repo.fleetOperationStation(accessToken, fleetNoForm, orgCode);
  }

  Future<Either<Failure, ListChargerFleetCardEntity>> fleetCardCharger(
      String accessToken, FleetChargerForm fleetChargerForm, String orgCode) {
    return repo.fleetCardCharger(accessToken, fleetChargerForm, orgCode);
  }

  Future<Either<Failure, ListChargerFleetOperationEntity>>
      fleetOperationCharger(String accessToken,
          FleetChargerForm fleetChargerForm, String orgCode) {
    return repo.fleetOperationCharger(accessToken, fleetChargerForm, orgCode);
  }

  Future<Either<Failure, ChargerInformationEntity>> checkInFleetOperation(
      String accessToken, CheckInFleetForm checkInFleetForm) {
    return repo.checkInFleetOperation(accessToken, checkInFleetForm);
  }

  Future<Either<Failure, DefaultEntity>> remoteStartFleetOperation(
      String accessToken, RemoteStartFleetForm remoteStartFleetForm) {
    return repo.remoteStartFleetOperation(accessToken, remoteStartFleetForm);
  }

  Future<Either<Failure, CheckStatusEntity>> checkStatusFleetOperation(
      String accessToken, CheckStatusFleetForm checkStatusFleetForm) {
    return repo.checkStatusFleetOperation(accessToken, checkStatusFleetForm);
  }

  Future<Either<Failure, DefaultEntity>> remoteStopFleetOperation(
      String accessToken, RemoteStopFleetForm remoteStopFleetForm) {
    return repo.remoteStopFleetOperation(accessToken, remoteStopFleetForm);
  }

  Future<Either<Failure, DefaultEntity>> confirmTransactionFleetOperation(
      String accessToken,
      ConfirmTransactionFleetForm confirmTransactionFleetForm) {
    return repo.confirmTransactionFleetOperation(
        accessToken, confirmTransactionFleetForm);
  }

  Future<Either<Failure, ChargerInformationEntity>> checkInFleetCard(
      String accessToken, CheckInFleetForm checkInFleetForm) {
    return repo.checkInFleetCard(accessToken, checkInFleetForm);
  }

  Future<Either<Failure, DefaultEntity>> remoteStartFleetCard(
      String accessToken, RemoteStartFleetForm remoteStartFleetForm) {
    return repo.remoteStartFleetCard(accessToken, remoteStartFleetForm);
  }

  Future<Either<Failure, CheckStatusEntity>> checkStatusFleetCard(
      String accessToken, CheckStatusFleetForm checkStatusFleetForm) {
    return repo.checkStatusFleetCard(accessToken, checkStatusFleetForm);
  }

  Future<Either<Failure, DefaultEntity>> remoteStopFleetCard(
      String accessToken, RemoteStopFleetForm remoteStopFleetForm) {
    return repo.remoteStopFleetCard(accessToken, remoteStopFleetForm);
  }

  Future<Either<Failure, DefaultEntity>> confirmTransactionFleetCard(
      String accessToken,
      ConfirmTransactionFleetForm confirmTransactionFleetForm) {
    return repo.confirmTransactionFleetCard(
        accessToken, confirmTransactionFleetForm);
  }

  Future<Either<Failure, ListNotificationEntity>> listNotification(
      String accessToken) {
    return repo.listNotification(accessToken);
  }

  Future<Either<Failure, NotificationNewsEntity>> listNotificationNews(
      String accessToken, ObjectEmptyForm objectEmpty) {
    return repo.listNotificationNews(accessToken, objectEmpty);
  }

  Future<Either<Failure, DefaultEntity>> deleteNotification(
      String accessToken, DeleteNotificationForm deleteNotification) {
    return repo.deleteNotification(accessToken, deleteNotification);
  }

  Future<Either<Failure, DefaultEntity>> activeNotification(
      String accessToken, ActiveNotificationForm activeNotification) {
    return repo.activeNotification(accessToken, activeNotification);
  }

  Future<Either<Failure, DefaultEntity>> setNotificationSetting(
      String accessToken, SetNotificationSettingForm setNotificationSetting) {
    return repo.setNotificationSetting(accessToken, setNotificationSetting);
  }

  Future<Either<Failure, NotificationSettingEntity>> getNotificationSetting(
      String accessToken, ObjectEmptyForm objectEmpty) {
    return repo.getNotificationSetting(accessToken, objectEmpty);
  }

  Future<Either<Failure, CountAllNotificationEntity>> getCountAllNotification(
      String accessToken, ObjectEmptyForm objectEmpty) {
    return repo.getCountAllNotification(accessToken, objectEmpty);
  }

  Future<Either<Failure, HasChargingFleetEntity>> checkHasChargingFleetCard(
      String accessToken) {
    return repo.checkHasChargingFleetCard(accessToken);
  }

  Future<Either<Failure, HasChargingFleetEntity>>
      checkHasChargingFleetOperation(String accessToken) {
    return repo.checkHasChargingFleetOperation(accessToken);
  }

  Future<Either<Failure, List<HistoryFleetDataEntity>>> getHistoryFleetCardList(
      String accessToken,
      String orgCode,
      HistoryFleetCardForm historyFleetCardForm) {
    return repo.getHistoryFleetCardList(
        accessToken, orgCode, historyFleetCardForm);
  }

  Future<Either<Failure, List<HistoryFleetDataEntity>>>
      getHistoryFleetOperationList(
          String accessToken, int fleetNo, String orgCode) {
    return repo.getHistoryFleetOperationList(accessToken, fleetNo, orgCode);
  }

  Future<Either<Failure, DefaultEntity>> verifyFleetCard(String accessToken,
      VerifyFleetCardForm verifyFleetCardForm, String orgCode) {
    return repo.verifyFleetCard(accessToken, verifyFleetCardForm, orgCode);
  }

  Future<Either<Failure, List<RecommendedStationEntity>>> recommendedStation(
      String accessToken, RecommendedStationForm recommendedStationForm) {
    return repo.recommendedStation(accessToken, recommendedStationForm);
  }

  Future<Either<Failure, DefaultEntity>> verifyEmail(
      VerifyEmailForm verifyEmailForm) {
    return repo.verifyEmail(verifyEmailForm);
  }

  Future<Either<Failure, DefaultEntity>> setLanguage(
      String accessToken, SetLanguageForm setLanguageFrom) {
    return repo.setLanguage(accessToken, setLanguageFrom);
  }

  Future<Either<Failure, VerifyImageOcrEntity>> verifyImageOcr(
      String accessToken, File file, String licensePlate) {
    return repo.verifyImageOcr(accessToken, file, licensePlate);
  }

  Future<Either<Failure, ListCarSelectFleetModel>>
      listVehicleChargingFleetOperation(
          String accessToken, String orgCode, FleetNoForm fleetNoForm) {
    return repo.listVehicleChargingFleetOperation(
        accessToken, orgCode, fleetNoForm);
  }

  Future<Either<Failure, DefaultEntity>> addVehicleChargingFleetOperation(
      String accessToken,
      String orgCode,
      AddCarChargingForm addCarChargingForm) {
    return repo.addVehicleChargingFleetOperation(
        accessToken, orgCode, addCarChargingForm);
  }

  Future<Either<Failure, RoutePlanningEntity>> getRoutePlanning(
      String accessToken, RoutePlanningForm routePlanningForm) {
    return repo.getRoutePlanning(accessToken, routePlanningForm);
  }

  Future<Either<Failure, List<FavoriteRouteItemEntity>>> favoriteRoute(
      String accessToken, UsernameAndOrgCodeForm usernameAndOrgCodeForm) {
    return repo.favoriteRoute(accessToken, usernameAndOrgCodeForm);
  }

  Future<Either<Failure, DefaultEntity>> addFavoriteRoute(
      String accessToken, AddFavoriteRouteForm addFavoriteRouteForm) {
    return repo.addFavoriteRoute(accessToken, addFavoriteRouteForm);
  }

  Future<Either<Failure, DefaultEntity>> updateFavoriteRoute(
      String accessToken, UpdateFavoriteRouteForm updateFavoriteRouteForm) {
    return repo.updateFavoriteRoute(accessToken, updateFavoriteRouteForm);
  }

  Future<Either<Failure, DefaultEntity>> deleteFavoriteRoute(
      String accessToken, DeleteFavoriteRouteForm deleteFavoriteRouteForm) {
    return repo.deleteFavoriteRoute(accessToken, deleteFavoriteRouteForm);
  }

  Future<Either<Failure, DefaultEntity>> addLog(LogCrashForm logCrashForm) {
    return repo.addLog(logCrashForm);
  }
}
