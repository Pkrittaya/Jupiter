enum ENV { dev, prd }

class ApiConfig {
  static ENV env = ENV.dev;
  // static ENV env = ENV.prd;

  // static const String domain = 'http://10.224.188.14';
  // static const String domain = 'http://10.224.183.23:9100';
  static const String domainDev = 'https://jupiter-dev.pttdigital.com';
  static const String domainPrd = 'https://jupiter-platform.pttdigital.com';
  static const String timeout = '';
}

// class ApiPath {
//   // ABOUT REGISTER
//   static const String term_and_condition =
//       '/api-management-user/register-consent';
//   static const String verify_account = '/api-management-user/verify-account';
//   static const String sign_up = '/api-management-user/sign-up';

//   // ABOUT LOGIN
//   static const String sign_in = '/api-management-user/sign-in';
//   static const String sign_out = '/api-management-user/sign-out';
//   static const String request_access_token =
//       '/api-management-user/request-access-key';
//   static const String forgot_password_reset_password =
//       '/api-management-user/send-email-forgot-password';
//   static const String request_otp_forgot_pin = '/api-management-user/send-otp';
//   static const String verify_otp_forgot_pin = '/api-management-user/verify-otp';
//   static const String change_password = '/api-management-user/change-password';
//   static const String verify_email = '/api-management-user/resend-verify-email';

//   // ABOUT HOME PAGE
//   static const String advertisement =
//       '/mobile-api-manage-advertisement/get-advertisement';
//   static const String permission_fleet =
//       '/api-management-user-auth/permission-user-mobile';
//   static const String recommendedStation =
//       '/mobile-api-realtime/get-recommended-station';

//   // ABOUT STATION MENU
//   static const String all_station_marker =
//       '/mobile-api-realtime/list-all-marker';
//   static const String station_details =
//       '/mobile-api-realtime/station-information';
//   static const String finding_station = '/mobile-api-realtime/finding-station';
//   static const String connector_type = '/mobile-api-masterdata/connector-type';
//   static const String update_favorite_station =
//       '/mobile-api-favourite/update-favorite';
//   static const String favorite_station = '/mobile-api-favourite/list-favorite';

//   // ABOUT CHARGING
//   static const String charger_information =
//       '/mobile-api-manage-transaction/get-information-charger';
//   static const String start_charge =
//       '/mobile-api-manage-transaction/remote-start';
//   static const String stop_charge =
//       '/mobile-api-manage-transaction/remote-stop';
//   static const String status_charging =
//       '/mobile-api-manage-transaction/check-status-charging';
//   static const String confirm_charging =
//       '/mobile-api-manage-transaction/confirm-charging';
//   static const String update_select_payment =
//       '/mobile-api-manage-transaction/update-payment-charging';
//   static const String payment_charging =
//       '/mobile-api-manage-transaction/payment-charging';
//   static const String update_current_battery =
//       '/mobile-api-manage-transaction/update-current-battery-charging';
//   static const String list_reserve =
//       '/mobile-api-manage-reserve/get-reserve-charger';
//   static const String add_reserve =
//       '/mobile-api-manage-reserve/create-reserve-charger';
//   static const String verify_image_ocr = '/ocr/scan-licenseplate';

//   // ABOUT PROFILE PAGE
//   static const String profile =
//       '/mobile-setting-profile/get-information-profile';
//   static const String update_profile_image =
//       '/mobile-setting-profile/add-images-profile';
//   static const String update_profile = '/mobile-setting-profile/update-profile';
//   static const String list_billing = '/mobile-billing/list-billing-address';
//   static const String add_billing = '/mobile-billing/add-billing-address';
//   static const String delete_billing = '/mobile-billing/delete-billing-address';
//   static const String update_billing = '/mobile-billing/update-billing-address';
//   static const String delete_account =
//       '/api-management-user-auth/delete-account';
//   static const String set_language = '/api-management-user-auth/set-language';

//   // ABOUT PAYMENT
//   static const String credit_card_list = '/card/list-card';
//   static const String verify_card = '/payment-verify-card/verify-card';
//   static const String list_payment =
//       '/mobile-api-manage-transaction/list-payment-charging';
//   static const String set_default_card = '/payment-verify-card/defalut-card';
//   static const String delete_payment = '/card/delete-card';

