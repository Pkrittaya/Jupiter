import 'dart:io';
import 'package:dio/dio.dart' hide Headers;
import 'package:http_parser/http_parser.dart';
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
import 'package:jupiter_api/data/data_models/response/favorite_route_item_model.dart';
import 'package:jupiter_api/data/data_models/response/list_charger_fleet_card_model.dart';
import 'package:jupiter_api/data/data_models/response/list_charger_fleet_operation_model.dart';
import 'package:jupiter_api/data/data_models/response/get_count_all_notification_model.dart';
import 'package:jupiter_api/data/data_models/response/notification_news_model.dart';
import 'package:jupiter_api/data/data_models/response/notification_setting_model.dart';
import 'package:jupiter_api/data/data_models/response/route_planning_model.dart';
import 'package:jupiter_api/data/data_models/response/verify_image_ocr_model.dart';
import 'package:retrofit/retrofit.dart';
import '../../../config/api/api_config.dart';
import '../../data_models/request/active_notification_form.dart';
import '../../data_models/request/add_ev_car_form.dart';
import '../../data_models/request/add_tax_invoice_form.dart';
import '../../data_models/request/change_password_form.dart';
import '../../data_models/request/charger_information_form.dart';
import '../../data_models/request/check_in_fleet_form.dart';
import '../../data_models/request/check_status_fleet_form.dart';
import '../../data_models/request/collect_coupon.dart';
import '../../data_models/request/confirm_transaction_fleet_form.dart';
import '../../data_models/request/coupon_information_form.dart';
import '../../data_models/request/coupon_list_form.dart';
import '../../data_models/request/create_reserve_form.dart';
import '../../data_models/request/delete_account_form.dart';
import '../../data_models/request/delete_card_payment_form.dart';
import '../../data_models/request/delete_ev_car_form.dart';
import '../../data_models/request/delete_ev_car_image_form.dart';
import '../../data_models/request/delete_notification_form.dart';
import '../../data_models/request/delete_tax_invoice_form.dart';
import '../../data_models/request/edit_ev_car_form.dart';
import '../../data_models/request/favorite_station_form.dart';
import '../../data_models/request/finding_station_form.dart';
import '../../data_models/request/fleet_detail_card_form.dart';
import '../../data_models/request/fleet_no_form.dart';
import '../../data_models/request/get_list_reserve_form.dart';
import '../../data_models/request/history_booking_detail_form.dart';
import '../../data_models/request/history_booking_list_form.dart';
import '../../data_models/request/history_detail_form.dart';
import '../../data_models/request/history_list_form.dart';
import '../../data_models/request/list_payment_form.dart';
import '../../data_models/request/manage_charger_form.dart';
import '../../data_models/request/only_org_form.dart';
import '../../data_models/request/payment_charging_form.dart';
import '../../data_models/request/profile_form.dart';
import '../../data_models/request/recommended_station_form.dart';
import '../../data_models/request/remote_start_fleet_form.dart';
import '../../data_models/request/remote_stop_fleet_form.dart';
import '../../data_models/request/request_access_key_form.dart';
import '../../data_models/request/request_otp_forgot_pin_form.dart';
import '../../data_models/request/search_coupon_form.dart';
import '../../data_models/request/send_email_forgot_password_form.dart';
import '../../data_models/request/set_default_card_form.dart';
import '../../data_models/request/set_language_form.dart';
import '../../data_models/request/signin_account_form.dart';
import '../../data_models/request/signout_account_form.dart';
import '../../data_models/request/signup_account_form.dart';
import '../../data_models/request/start_charger_form.dart';
import '../../data_models/request/station_detail_form.dart';
import '../../data_models/request/status_charger_form.dart';
import '../../data_models/request/update_current_battery_form.dart';
import '../../data_models/request/update_favorite_station_form.dart';
import '../../data_models/request/update_select_payment_form.dart';
import '../../data_models/request/username_and_orgcode_form.dart';
import '../../data_models/request/verify_account_form.dart';
import '../../data_models/request/verify_card_form.dart';
import '../../data_models/request/verify_fleet_card_form.dart';
import '../../data_models/request/verify_otp_forgot_pin_form.dart';
import '../../data_models/response/advertisement_model.dart';
import '../../data_models/response/car_master_model.dart';
import '../../data_models/response/car_model.dart';
import '../../data_models/response/charger_information_model.dart';
import '../../data_models/response/check_status_model.dart';
import '../../data_models/response/collect_coupon_model.dart';
import '../../data_models/response/connector_type_model.dart';
import '../../data_models/response/coupon_detail_model.dart';
import '../../data_models/response/coupon_model.dart';
import '../../data_models/response/credit_card_model.dart';
import '../../data_models/response/default_model.dart';
import '../../data_models/response/favorite_station_model.dart';
import '../../data_models/response/finding_station_model.dart';
import '../../data_models/response/fleet_card_info_model.dart';
import '../../data_models/response/fleet_card_item_model.dart';
import '../../data_models/response/fleet_operation_info_model.dart';
import '../../data_models/response/fleet_operation_item_model.dart';
import '../../data_models/response/get_list_reserve_model.dart';
import '../../data_models/response/has_charging_fleet_card_model.dart';
import '../../data_models/response/history_booking_detail_model.dart';
import '../../data_models/response/history_detail_model.dart';
import '../../data_models/response/history_list/history_booking_list_model.dart';
import '../../data_models/response/history_list/history_fleet_list_model.dart';
import '../../data_models/response/history_list/history_list_model.dart';
import '../../data_models/response/list_billing_model.dart';
import '../../data_models/response/list_data_permission_model.dart';
import '../../data_models/response/list_notification_model.dart';
import '../../data_models/response/list_station_fleet_card_model.dart';
import '../../data_models/response/list_station_fleet_operation_model.dart';
import '../../data_models/response/profile_model.dart';
import '../../data_models/response/recommended_station_model.dart';
import '../../data_models/response/request_access_key_model.dart';
import '../../data_models/response/request_otp_forgot_pin_model.dart';
import '../../data_models/response/reserve_receipt_model.dart';
import '../../data_models/response/search_coupon__for_used_model.dart';
import '../../data_models/response/search_coupon_model.dart';
import '../../data_models/response/sign_in_model.dart';
import '../../data_models/response/sign_up_model.dart';
import '../../data_models/response/station_details_model.dart';
import '../../data_models/response/station_model.dart';
import '../../data_models/response/term_and_condition_model.dart';
import '../../data_models/response/verify_account_model.dart';
import '../../data_models/response/verify_card_model.dart';

