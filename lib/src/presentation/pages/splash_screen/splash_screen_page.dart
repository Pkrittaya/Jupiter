import 'dart:io';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/config/api/api_firebase.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/firebase_log.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/internet_check.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter/src/navigation_service.dart';
import 'package:jupiter/src/presentation/pages/splash_screen/check_status_charging.dart';
import 'package:jupiter/src/root_app.dart';
import 'package:jupiter/src/route_names.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/data/data_models/request/status_charger_form.dart';
import 'package:jupiter_api/data/dio_config/dio_util.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final GlobalKey<NavigatorState> _navigatorKey =
      getIt<NavigationService>().navigatorKey;
  var stopwatch = Stopwatch();
  InternetCheck internetCheck = getIt();
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();

  @override
  void initState() {
    super.initState();
    initSplash();
    stopwatch.start();
    debugPrint(
        "SplashData RefreshToken : ${jupiterPrefsAndAppData.refreshToken}");
    debugPrint("SplashData language : ${jupiterPrefsAndAppData.language}");
    debugPrint("SplashData pinCode : ${jupiterPrefsAndAppData.pinCode}");
    debugPrint("SplashData username : ${jupiterPrefsAndAppData.username}");
    debugPrint(
        "SplashData notification : ${jupiterPrefsAndAppData.notification}");
  }

  Future<void> initSplash() async {
    String appVersion =
        '${FirebaseLog.appVersionName} (${FirebaseLog.appVersionCode})';
    String platform = await FirebaseLog.getDevicePlatform();
    String model = await FirebaseLog.getDeviceModel();
    String osVersion = await FirebaseLog.getDeviceOSVersion();
    bool isConnect = await internetCheck.checkConnectInternet();
    DioUtil.configDefaultParam(
      username: jupiterPrefsAndAppData.username ?? 'N/A',
      orgCode: ConstValue.orgCode,
      deviceCode: jupiterPrefsAndAppData.deviceId,
      platform: platform,
      model: model,
      osVersion: osVersion,
      appVersion: appVersion,
    );
    jupiterPrefsAndAppData.setHasInitNotification(true);
    if (isConnect) {
      await Firebase.initializeApp();
      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };
      // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        dynamic e = error;
        FirebaseLog.sendCrashToLog(
          title: e,
          message: e,
          stack: '${stack.toString()}',
        );
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      String? refreshToken = jupiterPrefsAndAppData.refreshToken;
      String? pinCode = jupiterPrefsAndAppData.pinCode;
      debugPrint("RefreshToken $refreshToken");
      // useFunctionSetInitialNotification();
      await checkStatusCharging(refreshToken, pinCode);
    } else {
      Utilities.alertOneButtonAction(
        context: context,
        type: AppAlertType.DEFAULT,
        isForce: true,
        title: translate('alert.title.default'),
        description: translate('alert.description.internet'),
        textButton: translate('button.Ok'),
        onPressButton: () {
          Navigator.of(context).pop();
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        },
      );
    }
  }

  @override
  void dispose() {
    stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: AppTheme.white,
      child: Image.asset(
        ImageAsset.splash_screen_gif,
        fit: BoxFit.cover,
      ),
    );
  }

  Future<void> useFunctionSetInitialNotification() async {
    bool? isSettingNotificationOpen = jupiterPrefsAndAppData.notification;
    if (isSettingNotificationOpen == true ||
        isSettingNotificationOpen == null) {
      jupiterPrefsAndAppData.saveSettingNotification(true);
      ApiFirebase apiFirebase = ApiFirebase();
      await apiFirebase.initNotifications();
      apiFirebase.firebaseListenMessaging();
      apiFirebase.firebaseListenMessageOpenApp();
    }
  }

  Future<void> delayAndGo(String destination, int delayTime) async {
    // set time to go which use time of load or gif depend on which slower
    int delayMiliseconds = delayTime;
    if (stopwatch.elapsed.inMilliseconds > delayMiliseconds) {
      delayMiliseconds = 0;
    }
    await Future.delayed(Duration(milliseconds: delayMiliseconds));
    debugPrint("Destination $destination");
    if (destination == RouteNames.mainmenu) {
      // _navigatorKey.currentState?.pushReplacementNamed(destination);
      RootApp.of(context)?.showLockScreen(
          replace: true, destination: destination, onStart: true);
    } else {
      _navigatorKey.currentState?.pushReplacementNamed(destination);
    }
  }

  Future<void> goDestination(String destination) async {
    debugPrint("Destination ${stopwatch.elapsed.inMilliseconds}");
    bool isUpdate = await Utilities.checkVersionApp();
    debugPrint("isUpdate $isUpdate");
    if (isUpdate) {
      Utilities.popupUpdate(
        () {
          delayAndGo(destination, 0);
        },
      );
    } else {
      delayAndGo(destination, 0);
    }
  }

  Future<bool> checkStatusCharging(
      String? refreshToken, String? pinCode) async {
    useFunctionSetInitialNotification();
    UserManagementUseCase useCase = getIt();
    debugPrint("refreshT : $refreshToken");
    String destination = RouteNames.login;
    if ((refreshToken ?? '').isEmpty) {
      destination = RouteNames.login;
      goDestination(destination);
      //not login cannot lock
    } else if ((pinCode ?? '').isEmpty) {
      destination = RouteNames.create_pincode;
      goDestination(destination);
    } else {
      // RootApp.of(context)?.setEnabled(true);
      Utilities.requestAccessToken(
        useCase,
        ({required accessToken, required deviceCode, required username}) async {
          try {
            final result = await useCase.statusCharging(
                accessToken,
                StatusChargerForm(
                    deviceCode: deviceCode,
                    username: username,
                    orgCode: ConstValue.orgCode));

            result.fold(
              (failure) {
                debugPrint("statusCharging Failure");
                debugPrint("statusCharging Failure message ${failure.message}");
                destination = RouteNames.mainmenu;
                goDestination(destination);
              },
              (dataStatusCharging) async {
                debugPrint("statusCharging Success");
                destination = RouteNames.mainmenu;
                CheckStatusChargingData chargingData = getIt();
                chargingData.checkStatusEntity = dataStatusCharging;
                debugPrint(
                    "statusCharging Success ${chargingData.checkStatusEntity?.chargingStatus}");
                goDestination(destination);

                // }
              },
            );
          } catch (e) {
            destination = RouteNames.mainmenu;
            goDestination(destination);
          }
        },
        "StatusChargingMain",
        () {
          destination = RouteNames.login;
          goDestination(destination);
        },
      );
    }

    return true;
  }
}
