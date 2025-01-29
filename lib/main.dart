import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter/src/presentation/pages/splash_screen/check_status_charging.dart';
import 'package:jupiter_api/data/data_models/request/validated_pin_model.dart';
import 'package:jupiter/src/injection.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:jupiter/src/presentation/pages/index.dart';
import 'src/presentation/pages/lock_screen/lock_screen.dart';
import 'src/root_app.dart';
import 'src/route_names.dart';

Future<void> main() async {
  // enableFlutterDriverExtension();
  DartPingIOS.register();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();

  // WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await startJupiter();
}

Future<void> startJupiter() async {
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  await jupiterPrefsAndAppData.initSharePrefsValue();
  bool? language = jupiterPrefsAndAppData.language;
  debugPrint("startJupiterLang $language");

  final delegate = await LocalizationDelegate.create(
    basePath: 'assets/i18n/',
    fallbackLocale: language ?? false ? 'en_US' : 'th_TH',
    supportedLocales: ['en_US', 'th_TH'],
  );

  runApp(
    LocalizedApp(
      delegate,
      RootApp(
        enabled: true,
        builder: (arg) {
          debugPrint("deti $arg");
          ValidatedPinModel validated =
              ValidatedPinModel.fromJson(arg as Map<String, dynamic>);
          CheckStatusChargingData checkStatusChargingData = getIt();
          debugPrint(
              "deti checkStatusChargingData ${checkStatusChargingData.checkStatusEntity}");
          switch (validated.destination) {
            case RouteNames.login:
              debugPrint("deti validated $validated");
              return LoginPage(
                key: Key("LoginPage"),
              );
            case RouteNames.mainmenu:
              return MainMenuPage(
                key: Key("MainMenuPage"),
                isOpenFirstTime: true,
              );
            default:
              return LoginPage(
                key: Key("LoginPage"),
              );
          }
        },
        lockScreen: LockScreen(),
        backgroundLockLatency: Duration(seconds: 30),
      ),
    ),
  );
}


// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