//   // ABOUT CAR
//   static const String car_master = '/vehicle-management/list-master-vehicle';
//   static const String car_list = '/vehicle-management/list-vehicle-selection';
//   static const String add_car = '/vehicle-management/add-vehicle';
//   static const String delete_car =
//       '/vehicle-management/delete-vehicle-selection';
//   static const String car_images =
//       '/api-download-images-vehicle-mobile/images-vehicle?images_id=';
//   static const String add_car_images =
//       '/vehicle-management-image/add-images-vehicle?brand=BYD&model=E6';
//   static const String delete_car_images =
//       '/vehicle-management-image/delete-images-vehicle';
//   static const String edit_car = '/vehicle-management/update-vehicle';

//   // ABOUT HISTORY
//   static const String history_list =
//       '/mobile-api-history-transaction/list-transaction';
//   static const String history_detail =
//       '/mobile-api-history-transaction/transaction-info';
//   static const String history_booking_list =
//       '/mobile-api-history-reserve/list-reserve';
//   static const String history_booking_detail =
//       '/mobile-api-history-reserve/reserve-info';

//   // ABOUT COUPON
//   static const String list_mycoupon = '/api-manage-coupon-mobile/list-mycoupon';
//   static const String list_usedcoupon =
//       '/api-manage-coupon-mobile/list-usedcoupon';
//   static const String coupon_detail =
//       '/api-manage-coupon-mobile/list-coupon-information';
//   static const String search_coupon = '/api-manage-coupon-mobile/search-coupon';
//   static const String search_coupon_checkin =
//       '/api-manage-coupon-mobile/search-coupon-check-in-page';
//   static const String collect_coupon =
//       '/api-manage-coupon-mobile/collect-coupon';
//   static const String scan_qrcode =
//       '/api-manage-coupon-mobile/scan-qrcode-search-coupon';
//   static const String scan_qrcode_checkin =
//       '/api-manage-coupon-mobile/scan-qrcode-search-coupon-check-in-page';

//   // ABOUT FLEET
//   static const String check_has_charging_fleet_card =
//       '/mobile-api-manage-transaction-fleet-card/check-status-charging-menu';
//   static const String check_has_charging_fleet_operation =
//       '/mobile-api-manage-transaction-fleet-operation/check-status-charging-menu';
//   static const String list_fleet_card = '/mobile-fleet-card/fleet-card-list';
//   static const String list_fleet_operation =
//       '/mobile-fleet-operation/fleet-operation-list';
//   static const String fleet_card_info = '/mobile-fleet-card/fleet-card-detail';
//   static const String fleet_operation_info =
//       '/mobile-fleet-operation/fleet-operation-detail';
//   static const String fleet_card_station =
//       '/mobile-fleet-card/fleet-card-charging-station';
//   static const String fleet_operation_station =
//       '/mobile-fleet-operation/fleet-operation-charging-station';
//   static const String fleet_card_charger =
//       '/mobile-fleet-card/fleet-card-charger';
//   static const String fleet_operation_charger =
//       '/mobile-fleet-operation/fleet-operation-charger';
//   static const String check_in_fleet_operation =
//       '/mobile-fleet-operation-qr/get-information-charger-fleet-operation';
//   static const String remote_start_operation =
//       '/mobile-api-manage-transaction-fleet-operation/remote-start';
//   static const String remote_stop_operation =
//       '/mobile-api-manage-transaction-fleet-operation/remote-stop';
//   static const String check_status_operation =
//       '/mobile-api-manage-transaction-fleet-operation/check-status-charging';
//   static const String confirm_transaction_operation =
//       '/mobile-api-manage-transaction-fleet-operation/confirm-charging';
//   static const String check_in_fleet_card =
//       '/mobile-fleet-card-qr/get-information-charger-fleet-card';
//   static const String remote_start_card =
//       '/mobile-api-manage-transaction-fleet-card/remote-start';
//   static const String remote_stop_card =
//       '/mobile-api-manage-transaction-fleet-card/remote-stop';
//   static const String check_status_card =
//       '/mobile-api-manage-transaction-fleet-card/check-status-charging';
//   static const String confirm_transaction_card =
//       '/mobile-api-manage-transaction-fleet-card/confirm-charging';
//   static const String history_fleet_card_list =
//       '/mobile-api-manage-fleet-card/fleet-card-history';
//   static const String history_fleet_operation_list =
//       '/mobile-api-manage-fleet-operation/fleet-operation-history';
//   static const String verify_fleet_card =
//       '/mobile-fleet-card/verify-fleet-card';

