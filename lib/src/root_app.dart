import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/confirm_license_plate/cubit/ocr_cubit.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/select_vehicle/cubit/select_vehicle_cubit.dart';
import 'package:jupiter/src/presentation/pages/fleet/cubit/fleet_cubit.dart';
import 'package:jupiter/src/presentation/pages/fleet/fleet_home/fleet_page.dart';
import 'package:jupiter/src/presentation/pages/home/cubit/advertisement_home_page_cubit.dart';
import 'package:jupiter/src/presentation/pages/home/cubit/notification_home_page_cubit.dart';
import 'package:jupiter/src/presentation/pages/home/cubit/recommended_station_cubit.dart';
import 'package:jupiter/src/presentation/pages/notification/cubit/notification_cubit.dart';
import 'package:jupiter/src/presentation/pages/notification_detail/cubit/notification_detail_cubit.dart';
import 'package:jupiter/src/presentation/pages/notification_setting/cubit/notification_setting_cubit.dart';
import 'package:jupiter/src/presentation/pages/policy/cubit/policy_cubit.dart';
import 'package:jupiter/src/presentation/pages/setting_privacy/cubit/setting_privacy_cubit.dart';
import 'package:jupiter/src/presentation/pages/splash_screen/splash_screen_page.dart';
import 'package:jupiter/src/presentation/pages/update_password/cubit/update_password_cubit.dart';
import 'package:jupiter/src/presentation/widgets/route_planner/cubit/route_planner_cubit.dart';
import 'package:rxdart/rxdart.dart';

import 'injection.dart';
import 'navigation_service.dart';
import 'presentation/pages/booking/cubit/booking_cubit.dart';
import 'presentation/pages/charging_jupiter/charging/cubit/charging_realtime_cubit.dart';
import 'presentation/pages/charging_jupiter/check_in/cubit/cubit/check_in_cubit.dart';
import 'presentation/pages/charging_jupiter/check_in_device/checkin_device_page.dart';
import 'presentation/pages/charging_jupiter/receipt/cubit/receipt_success_cubit.dart';
import 'presentation/pages/coupon/coupon_list/coupon_page.dart';
import 'presentation/pages/coupon/coupon_list/cubit/coupon_cubit.dart';
import 'presentation/pages/coupon/coupon_search/cubit/coupon_search_cubit.dart';
import 'presentation/pages/coupon_detail/cubit/coupon_detail_cubit.dart';
import 'presentation/pages/create_pincode/create_pincode_page.dart';
import 'presentation/pages/delete_account/cubit/delete_account_cubit.dart';
import 'presentation/pages/ev_information/cubit/ev_information_cubit.dart';
import 'presentation/pages/ev_information/ev_information_page.dart';
import 'presentation/pages/ev_information_add/cubit/ev_information_add_cubit.dart';
import 'presentation/pages/ev_information_add/ev_information_add_page.dart';
import 'presentation/pages/favorite/cubit/favorite_cubit.dart';
import 'presentation/pages/favorite/favorite_page.dart';
import 'presentation/pages/forgot_password/cubit/forgot_password_cubit.dart';
import 'presentation/pages/forgot_password/forgot_password_page.dart';
import 'presentation/pages/forgot_pincode/cubit/forgot_pincode_cubit.dart';
import 'presentation/pages/forgot_pincode/forgot_pincode_verify_otp.dart';
import 'presentation/pages/history/cubit/history_cubit.dart';
import 'presentation/pages/history_detail/cubit/history_detail_cubit.dart';
import 'presentation/pages/home/cubit/home_cubit.dart';
import 'presentation/pages/login/cubit/login_cubit.dart';
import 'presentation/pages/login/login_page.dart';
import 'presentation/pages/main_menu/cubit/main_menu_cubit.dart';
import 'presentation/pages/main_menu/main_menu_page.dart';
import 'presentation/pages/map/cubit/map_cubit.dart';
import 'presentation/pages/map/map_page.dart';
import 'presentation/pages/notification/notification_page.dart';
import 'presentation/pages/payment/cubit/payment_cubit.dart';
import 'presentation/pages/payment/payment_page.dart';
import 'presentation/pages/payment_detail/cubit/payment_detail_cubit.dart';
import 'presentation/pages/payment_kbank/cubit/payment_k_bank_cubit.dart';
import 'presentation/pages/payment_kbank/payment_kbank_page.dart';
import 'presentation/pages/profile/cubit/profile_cubit.dart';
import 'presentation/pages/profile_add_tax_invoice/cubit/profile_add_tax_invoice_cubit.dart';
import 'presentation/pages/profile_edit/cubit/profile_edit_cubit.dart';
import 'presentation/pages/profile_edit/profile_edit_page.dart';
import 'presentation/pages/register/cubit/register_cubit.dart';
import 'presentation/pages/register/register_page.dart';
import 'presentation/pages/scan_qrcode/cubit/scan_qr_code_cubit.dart';
import 'presentation/pages/scan_qrcode/scan_qrcode_page.dart';
import 'presentation/pages/setting_privacy/setting_privacy_page.dart';
import 'presentation/pages/station_details/cubit/station_details_cubit.dart';
import 'presentation/pages/station_details/station_details_page.dart';
import 'presentation/pages/update_pin/update_pincode_page.dart';
import 'presentation/status_charging/cubit/status_charging_cubit.dart';
import 'presentation/widgets/custom_app_bar_with_search/cubit/custom_app_bar_with_search_cubit.dart';
import 'route_names.dart';
import 'utilities.dart';

