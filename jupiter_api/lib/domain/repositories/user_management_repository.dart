import 'dart:io';
import 'package:dartz/dartz.dart';
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
import '../../data/data_models/request/only_org_form.dart';
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

abstract class UserManagementRepository {
  Future<Either<Failure, VerifyAccountEntity>> verifyAccount(
      VerifyAccountForm verifyAccountForm);

  Future<Either<Failure, TermAndConditionEntity>> registerConsent(
      String orgCode);

  Future<Either<Failure, dynamic>> sendEmailForgotPassword(
      SendEmailForgotPasswordForm sendEmailForgotPasswordForm);

  Future<Either<Failure, SignUpEntity>> signUp(
      SignupAccountForm signupAccountForm);

  Future<Either<Failure, SignInEntity>> signIn(
      SignInAccountForm signInAccountForm);

  Future<Either<Failure, DefaultEntity>> signOut(
      SignOutAccountForm signOutAccountForm);

  Future<Either<Failure, RequestAccessKeyEntity>> requestAccessToken(
      RequestAccessKeyForm requestAccessKeyForm);
  Future<Either<Failure, List<StationEntity>>> listAllMarkerStation(
      String accessToken, OnlyOrgForm onlyOrgForm);

  Future<Either<Failure, StationDetailEntity>> stationDetail(
      String accessToken, StationDetailForm stationDetailForm);

  Future<Either<Failure, FindingStationEntity>> findingStation(
      String accessToken, FindingStationForm findingStationForm);

  Future<Either<Failure, FavoriteStationEntity>> favoriteStation(
      String accessToken, FavoriteStationForm favoriteStationForm);

  Future<Either<Failure, dynamic>> updateFavoriteStation(
      String accessToken, UpdateFavoriteStationForm updatefavoriteStationForm);

  Future<Either<Failure, AdvertisementEntity>> advertisement(
      String accessToken, UsernameAndOrgCodeForm advertisementForm);

  Future<Either<Failure, ChargerInformationEntity>> chargerInformation(
      String accessToken, ChargerInformationForm chargerInformationForm);

  Future<Either<Failure, dynamic>> listPayment(
      String accessToken, ListPaymentForm listPaymentForm);

  Future<Either<Failure, dynamic>> updateSelectPayment(
      String accessToken, UpdateSelectPaymentForm updateSelectPaymentForm);

  Future<Either<Failure, dynamic>> paymentCharging(
      String accessToken, PaymentChargingForm paymentChargingForm);

  Future<Either<Failure, dynamic>> updateCurrentBattery(
      String accessToken, UpdateCurrentBatteryForm updateCurrentBatteryForm);

  Future<Either<Failure, List<ConnectorTypeEntity>>> filterMapType(
      String accessToken);

  Future<Either<Failure, DefaultEntity>> startCharging(
      String accessToken, StartChargerForm startChargerForm);

  Future<Either<Failure, DefaultEntity>> stopCharging(
      String accessToken, ManageChargerForm manageChargerForm);

  Future<Either<Failure, CheckStatusEntity>> statusCharing(
      String accessToken, StatusChargerForm statusChargerForm);

  Future<Either<Failure, DefaultEntity>> confirmCharging(
      String accessToken, ManageChargerForm manageChargerForm);

  Future<Either<Failure, ProfileEntity>> profile(
      String accessToken, UsernameAndOrgCodeForm usernameAndOrgCodeForm);

  Future<Either<Failure, DefaultEntity>> updateProfile(
      String accessToken, ProfileForm profileForm);

  Future<Either<Failure, DefaultEntity>> updateProfilePicture(
      String accessToken, File file, String payload);

  Future<Either<Failure, List<CreditCardEntity>>> creditCardList(
      String accessToken, UsernameAndOrgCodeForm usernameAndOrgCodeForm);

  Future<Either<Failure, VerifyCardEntity>> verifyCard(
      String accessToken, VerifyCardForm verifyCardForm);

  Future<Either<Failure, List<CarEntity>>> carList(
      String accessToken, UsernameAndOrgCodeForm usernameAndOrgCodeForm);

  Future<Either<Failure, List<CarMasterEntity>>> carMaster(
      String accessToken, String orgCode);

  Future<Either<Failure, DefaultEntity>> addCar(
      String accessToken, AddEvCarForm addEvCarForm);

  Future<Either<Failure, DefaultEntity>> deleteCar(
      String accessToken, DeleteEvCarForm deleteEvCarForm);

  Future<Either<Failure, DefaultEntity>> addCarImage(
      String accessToken, String brand, String model, File file);

  Future<Either<Failure, DefaultEntity>> deleteCarImage(
      String accessToken, DeleteEvCarImageForm form);

  Future<Either<Failure, HistoryEntity>> getHistoryList(
      String accessToken, HistoryListForm form);

  Future<Either<Failure, HistoryBookingListEntity>> getHistoryBookingList(
      String accessToken, HistoryBookingListForm historyBookingListForm);