part 'rest_client.g.dart';

@Injectable()
@RestApi()
@Headers({
  "Accept": "application/json",
  "Content-Type": "application/json",
  "Cache-Control": "max-age=640000"
})
abstract class RestClient {
  @FactoryMethod()
  factory RestClient(@FactoryMethod() Dio dio) = _RestClient;

  @POST(ApiPath.verifyAccount)
  Future<HttpResponse<VerifyAccountModel>> verifyAccountFromService({
    @Body() required VerifyAccountForm verifyAccountForm,
  });

  @POST(ApiPath.forgotPasswordResetPassword)
  Future<HttpResponse<dynamic>> sendEmailForgotPasswordFromSevice({
    @Body() required SendEmailForgotPasswordForm sendEmailForgotPasswordForm,
  });

  @POST(ApiPath.termAndCondition)
  Future<HttpResponse<TermAndConditionModel>> termAndConditionFromService({
    @Field("org_code") required String orgCode,
  });

  @POST(ApiPath.signUp)
  Future<HttpResponse<SignUpModel>> signUpToService({
    @Body() required SignupAccountForm signupAccountForm,
  });

  @POST(ApiPath.signIn)
  Future<HttpResponse<SignInModel>> signInToService({
    @Body() required SignInAccountForm signInAccountForm,
  });

  @POST(ApiPath.signOut)
  Future<HttpResponse<DefaultModel>> signOutToService({
    @Body() required SignOutAccountForm signOutAccountForm,
  });

  @POST(ApiPath.requestAccessToken)
  Future<HttpResponse<RequestAccessKeyModel>> requestAccessTokenFromService({
    @Body() required RequestAccessKeyForm requestAccessKeyForm,
  });