class RootApp extends StatefulWidget {
  RootApp({
    super.key,
    required this.builder,
    required this.lockScreen,
    this.enabled = true,
    this.backgroundLockLatency = const Duration(seconds: 0),
    // required this.destination,
    // required this.checkStatusEntity,
  });

  static var localeSubject = BehaviorSubject<Locale>();
  final Duration backgroundLockLatency;
  final Widget Function(Object? arg) builder;
  // final CheckStatusEntity? checkStatusEntity;
  // This widget is the root of your application.
  // final String destination;
  final bool enabled;
  final Widget lockScreen;

  @override
  State<RootApp> createState() => _RootAppState();

  static _RootAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_RootAppState>();

  static Stream<Locale> setLocale(bool language) {
    language
        ? localeSubject.sink.add(Locale('en', 'US'))
        : localeSubject.sink.add(Locale('th', 'TH'));
    debugPrint("SetLocale ${language ? 'en' : 'th'}");
    return localeSubject.stream.distinct();
  }

  // static void saveLocaleToLanguage(Locale? locale) {
  //   bool language = false;
  //   if (locale?.languageCode.toLowerCase() ==
  //       Locale('en', 'US').languageCode.toLowerCase()) {
  //     language = true;
  //   }
  //   JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  //   debugPrint("languageBeforesave $language");
  //   jupiterPrefsAndAppData.saveSettingLanguage(language);
  // }
}

class _RootAppState extends State<RootApp> with WidgetsBindingObserver {
  bool isConnect = false;
  //todo test if it update value if not on build
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  bool? language = false;
  String? pinCode = '';
  static final GlobalKey<NavigatorState> _navigatorKey =
      getIt<NavigationService>().navigatorKey;
  Timer? _backgroundLockLatencyTimer;
  String? _destination = RouteNames.login;
  late bool _didUnlockForAppLaunch;
  late bool _enabled;
  late bool _isLocked;
  bool _onStart = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('AppState $state');
    debugPrint('AppState _didUnlockForAppLaunch $_didUnlockForAppLaunch');
    debugPrint('AppState _isLocked $_isLocked');
    debugPrint('AppState _enabled $_enabled');

    if (!_enabled) {
      return;
    }

    if (state == AppLifecycleState.paused &&
        (!_isLocked && _didUnlockForAppLaunch)) {
      _backgroundLockLatencyTimer =
          Timer(widget.backgroundLockLatency, () async {
        debugPrint('ShowLockScreen');
        await checkUpdateApp();
        jupiterPrefsAndAppData.setIsLocked(true);
        bool isLocked = await jupiterPrefsAndAppData.getIsLocked();
        debugPrint('SHOW LOCK SCREEN IS LOCKED VALUE : ${isLocked}');
        showLockScreen(
            replace: false,
            destination: _destination ?? RouteNames.login,
            onStart: _onStart);
      });
    }