  Future<Either<Failure, HistoryDetailEntity>> getHistoryDetail(
      String accessToken, HistoryDetailForm form);

  Future<Either<Failure, HistoryBookingDetailEntity>> getHistoryBookingDetail(
      String accessToken, HistoryBookingDetailForm historyBookingDetailForm);

  Future<Either<Failure, DefaultEntity>> editCar(
      String accessToken, EditEvCarForm editEvCarForm);

  Future<Either<Failure, DefaultEntity>> addTaxInvoice(
      String accessToken, AddTaxInvoiceForm addTaxInvoiceForm);

  Future<Either<Failure, DefaultEntity>> updateTaxInvoice(
      String accessToken, AddTaxInvoiceForm updateTaxInvoiceForm);

  Future<Either<Failure, ListBillingEntity>> getTaxInvoice(
      String accessToken, UsernameAndOrgCodeForm usernameAndOrgCodeForm);

  Future<Either<Failure, DefaultEntity>> deleteTaxInvoice(
      String accessToken, DeleteTaxInvoiceForm deleteTaxInvoiceForm);

  Future<Either<Failure, DefaultEntity>> setDefaultCard(
      String accessToken, SetDefaultCardForm setDefaultCardForm);

  Future<Either<Failure, DefaultEntity>> deletePaymentCard(
      String accessToken, DeleteCardPaymentForm deleteCardPaymentForm);

  Future<Either<Failure, RequestOtpForgotPinEntity>> requestOtpForgotPin(
      RequestOtpForgotPinForm requestOtpForgotPinForm);

  Future<Either<Failure, DefaultEntity>> verifyOtpForgotPin(
      VerifyOtpForgotPinForm verifyOtpForgotPinForm);

  Future<Either<Failure, List<CouponItemEntity>>> listMyCoupon(
      String accessToken, CouponListForm couponList, String orgCode);

  Future<Either<Failure, List<CouponItemEntity>>> listUsedCoupon(
      String accessToken, CouponListForm couponList, String orgCode);

  Future<Either<Failure, CouponDetailEntity>> couponDetail(
      String accessToken, CouponInformationForm couponDetail, String orgCode);

  Future<Either<Failure, List<SearchCouponItemEntity>>> searchCoupon(
      String accessToken, SearchCouponForm searchCoupon, String orgCode);

  Future<Either<Failure, List<SearchCouponItemForUsedEntity>>>
      searchCouponCheckinPage(
          String accessToken, SearchCouponForm searchCoupon, String orgCode);

  Future<Either<Failure, CollectCouponEntity>> collectCoupon(
      String accessToken, CollectCouponForm collectCouponForm, String orgCode);

  Future<Either<Failure, SearchCouponItemEntity>> scanQrcodeCoupon(
      String accessToken,
      CouponInformationForm scanQrcodeCoupon,
      String orgCode);

  Future<Either<Failure, SearchCouponItemForUsedEntity>>
      scanQrcodeCouponCheckinPage(String accessToken,
          CouponInformationForm scanQrcodeCoupon, String orgCode);

  Future<Either<Failure, GetListReserveEntity>> listReserve(String accessToken,
      GetListReserveForm getListReserveForm, String orgCode);

  Future<Either<Failure, ReserveReceiptEntity>> createReserve(
      String accessToken, CreateReserveForm createReserveForm, String orgCode);

  Future<Either<Failure, DefaultEntity>> changePassword(
      String accessToken, ChangePasswordForm changePasswordForm);

  Future<Either<Failure, DefaultEntity>> deleteAccount(
      String accessToken, DeleteAccountForm deleteAccountForm);

  Future<Either<Failure, ListDataPermissionEntity>> permissionFleet(
      String accessToken);

  Future<Either<Failure, List<FleetCardItemEntity>>> listFleetCard(
      String accessToken, String orgCode);

  Future<Either<Failure, List<FleetOperationItemEntity>>> listFleetOperation(
      String accessToken, String orgCode);

  Future<Either<Failure, FleetCardInfoEntity>> fleetCardInfo(String accessToken,
      FleetDetailCardForm fleetDetailCardForm, String orgCode);

  Future<Either<Failure, FleetOperationInfoEntity>> fleetOperationInfo(
      String accessToken, FleetNoForm fleetNoForm, String orgCode);

  Future<Either<Failure, ListStationFleetCardEntity>> fleetCardStation(
      String accessToken, FleetNoForm fleetNoForm, String orgCode);

  Future<Either<Failure, ListStationFleetOperationEntity>>
      fleetOperationStation(
          String accessToken, FleetNoForm fleetNoForm, String orgCode);

  Future<Either<Failure, ListChargerFleetCardEntity>> fleetCardCharger(
      String accessToken, FleetChargerForm fleetChargerForm, String orgCode);

  Future<Either<Failure, ListChargerFleetOperationEntity>>
      fleetOperationCharger(String accessToken,
          FleetChargerForm fleetChargerForm, String orgCode);

  Future<Either<Failure, ChargerInformationEntity>> checkInFleetOperation(
      String accessToken, CheckInFleetForm checkInFleetForm);