  @POST(ApiPath.allStationMarker)
  Future<HttpResponse<List<StationModel>>> listAllStationMarkerFromService({
    @Header("Authorization") required String accessToken,
    @Body() required OnlyOrgForm onlyOrgForm,
  });

  @POST(ApiPath.stationDetails)
  Future<HttpResponse<StationDetailModel>> stationDetailFromService({
    @Header("Authorization") required String accessToken,
    @Body() required StationDetailForm stationDetailForm,
  });

  @POST(ApiPath.findingStation)
  Future<HttpResponse<FindingStationModel>> findingStationFromService({
    @Header("Authorization") required String accessToken,
    @Body() required FindingStationForm findingStationForm,
  });

  @POST(ApiPath.favoriteStation)
  Future<HttpResponse<FavoriteStationModel>> favoriteStationFromService({
    @Header("Authorization") required String accessToken,
    @Body() required FavoriteStationForm favoriteStationForm,
  });

  @POST(ApiPath.updateFavoriteStation)
  Future<HttpResponse<dynamic>> updatefavoriteStationFromService({
    @Header("Authorization") required String accessToken,
    @Body() required UpdateFavoriteStationForm updateFavoriteStationForm,
  });

  @GET(ApiPath.connectorType)
  Future<HttpResponse<List<ConnectorTypeModel>>>
      connectorTypeFilterFromService({
    @Header("Authorization") required String accessToken,
  });

  @POST(ApiPath.chargerInformation)
  Future<HttpResponse<ChargerInformationModel>> chargerInformationFromService({
    @Header("Authorization") required String accessToken,
    @Body() required ChargerInformationForm chargerInformationForm,
  });

  @POST(ApiPath.listPayment)
  Future<HttpResponse<dynamic>> listPaymentFromService({
    @Header("Authorization") required String accessToken,
    @Body() required ListPaymentForm listPaymentForm,
  });

  @POST(ApiPath.updateSelectPayment)
  Future<HttpResponse<dynamic>> updateSelectPaymentFromService({
    @Header("Authorization") required String accessToken,
    @Body() required UpdateSelectPaymentForm updateSelectPaymentForm,
  });

  @POST(ApiPath.paymentCharging)
  Future<HttpResponse<dynamic>> paymentChargingFromService({
    @Header("Authorization") required String accessToken,
    @Body() required PaymentChargingForm paymentChargingForm,
  });

  @POST(ApiPath.updateCurrentBattery)
  Future<HttpResponse<dynamic>> updateCurrentBatteryFromService({
    @Header("Authorization") required String accessToken,
    @Body() required UpdateCurrentBatteryForm updateCurrentBatteryForm,
  });

  @POST(ApiPath.advertisement)
  Future<HttpResponse<AdvertisementModel>> advertisementFromService({
    @Header("Authorization") required String accessToken,
    @Body() required UsernameAndOrgCodeForm advertisementForm,
  });

  @POST(ApiPath.startCharge)
  Future<HttpResponse<DefaultModel>> startChargeFromService({
    @Header("Authorization") required String accessToken,
    @Body() required StartChargerForm startChargerForm,
  });

  @POST(ApiPath.stopCharge)
  Future<HttpResponse<DefaultModel>> stopChargeFromService({
    @Header("Authorization") required String accessToken,
    @Body() required ManageChargerForm manageChargerForm,
  });

  @POST(ApiPath.statusCharging)
  Future<HttpResponse<CheckStatusModel>> statusChargingFromService({
    @Header("Authorization") required String accessToken,
    @Body() required StatusChargerForm statusChargerForm,
  });

  @POST(ApiPath.confirmCharging)
  Future<HttpResponse<DefaultModel>> confirmCharigingFromService({
    @Header("Authorization") required String accessToken,
    @Body() required ManageChargerForm manageChargerForm,
  });

  @POST(ApiPath.profile)
  Future<HttpResponse<ProfileModel>> profileFromService({
    @Header("Authorization") required String accessToken,
    @Body() required UsernameAndOrgCodeForm usernameAndOrgCodeForm,
  });
  @POST(ApiPath.updateProfile)
  Future<HttpResponse<DefaultModel>> updateProfileFromService({
    @Header("Authorization") required String accessToken,
    @Body() required ProfileForm profileForm,
  });