//   // ABOUT NOTIFICATION
//   static const String list_notification =
//       '/mobile-notification/list-notification-mobile';
//   static const String delete_notification =
//       '/mobile-notification/delete-notification';
//   static const String active_notification =
//       '/mobile-notification/active-notification';
// }

class ApiPath {
  //Category
  static const String apiManagementUser = '/api-management-users';
  static const String mobileApiManageAdvertisement =
      '/mobile-api-manage-advertisements';
  static const String apiManagementUserAuth = '/api-management-user-auths';
  static const String mobileApiRealTime = '/mobile-api-realtimes';
  static const String mobileApiMasterData = '/mobile-api-masterdatas';
  static const String mobileApiFavourite = '/mobile-api-favourites';
  static const String mobileApiManageTransaction =
      '/mobile-api-manage-transactions';
  static const String mobileApiManageReserve = '/mobile-api-manage-reserves';
  static const String mobileSettingProfile = '/mobile-setting-profiles';
  static const String mobileBilling = '/mobile-billings';
  static const String vehicleManagement = '/vehicle-managements';
  static const String vehicleManagementImage = '/vehicle-management-images';
  static const String paymentVerifyCard = '/payment-verify-cards';
  static const String card = '/cards';
  static const String apiDownLoadImageVehicleMobile =
      '/api-download-images-vehicle-mobiles';
  static const String mobileApiHistoryTransaction =
      '/mobile-api-history-transactions';
  static const String mobileApiHistoryReserve = '/mobile-api-history-reserves';
  static const String apiManageCouponMobile = '/api-manage-coupon-mobiles';
  static const String mobileApiManageTransactionFleetCard =
      '/mobile-api-manage-transaction-fleet-cards';
  static const String mobileApiManageTransactionFleetOperation =
      '/mobile-api-manage-transaction-fleet-operations';

  static const String mobileFleetOperation = '/mobile-fleet-operations';
  static const String mobileFleetCard = '/mobile-fleet-cards';
  static const String mobileFleetOperationQr = '/mobile-fleet-operation-qrs';
  static const String mobileFleetCardQr = '/mobile-fleet-card-qrs';

  static const String mobileApiManageFleetCard =
      '/mobile-api-manage-fleet-cards';
  static const String mobileApiManageFleetOperation =
      '/mobile-api-manage-fleet-operations';
  static const String mobileNotification = '/mobile-notifications';
  static const String mobileLog = '/api-manage-log-platforms';

  // ABOUT REGISTER
  static const String termAndCondition = '$apiManagementUser/register-consent';
  static const String verifyAccount = '$apiManagementUser/verify-account';
  static const String signUp = '$apiManagementUser/sign-up';

  // ABOUT LOGIN
  static const String signIn = '$apiManagementUser/sign-in';
  static const String signOut = '$apiManagementUser/sign-out';
  static const String requestAccessToken =
      '$apiManagementUser/request-access-key';
  static const String forgotPasswordResetPassword =
      '$apiManagementUser/send-email-forgot-password';
  static const String requestOtpForgotPin = '$apiManagementUser/send-otp';
  static const String verifyOtpForgotPin = '$apiManagementUser/verify-otp';
  static const String changePassword = '$apiManagementUser/change-password';
  static const String verifyEmail = '$apiManagementUser/resend-verify-email';

  // ABOUT HOME PAGE
  static const String advertisement =
      '$mobileApiManageAdvertisement/get-advertisement';

  static const String permissionFleet =
      '$apiManagementUserAuth/permission-user-mobile';
  static const String recommendedStation =
      '$mobileApiRealTime/get-recommended-station';

