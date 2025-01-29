import 'package:get_it/get_it.dart';
import 'package:jupiter/src/internet_signal.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/confirm_license_plate/cubit/ocr_cubit.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/select_vehicle/cubit/select_vehicle_cubit.dart';
import 'package:jupiter/src/presentation/pages/notification_detail/cubit/notification_detail_cubit.dart';
import 'package:jupiter/src/presentation/pages/notification_setting/cubit/notification_setting_cubit.dart';
import 'package:jupiter/src/presentation/pages/splash_screen/check_status_charging.dart';
import 'package:jupiter/src/presentation/widgets/route_planner/cubit/route_planner_cubit.dart';
import 'package:jupiter_api/config/api/api_config.dart';
import 'package:jupiter_api/data/data_repositories/user_management_repostitory_impl.dart';
import 'package:jupiter_api/data/data_sources/remote/rest_client.dart';
import 'package:jupiter_api/data/dio_config/dio_util.dart';
import 'package:jupiter_api/domain/repositories/user_management_repository.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/navigation_service.dart';
import 'package:jupiter/src/presentation/pages/booking/cubit/booking_cubit.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/charging/cubit/charging_realtime_cubit.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in/cubit/cubit/check_in_cubit.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/receipt/cubit/receipt_success_cubit.dart';
import 'package:jupiter/src/presentation/pages/ev_information/cubit/ev_information_cubit.dart';
import 'package:jupiter/src/presentation/pages/ev_information_add/cubit/ev_information_add_cubit.dart';
import 'package:jupiter/src/presentation/pages/favorite/cubit/favorite_cubit.dart';
import 'package:jupiter/src/presentation/pages/fleet/cubit/fleet_cubit.dart';
import 'package:jupiter/src/presentation/pages/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:jupiter/src/presentation/pages/history/cubit/history_cubit.dart';
import 'package:jupiter/src/presentation/pages/history_detail/cubit/history_detail_cubit.dart';
import 'package:jupiter/src/presentation/pages/home/cubit/advertisement_home_page_cubit.dart';
import 'package:jupiter/src/presentation/pages/home/cubit/home_cubit.dart';
import 'package:jupiter/src/presentation/pages/home/cubit/notification_home_page_cubit.dart';
import 'package:jupiter/src/presentation/pages/home/cubit/recommended_station_cubit.dart';
import 'package:jupiter/src/presentation/pages/login/cubit/login_cubit.dart';
import 'package:jupiter/src/presentation/pages/main_menu/cubit/main_menu_cubit.dart';
import 'package:jupiter/src/presentation/pages/map/cubit/map_cubit.dart';
import 'package:jupiter/src/presentation/pages/notification/cubit/notification_cubit.dart';
import 'package:jupiter/src/presentation/pages/payment/cubit/payment_cubit.dart';
import 'package:jupiter/src/presentation/pages/payment_detail/cubit/payment_detail_cubit.dart';
import 'package:jupiter/src/presentation/pages/payment_kbank/cubit/payment_k_bank_cubit.dart';
import 'package:jupiter/src/presentation/pages/policy/cubit/policy_cubit.dart';
import 'package:jupiter/src/presentation/pages/profile/cubit/profile_cubit.dart';
import 'package:jupiter/src/presentation/pages/register/cubit/register_cubit.dart';
import 'package:jupiter/src/presentation/pages/scan_qrcode/cubit/scan_qr_code_cubit.dart';
import 'package:jupiter/src/presentation/pages/setting_privacy/cubit/setting_privacy_cubit.dart';
import 'package:jupiter/src/presentation/pages/station_details/cubit/station_details_cubit.dart';
import 'package:jupiter/src/presentation/pages/update_password/cubit/update_password_cubit.dart';
import 'package:jupiter/src/presentation/status_charging/cubit/status_charging_cubit.dart';
import 'package:jupiter/src/presentation/widgets/custom_app_bar_with_search/cubit/custom_app_bar_with_search_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'internet_check.dart';
import 'presentation/pages/coupon/coupon_list/cubit/coupon_cubit.dart';
import 'presentation/pages/coupon/coupon_search/cubit/coupon_search_cubit.dart';
import 'presentation/pages/coupon_detail/cubit/coupon_detail_cubit.dart';
import 'presentation/pages/delete_account/cubit/delete_account_cubit.dart';
import 'presentation/pages/forgot_pincode/cubit/forgot_pincode_cubit.dart';
import 'presentation/pages/profile_add_tax_invoice/cubit/profile_add_tax_invoice_cubit.dart';
import 'presentation/pages/profile_edit/cubit/profile_edit_cubit.dart';
import 'package:jupiter_api/jupiter_api.dart';

final getIt = GetIt.instance;