  @POST(ApiPath.updateProfileImage)
  @MultiPart()
  Future<HttpResponse<DefaultModel>> updateProfileImageFromService({
    @Header("Authorization") required String accessToken,
    @Part(contentType: 'image/jpeg') required File file,
    @Part() required String payload,
  });

  @POST(ApiPath.creditCardList)
  Future<HttpResponse<List<CreditCardModel>>> creditCardListFromService({
    @Header("Authorization") required String accessToken,
    @Body() required UsernameAndOrgCodeForm usernameAndOrgCodeForm,
  });

  @POST(ApiPath.verifyCard)
  Future<HttpResponse<VerifyCardModel>> verifyCardFromService({
    @Header("Authorization") required String accessToken,
    @Body() required VerifyCardForm verifyCardForm,
  });

  @GET(ApiPath.carMaster)
  Future<HttpResponse<List<CarMasterModel>>> carMasterFromService({
    @Header("Authorization") required String accessToken,
    @Header("org_code") required String orgCode,
  });

  @POST(ApiPath.carList)
  Future<HttpResponse<List<CarModel>>> carListFromService({
    @Header("Authorization") required String accessToken,
    @Body() required UsernameAndOrgCodeForm usernameAndOrgCodeForm,
  });

  @POST(ApiPath.addCar)
  Future<HttpResponse<DefaultModel>> addCarFromService({
    @Header("Authorization") required String accessToken,
    @Body() required AddEvCarForm addEvCarForm,
  });

  @POST(ApiPath.deleteCar)
  Future<HttpResponse<DefaultModel>> deleteCarFromService({
    @Header("Authorization") required String accessToken,
    @Body() required DeleteEvCarForm deleteEvCarForm,
  });

  @POST(ApiPath.addCarImages)
  @MultiPart()
  Future<HttpResponse<DefaultModel>> addCarImageFromService({
    @Header("Authorization") required String accessToken,
    @Part() required String brand,
    @Part() required String model,
    @Part(contentType: 'image/jpeg') required File file,
  });

  @POST(ApiPath.deleteCarImages)
  Future<HttpResponse<DefaultModel>> deleteCarImageFromService({
    @Header("Authorization") required String accessToken,
    @Body() required DeleteEvCarImageForm form,
  });

  @POST(ApiPath.historyList)
  Future<HttpResponse<HistoryListModel>> getHistoryListFromService({
    @Header("Authorization") required String accessToken,
    @Body() required HistoryListForm form,
  });
  @POST(ApiPath.historyBookingList)
  Future<HttpResponse<HistoryBookingListModel>>
      getHistoryBookingListFromService({
    @Header("Authorization") required String accessToken,
    @Body() required HistoryBookingListForm historyBookingListForm,
  });

  @POST(ApiPath.historyDetail)
  Future<HttpResponse<HistoryDetailModel>> getHistoryDetailFromService({
    @Header("Authorization") required String accessToken,
    @Body() required HistoryDetailForm form,
  });

  @POST(ApiPath.historyBookingDetail)
  Future<HttpResponse<HistoryBookingDetailModel>>
      getHistoryBookingDetailFromService({
    @Header("Authorization") required String accessToken,
    @Body() required HistoryBookingDetailForm historyBookingDetailForm,
  });

  @POST(ApiPath.editCar)
  Future<HttpResponse<DefaultModel>> editCarFromService({
    @Header("Authorization") required String accessToken,
    @Body() required EditEvCarForm editEvCarForm,
  });

  @POST(ApiPath.addBilling)
  Future<HttpResponse<DefaultModel>> addTaxInvoiceFromSevice({
    @Header("Authorization") required String accessToken,
    @Body() required AddTaxInvoiceForm addTaxInvoiceForm,
  });

  @POST(ApiPath.updateBilling)
  Future<HttpResponse<DefaultModel>> updateTaxInvoiceFromSevice({
    @Header("Authorization") required String accessToken,
    @Body() required AddTaxInvoiceForm updateTaxInvoiceForm,
  });