  // ABOUT STATION MENU
  static const String allStationMarker = '$mobileApiRealTime/list-all-marker';
  static const String stationDetails = '$mobileApiRealTime/station-information';
  static const String findingStation = '$mobileApiRealTime/finding-station';
  static const String connectorType = '$mobileApiMasterData/connector-type';
  static const String updateFavoriteStation =
      '$mobileApiFavourite/update-favorite';
  static const String favoriteStation = '$mobileApiFavourite/list-favorite';
  static const String route_planning =
      '/mobile-api-route-planning/get-distance-google-map';
  static const String favorite_route =
      '/mobile-api-route-planning/list-route-planning';
  static const String add_favorite_route =
      '/mobile-api-route-planning/create-route-planning';
  static const String update_favorite_route =
      '/mobile-api-route-planning/edit-route-planning';
  static const String delete_favorite_route =
      '/mobile-api-route-planning/delete-route-planning';

  // ABOUT CHARGING
  static const String chargerInformation =
      '$mobileApiManageTransaction/get-information-charger';
  static const String startCharge = '$mobileApiManageTransaction/remote-start';
  static const String stopCharge = '$mobileApiManageTransaction/remote-stop';
  static const String statusCharging =
      '$mobileApiManageTransaction/check-status-charging';
  static const String confirmCharging =
      '$mobileApiManageTransaction/confirm-charging';
  static const String updateSelectPayment =
      '$mobileApiManageTransaction/update-payment-charging';
  static const String paymentCharging =
      '$mobileApiManageTransaction/payment-charging';
  static const String updateCurrentBattery =
      '$mobileApiManageTransaction/update-current-battery-charging';
  static const String listReserve =
      '$mobileApiManageReserve/get-reserve-charger';
  static const String addReserve =
      '$mobileApiManageReserve/create-reserve-charger';
  static const String verifyImageOcr = '/ocrs/scan-licenseplate';

  // ABOUT PROFILE PAGE
  static const String profile = '$mobileSettingProfile/get-information-profile';
  static const String updateProfileImage =
      '$mobileSettingProfile/add-images-profile';
  static const String updateProfile = '$mobileSettingProfile/update-profile';
  static const String listBilling = '$mobileBilling/list-billing-address';
  static const String addBilling = '$mobileBilling/add-billing-address';
  static const String deleteBilling = '$mobileBilling/delete-billing-address';
  static const String updateBilling = '$mobileBilling/update-billing-address';
  static const String deleteAccount = '$apiManagementUserAuth/delete-account';
  static const String setLanguage = '$apiManagementUserAuth/set-language';

  // ABOUT PAYMENT
  static const String creditCardList = '$card/list-card';
  static const String verifyCard = '$paymentVerifyCard/verify-card';
  static const String listPayment =
      '$mobileApiManageTransaction/list-payment-charging';
  static const String setDefaultCard = '$paymentVerifyCard/defalut-card';
  static const String deletePayment = '$card/delete-card';

  // ABOUT CAR
  static const String carMaster = '$vehicleManagement/list-master-vehicle';
  static const String carList = '$vehicleManagement/list-vehicle-selection';
  static const String addCar = '$vehicleManagement/add-vehicle';
  static const String deleteCar = '$vehicleManagement/delete-vehicle-selection';
  static const String carImages =
      '$apiDownLoadImageVehicleMobile/images-vehicle?images_id=';
  static const String addCarImages =
      '$vehicleManagementImage/add-images-vehicle?brand=BYD&model=E6';
  static const String deleteCarImages =
      '$vehicleManagementImage/delete-images-vehicle';
  static const String editCar = '$vehicleManagement/update-vehicle';

  // ABOUT HISTORY
  static const String historyList =
      '$mobileApiHistoryTransaction/list-transaction';
  static const String historyDetail =
      '$mobileApiHistoryTransaction/transaction-info';
  static const String historyBookingList =
      '$mobileApiHistoryReserve/list-reserve';
  static const String historyBookingDetail =
      '$mobileApiHistoryReserve/reserve-info';