    if (state == AppLifecycleState.resumed) {
      _backgroundLockLatencyTimer?.cancel();
      checkUpdateApp();
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _backgroundLockLatencyTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // FirebaseLog.logPage(this);
    WidgetsBinding.instance.addObserver(this);
    _didUnlockForAppLaunch = !widget.enabled;
    _isLocked = false;
    _enabled = widget.enabled;
    debugPrint("initLanguage Before $language");
    initPincode();
    initLanguage();
    super.initState();
    setState(() {});
  }

  Future<void> initLanguage() async {
    language = jupiterPrefsAndAppData.language;
    // RootApp.setLocale(language ?? false);
    debugPrint("initLanguage $language");
    setState(() {});
  }

  Future<void> initPincode() async {
    pinCode = jupiterPrefsAndAppData.pinCode;
    // pinCode = null;
  }

  Future<void> checkUpdateApp() async {
    bool isUpdate = await Utilities.checkVersionApp();
    if (isUpdate) {
      await Utilities.popupUpdate(() {});
    }
  }

  /// Causes `AppLock` to either pop the [lockScreen] if the app is already running
  /// or instantiates widget returned from the [builder] method if the app is cold
  /// launched.
  ///
  /// [args] is an optional argument which will get passed to the [builder] method
  /// when built. Use this when you want to inject objects created from the
  /// [lockScreen] in to the rest of your app so you can better guarantee that some
  /// objects, services or databases are already instantiated before using them.
  void didUnlock([Object? args]) {
    if (_didUnlockForAppLaunch) {
      _didUnlockOnAppPaused();
    } else {
      _didUnlockOnAppLaunch(args);
    }
  }

  /// Makes sure that [AppLock] shows the [lockScreen] on subsequent app pauses if
  /// [enabled] is true of makes sure it isn't shown on subsequent app pauses if
  /// [enabled] is false.
  ///
  /// This is a convenience method for calling the [enable] or [disable] method based
  /// on [enabled].
  void setEnabled(bool enabled) {
    if (enabled) {
      enable();
    } else {
      disable();
    }
  }

  /// Makes sure that [AppLock] shows the [lockScreen] on subsequent app pauses.
  void enable() {
    setState(() {
      _enabled = true;
    });
  }

  /// Makes sure that [AppLock] doesn't show the [lockScreen] on subsequent app pauses.
  void disable() {
    setState(() {
      _enabled = false;
    });
  }

