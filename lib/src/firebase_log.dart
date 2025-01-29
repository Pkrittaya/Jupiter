import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/widgets.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter_api/data/data_models/request/log_crash_device_info_form.dart';
import 'package:jupiter_api/data/data_models/request/log_crash_form.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:ios_utsname_ext/extension.dart';

class FirebaseLog {
  static const String appVersionName = String.fromEnvironment('VERSION_NAME');
  static const String appVersionCode = String.fromEnvironment('VERSION_CODE');
  static void logPage(dynamic className) {
    debugPrint("FirebaseLog : ${className.runtimeType.toString()}");
    FirebaseCrashlytics.instance.log(className.runtimeType.toString());
  }

  static String getDevicePlatform() {
    if (Platform.isAndroid)
      return 'Android';
    else if (Platform.isIOS)
      return 'iOS';
    else
      return '${Platform.operatingSystem}';
  }

  static Future<String> getDeviceOSVersion() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;
      return 'Android $release (SDK $sdkInt)';
      // Android 9 (SDK 28)
    } else if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var systemName = iosInfo.systemName;
      var version = iosInfo.systemVersion;
      // iOS 13.1,
      return '$systemName $version';
    } else
      return 'Unknown';
  }

  static Future<String> getDeviceModel() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var manufacturer = androidInfo.manufacturer;
      var model = androidInfo.model;
      // Xiaomi Redmi Note 7
      return '$manufacturer $model';
    } else if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var name = iosInfo.utsname.machine.iOSProductName;
      // iPhone 11 Pro Max
      return '$name';
    } else
      return 'Unknown';
  }

  static String getFormatStackError(String stack) {
    try {
      if (stack == 'null') {
        return 'N/A';
      }
      String newStack = '';
      List<String> split = stack.split('#');
      int length = split.length < 5 ? split.length : 5;
      for (int i = 0; i < length; i++) {
        if (split[i] == '') {
          length = length + 1;
          continue;
        } else {
          newStack = newStack + '#${split[i].trim()}\n';
        }
      }
      return newStack;
    } catch (e) {
      return 'Unknown Crash';
    }
  }

  static String getFormatTitle(dynamic title) {
    try {
      return '${title.diagnostics != null ? title.diagnostics[0] : 'Flutter Error'}';
    } catch (e) {
      return 'Flutter Error';
    }
  }

  static String getFormatMessage(dynamic message) {
    try {
      return '${message.toString()}';
    } catch (e) {
      return 'N/A';
    }
  }

  static Future<void> sendCrashToLog({
    required dynamic title,
    required dynamic message,
    required String stack,
  }) async {
    UserManagementUseCase useCase = getIt();
    JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
    String? username = jupiterPrefsAndAppData.username ?? 'N/A';
    String? deviceCode = jupiterPrefsAndAppData.deviceId ?? '';
    // String? refreshToken = jupiterPrefsAndAppData.refreshToken;
    String platform = await getDevicePlatform();
    String model = await getDeviceModel();
    String osVersion = await getDeviceOSVersion();
    String newStack = getFormatStackError(stack);
    String newTitle = getFormatTitle(title);
    if (message == 'invalid payload') {
      return;
    }
    debugPrint('******************* sendCrashToLog *********************');
    debugPrint('title : ${newTitle}');
    debugPrint('message : ${getFormatMessage(message)}');
    debugPrint('stack : ${newStack}');
    debugPrint('********************************************************');
    final result = await useCase.addLog(
      LogCrashForm(
        orgCode: ConstValue.orgCode,
        username: username,
        title: newTitle,
        message: getFormatMessage(message),
        stack: newStack,
        deviceInfo: LogCrashDeviceInfoForm(
          deviceCode: deviceCode,
          platform: platform,
          model: model,
          osVersion: osVersion,
          appVersion: '${appVersionName} (${appVersionCode})',
        ),
      ),
    );
    result.fold(
      (failure) {
        debugPrint('FAILURE SEND CRASH LOG');
      },
      (data) async {
        debugPrint('SUCCESS SEND CRASH LOG');
      },
    );
  }
}