  Future<Either<Failure, DefaultEntity>> remoteStartFleetOperation(
      String accessToken, RemoteStartFleetForm remoteStartFleetForm);

  Future<Either<Failure, CheckStatusEntity>> checkStatusFleetOperation(
      String accessToken, CheckStatusFleetForm checkStatusFleetForm);

  Future<Either<Failure, DefaultEntity>> remoteStopFleetOperation(
      String accessToken, RemoteStopFleetForm remoteStopFleetForm);

  Future<Either<Failure, DefaultEntity>> confirmTransactionFleetOperation(
      String accessToken,
      ConfirmTransactionFleetForm confirmTransactionFleetForm);

  Future<Either<Failure, ChargerInformationEntity>> checkInFleetCard(
      String accessToken, CheckInFleetForm checkInFleetForm);

  Future<Either<Failure, DefaultEntity>> remoteStartFleetCard(
      String accessToken, RemoteStartFleetForm remoteStartFleetForm);

  Future<Either<Failure, CheckStatusEntity>> checkStatusFleetCard(
      String accessToken, CheckStatusFleetForm checkStatusFleetForm);

  Future<Either<Failure, DefaultEntity>> remoteStopFleetCard(
      String accessToken, RemoteStopFleetForm remoteStopFleetForm);

  Future<Either<Failure, DefaultEntity>> confirmTransactionFleetCard(
      String accessToken,
      ConfirmTransactionFleetForm confirmTransactionFleetForm);

  Future<Either<Failure, ListNotificationEntity>> listNotification(
      String accessToken);

  Future<Either<Failure, NotificationNewsEntity>> listNotificationNews(
      String accessToken, ObjectEmptyForm objectEmpty);

  Future<Either<Failure, DefaultEntity>> deleteNotification(
      String accessToken, DeleteNotificationForm deleteNotification);

  Future<Either<Failure, DefaultEntity>> activeNotification(
      String accessToken, ActiveNotificationForm activeNotification);

  Future<Either<Failure, DefaultEntity>> setNotificationSetting(
      String accessToken, SetNotificationSettingForm setNotificationSetting);

  Future<Either<Failure, NotificationSettingEntity>> getNotificationSetting(
      String accessToken, ObjectEmptyForm objectEmpty);

  Future<Either<Failure, CountAllNotificationEntity>> getCountAllNotification(
      String accessToken, ObjectEmptyForm objectEmpty);

  Future<Either<Failure, HasChargingFleetEntity>> checkHasChargingFleetCard(
      String accessToken);

  Future<Either<Failure, HasChargingFleetEntity>>
      checkHasChargingFleetOperation(String accessToken);

  Future<Either<Failure, List<HistoryFleetDataEntity>>> getHistoryFleetCardList(
      String accessToken,
      String orgCode,
      HistoryFleetCardForm historyFleetCardForm);

  Future<Either<Failure, List<HistoryFleetDataEntity>>>
      getHistoryFleetOperationList(
          String accessToken, int fleetNo, String orgCode);

  Future<Either<Failure, DefaultEntity>> verifyFleetCard(String accessToken,
      VerifyFleetCardForm verifyFleetCardForm, String orgCode);

  Future<Either<Failure, List<RecommendedStationEntity>>> recommendedStation(
      String accessToken, RecommendedStationForm recommendedStationForm);

  Future<Either<Failure, DefaultEntity>> verifyEmail(
      VerifyEmailForm verifyEmailForm);

  Future<Either<Failure, DefaultEntity>> setLanguage(
      String accessToken, SetLanguageForm setLanguageFrom);

  Future<Either<Failure, VerifyImageOcrEntity>> verifyImageOcr(
      String accessToken, File file, String licensePlate);

  Future<Either<Failure, ListCarSelectFleetModel>>
      listVehicleChargingFleetOperation(
          String accessToken, String orgCode, FleetNoForm fleetNoForm);

  Future<Either<Failure, DefaultEntity>> addVehicleChargingFleetOperation(
      String accessToken,
      String orgCode,
      AddCarChargingForm addCarChargingForm);

  Future<Either<Failure, RoutePlanningEntity>> getRoutePlanning(
      String accessToken, RoutePlanningForm routePlanningForm);

  Future<Either<Failure, List<FavoriteRouteItemEntity>>> favoriteRoute(
      String accessToken, UsernameAndOrgCodeForm usernameAndOrgCodeForm);

  Future<Either<Failure, DefaultEntity>> addFavoriteRoute(
      String accessToken, AddFavoriteRouteForm addFavoriteRouteForm);

  Future<Either<Failure, DefaultEntity>> updateFavoriteRoute(
      String accessToken, UpdateFavoriteRouteForm updateFavoriteRouteForm);

  Future<Either<Failure, DefaultEntity>> deleteFavoriteRoute(
      String accessToken, DeleteFavoriteRouteForm deleteFavoriteRouteForm);

  Future<Either<Failure, DefaultEntity>> addLog(LogCrashForm logCrashForm);
}