  /// Manually show the [lockScreen].
  void showLockScreen(
      {required bool replace,
      required String destination,
      required bool onStart}) {
    debugPrint('ShowLockScreenReplace $replace');
    _destination = destination;
    _onStart = onStart;
    _isLocked = true;
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (replace) {
        _navigatorKey.currentState!
            .pushReplacementNamed(RouteNames.lock_screen_jupiter);
      } else {
        _navigatorKey.currentState!.pushNamed(RouteNames.lock_screen_jupiter);
      }
    });
    // return _navigatorKey.currentState!
    //     .pushNamed(RouteNames.lock_screen_jupiter);
  }

  Widget get _lockScreen {
    return PopScope(
      child: widget.lockScreen,
      onPopInvoked: (didPop) {},
      canPop: false,
    );
    // return widget.lockScreen;
  }

  void _didUnlockOnAppLaunch(Object? args) {
    if (_onStart) {
      args = {"validated": true, "destination": _destination};
    }
    debugPrint('_didUnlockOnAppLaunch');
    _didUnlockForAppLaunch = true;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _isLocked = false;
      jupiterPrefsAndAppData.setIsLocked(_isLocked);
      _navigatorKey.currentState!.pushReplacementNamed(
          RouteNames.unlock_screen_jupiter,
          arguments: args);
    });
  }

  void _didUnlockOnAppPaused() {
    debugPrint('_didUnlockOnAppPaused');
    _isLocked = false;
    jupiterPrefsAndAppData.setIsLocked(_isLocked);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // Navigator.pop(context);
      if (_navigatorKey.currentState?.canPop() ?? false) {
        _navigatorKey.currentState!.pop();
        debugPrint('_didUnlockOnAppPaused CanPop');
      } else {
        // SchedulerBinding.instance.addPostFrameCallback((_) {
        debugPrint('_didUnlockOnAppPaused MainMenu');
        _navigatorKey.currentState!.pushReplacementNamed(RouteNames.mainmenu);
        // });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    jupiterPrefsAndAppData = getIt();
    language = jupiterPrefsAndAppData.language;
    pinCode = jupiterPrefsAndAppData.pinCode;
    debugPrint("RootAppBuildCall");

    debugPrint(
        "RootAppBuildCall refreshToken: ${jupiterPrefsAndAppData.refreshToken}");
    debugPrint("RootAppBuildCall username: ${jupiterPrefsAndAppData.username}");
    debugPrint("RootAppBuildCall pinCode: ${jupiterPrefsAndAppData.pinCode}");
    debugPrint(
        "RootAppBuildCall notification: ${jupiterPrefsAndAppData.notification}");
    debugPrint("RootAppBuildCall language: ${jupiterPrefsAndAppData.language}");
    final localizationDelegate = LocalizedApp.of(context).delegate;

    // debugPrint('destination ${widget.destination}');
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    FlutterNativeSplash.remove();
    return StreamBuilder<Locale>(
        stream: RootApp.setLocale(language ?? false),
        // initialData: Locale('th', 'TH'),
        builder: (context, snapshot) {
          debugPrint("LocaleSnap ${snapshot.data}");
          debugPrint("LocaleSnap ${snapshot.data.runtimeType}");

          return LocalizationProvider(
            state: LocalizationProvider.of(context).state,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => getIt<RegisterCubit>()),
                BlocProvider(create: (context) => getIt<LoginCubit>()),
                BlocProvider(create: (context) => getIt<MapCubit>()),
                BlocProvider(create: (context) => getIt<StationDetailsCubit>()),
                BlocProvider(
                    create: (context) => getIt<CustomAppBarWithSearchCubit>()),
                BlocProvider(create: (context) => getIt<CheckInCubit>()),
                BlocProvider(
                    create: (context) => getIt<ChargingRealtimeCubit>()),
                BlocProvider(create: (context) => getIt<HomeCubit>()),
                BlocProvider(create: (context) => getIt<ScanQrCodeCubit>()),
                BlocProvider(create: (context) => getIt<MainMenuCubit>()),
                BlocProvider(create: (context) => getIt<ProfileCubit>()),
                BlocProvider(create: (context) => getIt<ProfileEditCubit>()),
                BlocProvider(create: (context) => getIt<PaymentCubit>()),
                BlocProvider(create: (context) => getIt<PaymentDetailCubit>()),
                BlocProvider(create: (context) => getIt<EvInformationCubit>()),
                BlocProvider(
                    create: (context) => getIt<EvInformationAddCubit>()),
                BlocProvider(create: (context) => getIt<PaymentKBankCubit>()),
                BlocProvider(create: (context) => getIt<HistoryCubit>()),
                BlocProvider(create: (context) => getIt<HistoryDetailCubit>()),
                BlocProvider(create: (context) => getIt<StatusChargingCubit>()),
                BlocProvider(create: (context) => getIt<ReceiptSuccessCubit>()),
                BlocProvider(create: (context) => getIt<ForgotPasswordCubit>()),
                BlocProvider(
                    create: (context) => getIt<FavoriteStationCubit>()),
                BlocProvider(
                    create: (context) => getIt<ProfileAddTaxInvoiceCubit>()),
                BlocProvider(create: (context) => getIt<ForgotPincodeCubit>()),
                BlocProvider(create: (context) => getIt<CouponCubit>()),
                BlocProvider(create: (context) => getIt<CouponDetailCubit>()),
                BlocProvider(create: (context) => getIt<CouponSearchCubit>()),
                BlocProvider(create: (context) => getIt<BookingCubit>()),
                BlocProvider(create: (context) => getIt<UpdatePasswordCubit>()),
                BlocProvider(create: (context) => getIt<DeleteAccountCubit>()),
                BlocProvider(create: (context) => getIt<FleetCubit>()),
                BlocProvider(create: (context) => getIt<NotiCubit>()),
                BlocProvider(create: (context) => getIt<PolicyCubit>()),
                BlocProvider(create: (context) => getIt<SettingPrivacyCubit>()),
                BlocProvider(
                    create: (context) => getIt<NotificationHomePageCubit>()),
                BlocProvider(
                    create: (context) => getIt<AdvertisementHomePageCubit>()),
                BlocProvider(
                    create: (context) => getIt<RecommendedStationCubit>()),
                BlocProvider(create: (context) => getIt<OcrCubit>()),
                BlocProvider(create: (context) => getIt<SelectVehicleCubit>()),
                BlocProvider(create: (context) => getIt<RoutePlannerCubit>()),
                BlocProvider(create: (context) => getIt<NotiSettingCubit>()),
                BlocProvider(
                    create: (context) => getIt<NotificationDetailCubit>()),
              ],
              child: MaterialApp(
                builder: (BuildContext context, Widget? child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                        textScaleFactor: textScaleFactor <= 1.15
                            ? textScaleFactor
                            : 1.15), // Set a fixed text scale factor
                    child: child!,
                  );
                },
                navigatorKey: _navigatorKey, // GlobalKey()
                title: 'Jupiter',
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  localizationDelegate
                ],
                supportedLocales: localizationDelegate.supportedLocales,
                // locale: localizationDelegate.fallbackLocale,
                locale: snapshot.data,
                // locale: localizationDelegate.currentLocale,
                // theme: ThemeData(primarySwatch: Colors.grey),
                // theme: ThemeData.light(useMaterial3: true),
                // theme: ThemeData.light(),
                theme: ThemeData(
                  useMaterial3: false,
                  fontFamily: 'DBHelvethaica',
                  pageTransitionsTheme: PageTransitionsTheme(builders: {
                    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                  }),
                ),
                initialRoute: RouteNames.splash_screen,
                // onGenerateInitialRoutes: (initialRoute) {
                //   return [initRoute(initialRoute)];
                //   // return [initRoute(initialRoute)];
                // },

                routes: {
                  RouteNames.login: (context) => const LoginPage(),
                  RouteNames.register: (context) => RegisterPage(),
                  // RouteNames.home: (context) => HomePage(),
                  RouteNames.mainmenu: (context) => MainMenuPage(),
                  RouteNames.map: (context) => const MapPage(),

                  RouteNames.scan_qrcode: (context) => const ScanQRCodePage(),
                  RouteNames.ev_information: (context) =>
                      const EvInformationPage(),
                  RouteNames.ev_information_add: (context) =>
                      const EvInformationAddPage(),
                  RouteNames.coupon: (context) => const CouponPage(),
                  RouteNames.favorite: (context) => const FavoriteStation(),
                  RouteNames.notification: (context) =>
                      const NotificationPage(),
                  RouteNames.payment: (context) => const PaymentPage(),
                  RouteNames.profile_edit: (context) => const ProfileEditPage(),
                  RouteNames.payment_kbank: (context) =>
                      const PaymentKBankPage(appBar: true),
                  RouteNames.forgot_password: (context) =>
                      const ForgotPasswordPage(),

                  RouteNames.jupiter_charging_check_in_device: (context) =>
                      const JupiterChargingCheckInDevicePage(),
                  RouteNames.setting_privacy: (context) =>
                      const SettingPrivacyPage(),
                  RouteNames.lock_screen_jupiter: (context) => _lockScreen,
                  RouteNames.unlock_screen_jupiter: (context) => widget
                      .builder(ModalRoute.of(context)!.settings.arguments),
                  RouteNames.create_pincode: (context) =>
                      const CreatePinCodePage(),
                  RouteNames.update_pincode: (context) =>
                      const UpdatePinCodePage(),
                  RouteNames.forgot_pincode: (context) =>
                      const ForgotPinCodeVerifyOTP(),
                  RouteNames.fleet_card: (context) =>
                      const FleetPage(fleetType: FleetType.CARD),
                  RouteNames.fleet_operation: (context) =>
                      const FleetPage(fleetType: FleetType.OPERATION),
                  RouteNames.splash_screen: (context) =>
                      const SplashScreenPage(),
                },

                onGenerateRoute: (settings) {
                  debugPrint('SettingName ${settings.name}');
                  switch (settings.name) {
                    case RouteNames.station_details:

                      // Cast the arguments to the correct
                      // type: ScreenArguments.
                      if (settings.arguments != null) {
                        final args =
                            settings.arguments as StationDetailArguments;

                        // Then, extract the required data from
                        // the arguments and pass the data to the
                        // correct screen.
                        return MaterialPageRoute(
                          builder: (context) {
                            return StationDetailPage(
                              stationId: args.stationId,
                            );
                          },
                        );
                      } else {
                        return null;
                      }

                    default:
                      return null;
                  }
                },
              ),
            ),
          );
        });
  }
}