// กำหนดตัวสำหรับตั้งค่า get_it
// ฟังก์ชันที่ชื่อ $initGetIt จะถูกสร้างเมื่อเราสั่ง build_runner
// @InjectableInit(preferRelativeImports: false)
// Future<void> configureInjection({String? env}) async => getIt.init(environment: env);

Future<void> configureInjection({String? env}) async {
// bloc
  getIt.registerFactory(() => RegisterCubit(getIt()));
  getIt.registerFactory(() => LoginCubit(getIt()));
  getIt.registerFactory(() => MapCubit(getIt()));
  getIt.registerFactory(() => StationDetailsCubit(getIt()));
  getIt.registerFactory(() => CustomAppBarWithSearchCubit(getIt()));
  // getIt.registerFactory(() => ChargingCubit(getIt()));
  getIt.registerFactory(() => ChargingRealtimeCubit(getIt()));
  getIt.registerFactory(() => CheckInCubit(getIt()));
  getIt.registerFactory(() => HomeCubit(getIt()));
  getIt.registerFactory(() => ScanQrCodeCubit(getIt()));
  getIt.registerFactory(() => MainMenuCubit(getIt()));
  getIt.registerFactory(() => ProfileCubit(getIt()));
  getIt.registerFactory(() => ProfileEditCubit(getIt()));
  getIt.registerFactory(() => PaymentCubit(getIt()));
  getIt.registerFactory(() => PaymentDetailCubit(getIt()));
  getIt.registerFactory(() => EvInformationCubit(getIt()));
  getIt.registerFactory(() => EvInformationAddCubit(getIt()));
  getIt.registerFactory(() => PaymentKBankCubit(getIt()));
  getIt.registerFactory(() => HistoryCubit(getIt()));
  getIt.registerFactory(() => HistoryDetailCubit(getIt()));
  getIt.registerFactory(() => StatusChargingCubit(getIt()));
  getIt.registerFactory(() => ReceiptSuccessCubit(getIt()));
  getIt.registerFactory(() => ForgotPasswordCubit(getIt()));
  getIt.registerFactory(() => FavoriteStationCubit(getIt()));
  getIt.registerFactory(() => ProfileAddTaxInvoiceCubit(getIt()));
  getIt.registerFactory(() => ForgotPincodeCubit(getIt()));
  getIt.registerFactory(() => CouponCubit(getIt()));
  getIt.registerFactory(() => CouponDetailCubit(getIt()));
  getIt.registerFactory(() => CouponSearchCubit(getIt()));
  getIt.registerFactory(() => BookingCubit(getIt()));
  getIt.registerFactory(() => UpdatePasswordCubit(getIt()));
  getIt.registerFactory(() => DeleteAccountCubit(getIt()));
  getIt.registerFactory(() => FleetCubit(getIt()));
  getIt.registerFactory(() => NotiCubit(getIt()));
  getIt.registerFactory(() => PolicyCubit(getIt()));
  getIt.registerFactory(() => SettingPrivacyCubit(getIt()));
  getIt.registerFactory(() => NotificationHomePageCubit(getIt()));
  getIt.registerFactory(() => AdvertisementHomePageCubit(getIt()));
  getIt.registerFactory(() => RecommendedStationCubit(getIt()));
  getIt.registerFactory(() => OcrCubit(getIt()));
  getIt.registerFactory(() => SelectVehicleCubit(getIt()));
  getIt.registerFactory(() => RoutePlannerCubit(getIt()));
  getIt.registerFactory(() => NotiSettingCubit(getIt()));
  getIt.registerFactory(() => NotificationDetailCubit(getIt()));

  //Navigate
  getIt.registerLazySingleton(() => NavigationService());

  // usecase
  getIt.registerLazySingleton(() => UserManagementUseCase(getIt()));

  // repository
  getIt.registerLazySingleton<UserManagementRepository>(
    () => UserManagementRepositoryImpl(getIt()),
  );
  // getIt.registerLazySingleton<TermAndConditionRepository>(
  //   () => TermAndConditionRepositoryImpl(getIt()),
  // );

  getIt.registerLazySingleton(() => JupiterApi);
  JupiterApi(env: ENV.dev);

  final dio = DioUtil.createDioInstance(JupiterApi.getBaseUrl(ApiConfig.env));

  // data source
  getIt.registerLazySingleton<RestClient>(
    () => RestClient(dio),
  );

  // external
  // getIt.registerLazySingleton(() => Dio);

  getIt.registerLazySingleton(() => InternetCheck());
  getIt.registerLazySingleton(() => CheckStatusChargingData());
  getIt.registerLazySingleton(() => InternetSignal());
  SharedPreferences prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => JupiterPrefsAndAppData(prefs: prefs));
}

// กำหนดว่าอยากให้มี Environment อะไรบ้างตามแต่ใจของเราเลย
abstract class Env {
  static const dev = 'dev';
  static const prod = 'prod';
}