  // ABOUT COUPON
  static const String listMycoupon = '$apiManageCouponMobile/list-mycoupon';
  static const String listUsedcoupon = '$apiManageCouponMobile/list-usedcoupon';
  static const String couponDetail =
      '$apiManageCouponMobile/list-coupon-information';
  static const String searchCoupon = '$apiManageCouponMobile/search-coupon';
  static const String searchCouponCheckin =
      '$apiManageCouponMobile/search-coupon-check-in-page';
  static const String collectCoupon = '$apiManageCouponMobile/collect-coupon';
  static const String scanQrcode =
      '$apiManageCouponMobile/scan-qrcode-search-coupon';
  static const String scanQrcodeCheckin =
      '$apiManageCouponMobile/scan-qrcode-search-coupon-check-in-page';

  // ABOUT FLEET
  static const String checkHasChargingFleetCard =
      '$mobileApiManageTransactionFleetCard/check-status-charging-menu';
  static const String checkHasChargingFleetOperation =
      '$mobileApiManageTransactionFleetOperation/check-status-charging-menu';
  static const String listFleetCard = '$mobileFleetCard/fleet-card-list';
  static const String listFleetOperation =
      '$mobileFleetOperation/fleet-operation-list';
  static const String fleetCardInfo = '$mobileFleetCard/fleet-card-detail';
  static const String fleetOperationInfo =
      '$mobileFleetOperation/fleet-operation-detail';
  static const String fleetCardStation =
      '$mobileFleetCard/fleet-card-charging-station';
  static const String fleetOperationStation =
      '$mobileFleetOperation/fleet-operation-charging-station';
  static const String fleetCardCharger = '$mobileFleetCard/fleet-card-charger';
  static const String fleetOperationCharger =
      '$mobileFleetOperation/fleet-operation-charger';
  static const String checkInFleetOperation =
      '$mobileFleetOperationQr/get-information-charger-fleet-operation';
  static const String remoteStartOperation =
      '$mobileApiManageTransactionFleetOperation/remote-start';
  static const String remoteStopOperation =
      '$mobileApiManageTransactionFleetOperation/remote-stop';
  static const String checkStatusOperation =
      '$mobileApiManageTransactionFleetOperation/check-status-charging';
  static const String confirmTransactionOperation =
      '$mobileApiManageTransactionFleetOperation/confirm-charging';
  static const String checkInFleetCard =
      '$mobileFleetCardQr/get-information-charger-fleet-card';
  static const String remoteStartCard =
      '$mobileApiManageTransactionFleetCard/remote-start';
  static const String remoteStopCard =
      '$mobileApiManageTransactionFleetCard/remote-stop';
  static const String checkStatusCard =
      '$mobileApiManageTransactionFleetCard/check-status-charging';
  static const String confirmTransactionCard =
      '$mobileApiManageTransactionFleetCard/confirm-charging';
  static const String historyFleetCardList =
      '$mobileApiManageFleetCard/fleet-card-history';
  static const String historyFleetOperationList =
      '$mobileApiManageFleetOperation/fleet-operation-history';
  static const String verifyFleetCard = '$mobileFleetCard/verify-fleet-card';
  static const String list_vehicle_charging_fleet_operation =
      '$mobileFleetOperation/fleet-operation-vehicle';
  static const String add_vehicle_charging_fleet_operation =
      '$mobileFleetOperation/fleet-operation-select-vehicle-rfid';

  // ABOUT NOTIFICATION
  static const String listNotification =
      '$mobileNotification/list-notification-mobile';
  static const String deleteNotification =
      '$mobileNotification/delete-notification';
  static const String activeNotification =
      '$mobileNotification/active-notification';
  static const String listNotificationNews =
      '$mobileNotification/list-notification-topic-mobile';
  static const String setNotificationSetting =
      '$mobileNotification/update-setting-notification-account';
  static const String getNotificationSetting =
      '$mobileNotification/get-setting-notification-account';
  static const String getCountAllNotification =
      '$mobileNotification/count-all-notification-account';

  // ABOUT LOG
  static const String addLogCrash = '$mobileLog/mobile-create-log';
  static const String addLogApi = '$mobileLog/mobile-create-log-api';
}