  @POST(ApiPath.listBilling)
  Future<HttpResponse<ListBillingModel>> getTaxInvoiceFromSevice({
    @Header("Authorization") required String accessToken,
    @Body() required UsernameAndOrgCodeForm usernameAndOrgCodeForm,
  });

  @POST(ApiPath.deleteBilling)
  Future<HttpResponse<DefaultModel>> deleteTaxInvoiceFromSevice({
    @Header("Authorization") required String accessToken,
    @Body() required DeleteTaxInvoiceForm deleteTaxInvoiceForm,
  });
  @POST(ApiPath.setDefaultCard)
  Future<HttpResponse<DefaultModel>> setDefaultCardFromService({
    @Header("Authorization") required String accessToken,
    @Body() required SetDefaultCardForm setDefaultCardForm,
  });

  @POST(ApiPath.deletePayment)
  Future<HttpResponse<DefaultModel>> deletePaymentCardFromService({
    @Header("Authorization") required String accessToken,
    @Body() required DeleteCardPaymentForm deleteCardPaymentForm,
  });

  @POST(ApiPath.requestOtpForgotPin)
  Future<HttpResponse<RequestOtpForgotPinModel>>
      requestOtpForgotPinFromService({
    @Body() required RequestOtpForgotPinForm requestOtpForgotPinForm,
  });

  @POST(ApiPath.verifyOtpForgotPin)
  Future<HttpResponse<DefaultModel>> verifyOtpForgotPinFromService({
    @Body() required VerifyOtpForgotPinForm verifyOtpForgotPinForm,
  });

  @GET(ApiPath.listMycoupon)
  Future<HttpResponse<List<CouponModel>>> listMyCouponFromService({
    @Header("Authorization") required String accessToken,
    @Header("org_code") required String orgCode,
    @Queries() required CouponListForm couponList,
  });

  @GET(ApiPath.listUsedcoupon)
  Future<HttpResponse<List<CouponModel>>> listUsedCouponFromService({
    @Header("Authorization") required String accessToken,
    @Header("org_code") required String orgCode,
    @Queries() required CouponListForm couponList,
  });

  @GET(ApiPath.couponDetail)
  Future<HttpResponse<CouponDetailModel>> couponDetailFromService({
    @Header("Authorization") required String accessToken,
    @Header("org_code") required String orgCode,
    @Queries() required CouponInformationForm couponDetail,
  });

  @GET(ApiPath.searchCoupon)
  Future<HttpResponse<List<SearchCouponModel>>> searchCouponFromService({
    @Header("Authorization") required String accessToken,
    @Header("org_code") required String orgCode,
    @Queries() required SearchCouponForm searchCoupon,
  });

  @GET(ApiPath.searchCouponCheckin)
  Future<HttpResponse<List<SearchCouponForUsedModel>>>
      searchCouponCheckinPageFromService({
    @Header("Authorization") required String accessToken,
    @Header("org_code") required String orgCode,
    @Queries() required SearchCouponForm searchCoupon,
  });

  @POST(ApiPath.collectCoupon)
  Future<HttpResponse<CollectCouponModel>> collectCouponFromSevice({
    @Header("Authorization") required String accessToken,
    @Header("org_code") required String orgCode,
    @Body() required CollectCouponForm collectCouponForm,
  });

  @POST(ApiPath.scanQrcode)
  Future<HttpResponse<SearchCouponModel>> scanQrcodeCouponFromSevice({
    @Header("Authorization") required String accessToken,
    @Header("org_code") required String orgCode,
    @Body() required CouponInformationForm scanQrcodeCoupon,
  });

  @POST(ApiPath.scanQrcodeCheckin)
  Future<HttpResponse<SearchCouponForUsedModel>>
      scanQrcodeCouponCheckinPageFromSevice({
    @Header("Authorization") required String accessToken,
    @Header("org_code") required String orgCode,
    @Body() required CouponInformationForm scanQrcodeCoupon,
  });

  @POST(ApiPath.listReserve)
  Future<HttpResponse<GetListReserveModel>> listReserveFromSevice({
    @Header("Authorization") required String accessToken,
    @Header("org_code") required String orgCode,
    @Body() required GetListReserveForm getListReserveForm,
  });

  @POST(ApiPath.addReserve)
  Future<HttpResponse<ReserveReceiptModel>> createReserveFromSevice({
    @Header("Authorization") required String accessToken,
    @Header("org_code") required String orgCode,
    @Body() required CreateReserveForm createReserveForm,
  });

  @POST(ApiPath.changePassword)
  Future<HttpResponse<DefaultModel>> changePasswordFromSevice({
    // @Header("Authorization") required String accessToken,
    // @Header("org_code") String orgCode = ConstValue.orgCode,
    @Body() required ChangePasswordForm changePasswordForm,
  });

  @POST(ApiPath.deleteAccount)
  Future<HttpResponse<DefaultModel>> deleteAccountFromSevice({
    @Header("Authorization") required String accessToken,
    @Body() required DeleteAccountForm deleteAccountForm,
  });

  @GET(ApiPath.permissionFleet)
  Future<HttpResponse<ListDataPermissionModel>> permissionFleetFromSevice({
    @Header("Authorization") required String accessToken,
  });

  @GET(ApiPath.listFleetCard)
  Future<HttpResponse<List<FleetCardItemModel>>> listFleetCardFromSevice({
    @Header("Authorization") required String accessToken,
    @Header("org_code") required String orgCode,
  });

  @GET(ApiPath.listFleetOperation)
  Future<HttpResponse<List<FleetOperationItemModel>>>
      listFleetOperationFromSevice({
    @Header("Authorization") required String accessToken,
    @Header("org_code") required String orgCode,
  });

  @POST(ApiPath.fleetCardInfo)
  Future<HttpResponse<FleetCardInfoModel>> fleetCardInfoFromSevice({
    @Header("Authorization") required String accessToken,
    @Header("org_code") required String orgCode,
    @Body() required FleetDetailCardForm fleetDetailCardForm,
  });

  @POST(ApiPath.fleetOperationInfo)
  Future<HttpResponse<FleetOperationInfoModel>> fleetOperationInfoFromSevice({
    @Header("Authorization") required String accessToken,
    @Header("org_code") required String orgCode,
    @Body() required FleetNoForm fleetNoForm,
  });

  @POST(ApiPath.fleetCardStation)
  Future<HttpResponse<ListStationFleetCardModel>> fleetCardStationFromSevice({
    @Header("Authorization") required String accessToken,
    @Header("org_code") required String orgCode,
    @Body() required FleetNoForm fleetNoForm,
  });

  @POST(ApiPath.fleetOperationStation)
  Future<HttpResponse<ListStationFleetOperationModel>>
      fleetOperationStationFromSevice({
    @Header("Authorization") required String accessToken,
    @Header("org_code") required String orgCode,
    @Body() required FleetNoForm fleetNoForm,
  });

  @POST(ApiPath.fleetCardCharger)
  Future<HttpResponse<ListChargerFleetCardModel>> fleetCardChargerFromSevice({
    @Header("Authorization") required String accessToken,
    @Header("org_code") required String orgCode,
    @Body() required FleetChargerForm fleetChargerForm,
  });

  @POST(ApiPath.fleetOperationCharger)
  Future<HttpResponse<ListChargerFleetOperationModel>>
      fleetOperationChargerFromSevice({
    @Header("Authorization") required String accessToken,
    @Header("org_code") required String orgCode,
    @Body() required FleetChargerForm fleetChargerForm,
  });

  @POST(ApiPath.checkInFleetOperation)
  Future<HttpResponse<ChargerInformationModel>>
      checkInFleetOperationFromService({
    @Header("Authorization") required String accessToken,
    @Body() required CheckInFleetForm checkInFleetForm,
  });

  @POST(ApiPath.remoteStartOperation)
  Future<HttpResponse<DefaultModel>> remoteStartFleetOperationFromService({
    @Header("Authorization") required String accessToken,
    @Body() required RemoteStartFleetForm remoteStartFleetForm,
  });

  @POST(ApiPath.checkStatusOperation)
  Future<HttpResponse<CheckStatusModel>> checkStatusFleetOperationFromService({
    @Header("Authorization") required String accessToken,
    @Body() required CheckStatusFleetForm checkStatusFleetForm,
  });

  @POST(ApiPath.remoteStopOperation)
  Future<HttpResponse<DefaultModel>> remoteStopFleetOperationFromService({
    @Header("Authorization") required String accessToken,
    @Body() required RemoteStopFleetForm remoteStopFleetForm,
  });

  @POST(ApiPath.confirmTransactionOperation)
  Future<HttpResponse<DefaultModel>>
      confirmTransactionFleetOperationFromService({
    @Header("Authorization") required String accessToken,
    @Body() required ConfirmTransactionFleetForm confirmTransactionFleetForm,
  });

  @POST(ApiPath.checkInFleetCard)
  Future<HttpResponse<ChargerInformationModel>> checkInFleetCardFromService({
    @Header("Authorization") required String accessToken,
    @Body() required CheckInFleetForm checkInFleetForm,
  });

  @POST(ApiPath.remoteStartCard)
  Future<HttpResponse<DefaultModel>> remoteStartFleetCardFromService({
    @Header("Authorization") required String accessToken,
    @Body() required RemoteStartFleetForm remoteStartFleetForm,
  });

  @POST(ApiPath.checkStatusCard)
  Future<HttpResponse<CheckStatusModel>> checkStatusFleetCardFromService({
    @Header("Authorization") required String accessToken,
    @Body() required CheckStatusFleetForm checkStatusFleetForm,
  });

  @POST(ApiPath.remoteStopCard)
  Future<HttpResponse<DefaultModel>> remoteStopFleetCardFromService({
    @Header("Authorization") required String accessToken,
    @Body() required RemoteStopFleetForm remoteStopFleetForm,
  });

  @POST(ApiPath.confirmTransactionCard)
  Future<HttpResponse<DefaultModel>> confirmTransactionFleetCardFromService({
    @Header("Authorization") required String accessToken,
    @Body() required ConfirmTransactionFleetForm confirmTransactionFleetForm,
  });

  @GET(ApiPath.checkHasChargingFleetCard)
  Future<HttpResponse<HasChargingFleetModel>>
      checkHasChargingFleetCardFromService({
    @Header("Authorization") required String accessToken,
  });

  @GET(ApiPath.checkHasChargingFleetOperation)
  Future<HttpResponse<HasChargingFleetModel>>
      checkHasChargingFleetOperationFromService({
    @Header("Authorization") required String accessToken,
  });

  @POST(ApiPath.historyFleetCardList)
  Future<HttpResponse<List<HistoryFleetModel>>>
      getHistoryFleetCardListFromService({
    @Header("Authorization") required String accessToken,
    @Header("org_code") required String orgCode,
    @Body() required HistoryFleetCardForm historyFleetCardForm,
  });

  @GET(ApiPath.historyFleetOperationList)
  Future<HttpResponse<List<HistoryFleetModel>>>
      getHistoryFleetOperationListFromService({
    @Header("Authorization") required String accessToken,
    @Header("org_code") required String orgCode,
    @Query("fleet_no") required int fleetNo,
  });

  @GET(ApiPath.listNotification)
  Future<HttpResponse<ListNotificationModel>> listNotificationFromService({
    @Header("Authorization") required String accessToken,
  });

  @GET(ApiPath.listNotificationNews)
  Future<HttpResponse<NotificationNewsModel>> listNotificationNewsFromService({
    @Header("Authorization") required String accessToken,
    @Body() required ObjectEmptyForm objectEmpty,
  });

  @POST(ApiPath.deleteNotification)
  Future<HttpResponse<DefaultModel>> deleteNotificationFromService({
    @Header("Authorization") required String accessToken,
    @Body() required DeleteNotificationForm deleteNotification,
  });

  @POST(ApiPath.activeNotification)
  Future<HttpResponse<DefaultModel>> activeNotificationFromService({
    @Header("Authorization") required String accessToken,
    @Body() required ActiveNotificationForm activeNotification,
  });

  @POST(ApiPath.setNotificationSetting)
  Future<HttpResponse<DefaultModel>> setNotificationSettingFromService({
    @Header("Authorization") required String accessToken,
    @Body() required SetNotificationSettingForm setNotificationSetting,
  });

  @POST(ApiPath.getNotificationSetting)
  Future<HttpResponse<NotificationSettingModel>>
      getNotificationSettingFromService({
    @Header("Authorization") required String accessToken,
    @Body() required ObjectEmptyForm objectEmpty,
  });

  @GET(ApiPath.getCountAllNotification)
  Future<HttpResponse<CountAllNotificationModel>>
      getCountAllNotificationFromService({
    @Header("Authorization") required String accessToken,
    @Body() required ObjectEmptyForm objectEmpty,
  });

  @POST(ApiPath.verifyFleetCard)
  Future<HttpResponse<DefaultModel>> verifyFleetCardFromService({
    @Header("Authorization") required String accessToken,
    @Header("org_code") required String orgCode,
    @Body() required VerifyFleetCardForm verifyFleetCardForm,
  });

  @POST(ApiPath.recommendedStation)
  Future<HttpResponse<List<RecommendedStationModel>>>
      recommendedStationFromService({
    @Header("Authorization") required String accessToken,
    @Body() required RecommendedStationForm recommendedStationForm,
  });

  @POST(ApiPath.verifyEmail)
  Future<HttpResponse<DefaultModel>> verifyEmailFromService(
      {@Body() required VerifyEmailForm verifyEmailForm});

  @POST(ApiPath.setLanguage)
  Future<HttpResponse<DefaultModel>> setLanguageFromService(
      {@Header("Authorization") required String accessToken,
      @Body() required SetLanguageForm setLanguageFrom});

  @POST(ApiPath.verifyImageOcr)
  @MultiPart()
  Future<HttpResponse<VerifyImageOcrModel>> verifyImageOcrFromService({
    @Header("Authorization") required String accessToken,
    @Part(contentType: 'image/jpeg') required File file,
    @Part() required String license_plate,
  });

  @POST(ApiPath.list_vehicle_charging_fleet_operation)
  Future<HttpResponse<ListCarSelectFleetModel>>
      listVehicleChargingFleetOperationFromService({
    @Header("Authorization") required String accessToken,
    @Header("org_code") required String orgCode,
    @Body() required FleetNoForm fleetNoForm,
  });

  @POST(ApiPath.add_vehicle_charging_fleet_operation)
  Future<HttpResponse<DefaultModel>>
      addVehicleChargingFleetOperationFromService({
    @Header("Authorization") required String accessToken,
    @Header("org_code") required String orgCode,
    @Body() required AddCarChargingForm addCarChargingForm,
  });

  @POST(ApiPath.route_planning)
  Future<HttpResponse<RoutePlanningModel>> getRoutePlanningFromService(
      {@Header("Authorization") required String accessToken,
      @Body() required RoutePlanningForm routePlanningForm});

  @POST(ApiPath.favorite_route)
  Future<HttpResponse<List<FavoriteRouteItemModel>>> favoriteRouteFromService({
    @Header("Authorization") required String accessToken,
    @Body() required UsernameAndOrgCodeForm usernameAndOrgCodeForm,
  });

  @POST(ApiPath.add_favorite_route)
  Future<HttpResponse<DefaultModel>> addFavoriteRouteFromService(
      {@Header("Authorization") required String accessToken,
      @Body() required AddFavoriteRouteForm addFavoriteRouteForm});

  @POST(ApiPath.update_favorite_route)
  Future<HttpResponse<DefaultModel>> updateFavoriteRouteFromService(
      {@Header("Authorization") required String accessToken,
      @Body() required UpdateFavoriteRouteForm updateFavoriteRouteForm});

  @POST(ApiPath.delete_favorite_route)
  Future<HttpResponse<DefaultModel>> deleteFavoriteRouteFromService(
      {@Header("Authorization") required String accessToken,
      @Body() required DeleteFavoriteRouteForm deleteFavoriteRouteForm});

  @POST(ApiPath.addLogCrash)
  Future<HttpResponse<DefaultModel>> addLogFromService(
      {@Body() required LogCrashForm logCrashForm});
}
