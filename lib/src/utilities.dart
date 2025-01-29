import 'dart:async';
import 'dart:io';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter/src/presentation/pages/splash_screen/check_status_charging.dart';
import 'package:jupiter/src/presentation/status_charging/cubit/status_charging_cubit.dart';
import 'package:jupiter_api/data/data_models/request/request_access_key_form.dart';
import 'package:jupiter_api/data/data_models/request/status_charger_form.dart';
import 'package:jupiter_api/data/data_sources/helper/failure.dart';
import 'package:jupiter_api/domain/entities/check_status_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/navigation_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:toastification/toastification.dart';
import 'dart:ui' as ui;
import 'package:url_launcher/url_launcher.dart';
// import 'config/api/api_config.dart';
// import 'data/data_models/request/request_access_key_form.dart';
// import 'data/data_sources/helper/failure.dart';
import 'presentation/widgets/text_label.dart';
import 'root_app.dart';
import 'route_names.dart';

class Utilities {
  static bool isForce = false;
  static JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  static String versionFromFirebase = '';

  static bool canPop(BuildContext context) {
    final NavigatorState? navigator = Navigator.maybeOf(context);
    return navigator != null && navigator.canPop();
  }

  static void popNavigator(BuildContext context) {
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop();
    }
  }

  static LatLng createPositionLatLng(List<double> position) {
    // debugPrint('Create PositionLatlng Start');
    if (position.isNotEmpty) {
      if (position.length == 2) {
        // debugPrint('Create PositionLatlng ${position[0]}   ${position[1]}');
        return LatLng(position[0], position[1]);
      }
    }

    return const LatLng(0, 0);
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  static Future<Uint8List> getUint8ListFromWidget(
      Uint8List? bytes, int width) async {
    ui.Codec codec = await ui.instantiateImageCodec(bytes!, targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  static Future<Uint8List> captureWidget(
      GlobalKey globalKeys, int markerone) async {
    int delay = 0;
    if (markerone <= 0) {
      delay = 100;
    } else {
      delay = 0;
    }
    return new Future.delayed(Duration(milliseconds: delay), () async {
      RenderRepaintBoundary boundary = globalKeys.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      return pngBytes;
    });
  }

  static Future<BitmapDescriptor> statusPinIcon(
      Uint8List? bytes, int size) async {
    final Uint8List markerIcon =
        await Utilities.getUint8ListFromWidget(bytes, size);

    return BitmapDescriptor.fromBytes(markerIcon);
  }

  static Future<BitmapDescriptor> avaliablePinIcon(int size) async {
    final Uint8List markerIcon =
        await Utilities.getBytesFromAsset(ImageAsset.pin_ava, size);

    return BitmapDescriptor.fromBytes(markerIcon);
  }

  static Future<BitmapDescriptor> occupiedPinIcon(int size) async {
    final Uint8List markerIcon =
        await Utilities.getBytesFromAsset(ImageAsset.pin_occu, size);

    return BitmapDescriptor.fromBytes(markerIcon);
  }

  static Future<BitmapDescriptor> imagePinIcon(int size, String path) async {
    final Uint8List markerIcon = await Utilities.getBytesFromAsset(path, size);

    return BitmapDescriptor.fromBytes(markerIcon);
  }

  static Future<Position> getUserCurrentLocation(
      {bool isAlertPermission = true}) async {
    await Geolocator.requestPermission().then((value) async {
      debugPrint('requestThen ${value.toString()}');
      if (value == LocationPermission.deniedForever) {
        final NavigationService navigationService = getIt<NavigationService>();
        if (isAlertPermission) {
          alertOneButtonAction(
            context: navigationService.navigatorKey.currentContext!,
            type: AppAlertType.DEFAULT,
            isForce: false,
            title: translate('alert_permission_location.title'),
            description: translate('alert_permission_location.description'),
            textButton: translate('button.Ok'),
            onPressButton: () {
              Navigator.pop(navigationService.navigatorKey.currentContext!);
            },
          );
        }
      }
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      debugPrint('ERROR ${error.toString()}');
    });
    return await Geolocator.getCurrentPosition();
  }

  static Future<String> getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    final allInfo = deviceInfo.data;
    debugPrint('AllInfo $allInfo');

    return '';
  }

  static void logout(BuildContext context) async {
    jupiterPrefsAndAppData.saveRefreshToken('');
    jupiterPrefsAndAppData.saveUsername('');
    jupiterPrefsAndAppData.removePinCode();
    jupiterPrefsAndAppData.removeNotiToken();
    CheckStatusChargingData checkStatusChargingData = getIt();
    CheckStatusEntity data = CheckStatusEntity(
      chargingStatus: false,
      data: null,
      informationCharger: null,
    );
    checkStatusChargingData.checkStatusEntity = data;
    // Utilities.saveSettingFaceOrTouchId(false);
    RootApp.of(context)?.disable();
    Navigator.pushNamedAndRemoveUntil(
        context, RouteNames.login, ModalRoute.withName('/login'));
    // Navigator.pushReplacementNamed(context, RouteNames.login);
  }

  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  static void mapNavigateTo(double lat, double lng) async {
    var uri = Uri.parse('');
    if (Platform.isIOS) {
      uri = Uri.parse(
          'comgooglemaps:\/\/?saddr=&daddr=$lat,$lng&directionsmode=driving');
    } else {
      uri = Uri.parse('google.navigation:q=$lat,$lng&mode=d');
    }
    // var uri = Uri.parse('google.navigation:q=$lat,$lng&mode=d');
    // var uri = Uri.parse(
    //     'comgooglemaps:\/\/?saddr=&daddr=$lat,$lng&directionsmode=driving');

    // var uri =
    //     Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      final NavigationService navigationService = getIt<NavigationService>();
      BuildContext context = navigationService.navigatorKey.currentContext!;
      alertOneButtonAction(
        context: context,
        type: AppAlertType.DEFAULT,
        isForce: true,
        title: translate('alert_can_not_navigate_map.title'),
        description: translate('alert_can_not_navigate_map.description'),
        textButton: translate('button.Ok'),
        onPressButton: () {
          Navigator.pop(context);
        },
      );
      // throw 'Could not launch ${uri.toString()}';
    }
  }

  static void mapRoutePolylinesNavigateTo(String waypoint) async {
    var uri = Uri.parse('');
    if (Platform.isIOS) {
      uri = Uri.parse('comgooglemaps:\/\/?$waypoint&directionsmode=driving');
    } else {
      uri = Uri.parse('google.navigation:q=$waypoint&mode=d');
    }
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      final NavigationService navigationService = getIt<NavigationService>();
      BuildContext context = navigationService.navigatorKey.currentContext!;
      alertOneButtonAction(
        context: context,
        type: AppAlertType.DEFAULT,
        isForce: true,
        title: translate('alert_can_not_navigate_map.title'),
        description: translate('alert_can_not_navigate_map.description'),
        textButton: translate('button.Ok'),
        onPressButton: () {
          Navigator.pop(context);
        },
      );
      // throw 'Could not launch ${uri.toString()}';
    }
  }

  static void onBirthDayTap(
    BuildContext context, {
    required TextEditingController textField,
    String? format = 'dd/MM/yyyy',
  }) async {
    final date = textField.text == ''
        ? DateTime.now()
        : DateFormat(format).parse(textField.text);
    final result = await _showCalendarPicker(context, date);
    textField.text = DateFormat(format).format(result);
  }

  static String durationToHms(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

  static double sizeFontWithDesityForDisplay(
      BuildContext context, double size) {
    Size mediaSize = MediaQuery.of(context).size;
    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    double aspectRatio = mediaSize.aspectRatio;
    // double width = mediaSize.width;
    // double height = mediaSize.height;
    // double hw = height / width;
    // double hwD = hw * aspectRatio;
    // debugPrint(
    //     'Size: $size devicePixelRation $devicePixelRatio  aspectRaio $aspectRatio');
    // debugPrint('Width $width height $height   hw $hw  hwD $hwD');
    // debugPrint(
    //     'Width ${(width * devicePixelRatio) / ((devicePixelRatio / aspectRatio) * size)}');

    // double font = (size / (devicePixelRatio / 1.2)) / aspectRatio;

    if (Platform.isIOS) {
      if (devicePixelRatio < 3) {
        devicePixelRatio = 3;
      }
      double font = ((size + 5) / (devicePixelRatio)) / aspectRatio;
      return aspectRatio > 0.5 ? size : font;
    } else {
      return size * .90;
    }
  }

  static void requestAccessToken(
      UserManagementUseCase useCase,
      void Function({
        required String accessToken,
        required String deviceCode,
        required String username,
      }) requestNext,
      String serviceName,
      [void Function()? desTo]) async {
    String? username = jupiterPrefsAndAppData.username;
    String? deviceCode = jupiterPrefsAndAppData.deviceId;
    String? refreshToken = jupiterPrefsAndAppData.refreshToken;
    debugPrint('requestAccessTokenUtil $serviceName: $refreshToken');
    debugPrint('requestAccessTokenUtil $serviceName: $username');
    debugPrint('requestAccessTokenUtil $serviceName: $deviceCode');
    if (refreshToken == '' || refreshToken == null) {
      return;
    }
    final NavigationService navigationService = getIt<NavigationService>();
    final result = await useCase.requestAccessToken(
      RequestAccessKeyForm(
        username: username ?? '',
        refreshToken: refreshToken ?? '',
        deviceCode: deviceCode ?? '',
        orgCode: ConstValue.orgCode,
      ),
    );
    result.fold((failure) {
      debugPrint('requestAccessTokenUtil $serviceName:  Failure');
      if (serviceName != 'StatusChargingMain') {
        if (failure is UnAuthorizeFailure) {
          debugPrint('requestAccessTokenUtil is UnAuthorizeFailure');
          BuildContext context = navigationService.navigatorKey.currentContext!;
          try {
            jupiterPrefsAndAppData.saveRefreshToken('');
            jupiterPrefsAndAppData.removePinCode();
            Utilities.dialogIsVisible(context);
          } catch (e) {}
          alertOneButtonAction(
            context: context,
            type: AppAlertType.DEFAULT,
            isForce: true,
            title: translate('session_expire.session_expired'),
            description: translate('session_expire.please_login'),
            textButton: translate('button.Ok'),
            onPressButton: () {
              while (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
              Navigator.of(context).pushReplacementNamed(RouteNames.login);
            },
          );
        } else if (failure is ConnectionFailure) {
          BuildContext context = navigationService.navigatorKey.currentContext!;
          alertOneButtonAction(
            context: context,
            type: AppAlertType.DEFAULT,
            isForce: true,
            title: translate('alert.title.default'),
            description: translate('alert.description.internet'),
            textButton: translate('button.Ok'),
            onPressButton: () {
              Navigator.of(context).pop();
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
          );
        } else if (failure is ServerFailure) {
          BuildContext context = navigationService.navigatorKey.currentContext!;
          alertOneButtonAction(
            context: context,
            type: AppAlertType.DEFAULT,
            isForce: true,
            title: translate('alert.title.default'),
            description: translate('alert.description.server_error'),
            textButton: translate('button.Ok'),
            onPressButton: () {
              Navigator.of(context).pop();
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
          );
        } else {
          BuildContext context = navigationService.navigatorKey.currentContext!;
          alertOneButtonAction(
            context: context,
            type: AppAlertType.DEFAULT,
            isForce: true,
            title: translate('alert.title.default'),
            description: translate('alert.description.default'),
            textButton: translate('button.Ok'),
            onPressButton: () {
              Navigator.of(context).pop();
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
          );
        }
        debugPrint('requestAccessTokenUtil FailureType ${failure.runtimeType}');
      } else {
        debugPrint(
            'refreshToken : ${jupiterPrefsAndAppData.getRefreshToken()}');
        debugPrint('StatusCharging : StartJupiter');
        jupiterPrefsAndAppData.saveRefreshToken('');
        jupiterPrefsAndAppData.removePinCode();
        desTo?.call();
      }
    }, (data) async {
      requestNext.call(
        accessToken: data.token.accessToken,
        deviceCode: deviceCode ?? '',
        username: username ?? '',
      );
      debugPrint('requestAccessTokenUtil  $serviceName:  Success ');
    });
  }

  // static void alertSessionExpired(BuildContext context) {
  //   final AlertDialog dialog = AlertDialog(
  //     title: TextLabel(
  //       text: translate('session_expire.session_expired'),
  //       fontWeight: FontWeight.bold,
  //       fontSize: 20,
  //     ),
  //     content: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         const Icon(
  //           Icons.dns,
  //           color: Colors.red,
  //           size: 64,
  //         ),
  //         const SizedBox(height: 20),
  //         TextLabel(text: translate('session_expire.please_login'))
  //       ],
  //     ),
  //     actions: [
  //       Button(
  //         onPressed: () {
  //           Navigator.pushNamedAndRemoveUntil(context, RouteNames.login,
  //               ModalRoute.withName(RouteNames.login));
  //         },
  //         text: translate('button.Ok'),
  //       ),
  //     ],
  //   );
  //   showDialog<void>(context: context, builder: (context) => dialog);
  // }

  static void alertOneButtonAction({
    required BuildContext context,
    required String type,
    required String title,
    required String description,
    required String textButton,
    required Function() onPressButton,
    required bool isForce,
    TextAlign? textAlign,
    void Function()? onDialogDissmiss,
  }) {
    double paddingSize = 24;
    Color colorButton = AppTheme.blueD;
    String icon = ImageAsset.ic_alert_error;
    if (type == AppAlertType.DEFAULT) {
      colorButton = AppTheme.blueD;
      icon = ImageAsset.ic_alert_error;
    } else if ((type == AppAlertType.WARNING)) {
      colorButton = AppTheme.red;
      icon = ImageAsset.ic_alert_warning;
    } else if ((type == AppAlertType.SUCCESS)) {
      colorButton = AppTheme.blueD;
      icon = ImageAsset.ic_alert_success;
    } else {
      colorButton = AppTheme.blueD;
      icon = ImageAsset.ic_alert_error;
    }

    showDialog<void>(
      context: context,
      barrierDismissible: !isForce,
      builder: (BuildContext context) => PopScope(
        canPop: !isForce,
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          actionsAlignment: MainAxisAlignment.center,
          titlePadding: EdgeInsets.fromLTRB(paddingSize, 20, paddingSize, 0),
          contentPadding: EdgeInsets.fromLTRB(paddingSize, 8, paddingSize, 0),
          actionsPadding: EdgeInsets.fromLTRB(paddingSize, 16, paddingSize, 20),
          title: Center(
              child: Column(
            children: [
              Image.asset(
                icon,
              ),
              const SizedBox(height: 12),
              TextLabel(
                text: title,
                textAlign: TextAlign.center,
                color: AppTheme.black,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.title),
                fontWeight: FontWeight.w700,
              ),
            ],
          )),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: TextLabel(
                  text: description,
                  textAlign: TextAlign.center,
                  color: AppTheme.black,
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.normal),
                ),
              )
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: colorButton,
                      elevation: 0.0,
                      shadowColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(200)),
                      ),
                    ),
                    onPressed: () {
                      try {
                        onPressButton();
                      } catch (e) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: TextLabel(
                      text: textButton,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.normal),
                      fontWeight: FontWeight.w700,
                      color: AppTheme.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ).then((value) {
      debugPrint("dialogThen $isForce");
      onDialogDissmiss?.call();
    });
  }

  static void alertTwoButtonAction({
    required BuildContext context,
    required String type,
    required String title,
    required String description,
    required String textButtonLeft,
    required String textButtonRight,
    required Function() onPressButtonLeft,
    required Function() onPressButtonRight,
  }) {
    double paddingSize = 24;
    Color colorButton = AppTheme.blueD;
    String icon = ImageAsset.ic_alert_error;
    if (type == AppAlertType.DEFAULT) {
      colorButton = AppTheme.blueD;
      icon = ImageAsset.ic_alert_error;
    } else if ((type == AppAlertType.WARNING)) {
      colorButton = AppTheme.red;
      icon = ImageAsset.ic_alert_warning;
    } else if ((type == AppAlertType.SUCCESS)) {
      colorButton = AppTheme.blueD;
      icon = ImageAsset.ic_alert_success;
    } else {
      colorButton = AppTheme.blueD;
      icon = ImageAsset.ic_alert_error;
    }
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => PopScope(
        canPop: false,
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          actionsAlignment: MainAxisAlignment.center,
          titlePadding: EdgeInsets.fromLTRB(paddingSize, 20, paddingSize, 0),
          contentPadding: EdgeInsets.fromLTRB(paddingSize, 8, paddingSize, 0),
          actionsPadding: EdgeInsets.fromLTRB(paddingSize, 16, paddingSize, 20),
          title: Center(
              child: Column(
            children: [
              Image.asset(
                icon,
              ),
              const SizedBox(height: 12),
              TextLabel(
                text: title,
                color: AppTheme.black,
                textAlign: TextAlign.center,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.title),
                fontWeight: FontWeight.w700,
              ),
            ],
          )),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: TextLabel(
                  text: description,
                  textAlign: TextAlign.center,
                  color: AppTheme.black,
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.normal),
                ),
              )
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  // child: TextButton(
                  //   style: ButtonStyle(
                  //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  //       RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(200),
                  //         side: const BorderSide(color: AppTheme.blueD, width: 2),
                  //       ),
                  //     ),
                  //   ),
                  //   onPressed: onPressButtonLeft,
                  //   child: TextLabel(
                  //     text: textButtonLeft,
                  //     fontSize: Utilities.sizeFontWithDesityForDisplay(
                  //         context, AppFontSize.normal),
                  //     fontWeight: FontWeight.w700,
                  //     color: AppTheme.blueD,
                  //     overflow: TextOverflow.ellipsis,
                  //   ),
                  // ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: AppTheme.black5,
                      elevation: 0.0,
                      shadowColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(200)),
                      ),
                    ),
                    onPressed: () {
                      try {
                        onPressButtonLeft();
                      } catch (e) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: TextLabel(
                      text: textButtonLeft,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.normal),
                      fontWeight: FontWeight.w700,
                      color: AppTheme.gray9CA3AF,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(width: paddingSize / 2),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: colorButton,
                      elevation: 0.0,
                      shadowColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(200)),
                      ),
                    ),
                    onPressed: () {
                      try {
                        onPressButtonRight();
                      } catch (e) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: TextLabel(
                      text: textButtonRight,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.normal),
                      fontWeight: FontWeight.w700,
                      color: AppTheme.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  static Future<String> getVersionApp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionApp = packageInfo.version;
    return versionApp;
  }

  static bool dialogIsVisible(BuildContext context) {
    bool isVisible = false;
    Navigator.popUntil(context, (route) {
      isVisible = route is PopupRoute;
      return !isVisible;
    });
    return isVisible;
  }

  static Future<void> popupUpdate(Function() dialogDismiss) async {
    final NavigationService navigationService = getIt<NavigationService>();

    BuildContext context = navigationService.navigatorKey.currentContext!;
    debugPrint('checkVersionApp ${dialogIsVisible(context)}');

    // const androidUpdate = String.fromEnvironment(ConstValue.ANDROID_UPDATE);
    // const iosUpdate = String.fromEnvironment(ConstValue.IOS_UPDATE);
    debugPrint("AndroidUpdate : ${ConstValue.androidUpdate}");
    debugPrint("iOSUpdate : ${ConstValue.iosUpdate}");

    alertOneButtonAction(
      context: context,
      type: AppAlertType.DEFAULT,
      isForce: isForce,
      title: translate('update_version.title'),
      description: translate('update_version.description'),
      textButton: translate('button.Ok'),
      onPressButton: () {
        if (Platform.isAndroid || Platform.isIOS) {
          // final appId = Platform.isAndroid
          //     ? 'com.pttdigital.jupiter.store'
          //     : '6450412686';
          // final url = Uri.parse(
          //   Platform.isAndroid
          //       ? 'market://details?id=$appId'
          //       : 'https://apps.apple.com/app/id$appId',
          // );
          final url = Uri.parse(Platform.isAndroid
              ? ConstValue.androidUpdate
              : ConstValue.iosUpdate);
          debugPrint("UrlUpdate : $url");
          launchUrl(
            url,
            mode: LaunchMode.externalApplication,
          );
        }
      },
      onDialogDissmiss: !isForce ? dialogDismiss : () {},
    );
  }

  static Future<bool> checkVersionApp() async {
    debugPrint('checkVersionApp ');
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 3),
        minimumFetchInterval: const Duration(seconds: 3),
      ));
      await remoteConfig.fetchAndActivate();

      if (Platform.isIOS) {
        // versionFromFirebase = await remoteConfig.getString('iOSEnterprise');
        versionFromFirebase = await remoteConfig.getString('iOSVersion');
      } else if (Platform.isAndroid) {
        // versionFromFirebase = await remoteConfig.getString('AndroidEnterprise');
        versionFromFirebase = await remoteConfig.getString('AndroidVersion');
      }
      // isForce = await remoteConfig.getBool('isForceEnterprise');
      isForce = await remoteConfig.getBool('isForce');

      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      debugPrint('VersionPackage $appName');
      debugPrint('VersionPackage $packageName');
      debugPrint('VersionPackage $version');
      debugPrint('VersionPackage $buildNumber');
      var versionApp = version.split('.');
      var versionFirebase = versionFromFirebase.split('.');

      debugPrint('VersionIsForce $isForce');
      debugPrint('VersionPackage $versionApp');
      debugPrint('VersionPackage ${versionApp.length}');
      debugPrint('VersionPackageFirebase $versionFirebase');
      debugPrint('VersionPackageFirebase ${versionFirebase.length}');
      debugPrint(
          'Version 1 :${int.parse(versionApp[0]) <= int.parse(versionFirebase[0])}');
      debugPrint(
          'Version 2 :${int.parse(versionApp[1]) <= int.parse(versionFirebase[1])}');
      debugPrint(
          'Version 3 :${int.parse(versionApp[2]) < int.parse(versionFirebase[2])}');
      bool update = false;
      if (versionApp.length == 3 && versionFirebase.length == 3) {
        if (int.parse(versionApp[0]) <= int.parse(versionFirebase[0])) {
          debugPrint('CheckVersion1');
          if (int.parse(versionApp[1]) <= int.parse(versionFirebase[1])) {
            debugPrint('CheckVersion2');
            if (int.parse(versionApp[2]) < int.parse(versionFirebase[2])) {
              debugPrint('CheckVersion3');
              update = true;
              return update;
            }
          }
        }
      }
      return update;
    } on Exception {
      return false;
    }
  }

  static List<dynamic> generrateListDay() {
    List<dynamic> listDay = [];
    for (int i = 0; i < 31; i++) {
      String day = (i + 1).toString();
      listDay.add(day);
    }
    return listDay;
  }

  static List<dynamic> generrateListMonth() {
    List<dynamic> listMonth = [];
    for (int i = 0; i < 12; i++) {
      String month = (i + 1).toString();
      listMonth.add(month);
    }
    return listMonth;
  }

  static List<dynamic> generrateListYear() {
    List<dynamic> listYear = [];
    for (int i = 0; i < 100; i++) {
      String year = (DateTime.now().year - 100 + i + 1).toString();
      listYear.add(year);
    }
    listYear.sort((b, a) => a.compareTo(b));
    return listYear;
  }

  static String capitalizeWords(String text) {
    List<String> words = text.split(' ');
    for (int i = 0; i < words.length; i++) {
      String word = words[i];
      if (word.isNotEmpty) {
        words[i] = word[0].toUpperCase() + word.substring(1);
      }
    }
    return words.join(' ');
  }

  // static String getBaseUrl() {
  //   return ApiConfig.env == ENV.dev ? ApiConfig.domainDev : ApiConfig.domainPrd;
  // }

  static String formatMoney(String numberString, int decimalDigits) {
    try {
      double number = double.tryParse(numberString.replaceAll(',', '')) ?? 0.0;
      final formatter =
          NumberFormat.currency(decimalDigits: decimalDigits, symbol: '');
      return formatter.format(number);
    } catch (e) {
      return '0.00';
    }
  }

  static Future<void> ensureVisibleOnTextInput(
      {required GlobalKey textfieldKey}) async {
    final keyContext = textfieldKey.currentContext;
    if (keyContext != null) {
      await Future.delayed(const Duration(milliseconds: 500)).then(
        (value) => Scrollable.ensureVisible(
          keyContext,
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
        ),
      );
      // Optional if doesnt work with the first
      await Future.delayed(const Duration(milliseconds: 500)).then(
        (value) => Scrollable.ensureVisible(
          keyContext,
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
        ),
      );
    }
  }

  static String nameConnecterType(String power, String type) {
    String text = '';
    try {
      switch (power) {
        case 'AC':
          switch (type) {
            case 'CS1':
              text = translate("connecterInCharger.actype.CS1");
              break;
            case 'CS2':
              text = translate("connecterInCharger.actype.CS2");
              break;
            case 'CHaDEMO':
              text = translate("connecterInCharger.actype.CHaDEMO");
              break;
            default:
              break;
          }

          break;
        case 'DC':
          switch (type) {
            case 'CS1':
              text = translate("connecterInCharger.dctype.CS1");
              break;
            case 'CS2':
              text = translate("connecterInCharger.dctype.CS2");
              break;
            case 'CHaDEMO':
              text = translate("connecterInCharger.dctype.CHaDEMO");
              break;
            default:
              break;
          }

          break;
        default:
          break;
      }
    } catch (e) {}

    return text;
  }

  static SvgPicture assetCreditCard(
      {required String cardBrand,
      double width = 40,
      double height = 40,
      String defaultCard = ''}) {
    String image =
        (defaultCard == '') ? ImageAsset.card_default_payment : defaultCard;
    switch (cardBrand.toUpperCase()) {
      case CardBrand.MASTERCARD:
        image = ImageAsset.card_mastercard;
        break;
      case CardBrand.VISA:
        image = ImageAsset.card_visa;
        break;
      case CardBrand.AMEX:
        image = ImageAsset.card_amex;
        break;
      case CardBrand.DISCOVER:
        image = ImageAsset.card_discover;
        break;
      case CardBrand.DINERSCLUB:
        image = ImageAsset.card_diners_club;
        break;
      case CardBrand.MAESTRO:
        image = ImageAsset.card_maestro;
        break;
      case CardBrand.STRIPE:
        image = ImageAsset.card_stripe;
        break;
      case CardBrand.PAYPAL:
        image = ImageAsset.card_paypal;
        break;
      case CardBrand.INTERAC:
        image = ImageAsset.card_interac;
        break;
      case CardBrand.VERIFONE:
        image = ImageAsset.card_verifone;
        break;
      case CardBrand.GOOGLEPAY:
        image = ImageAsset.card_googlepay;
        break;
      case CardBrand.APPLEPAY:
        image = ImageAsset.card_applepay;
        break;
      case CardBrand.BITPAY:
        image = ImageAsset.card_bitpay;
        break;
      case CardBrand.BITCOIN:
        image = ImageAsset.card_bitcoin;
        break;
      case CardBrand.ETHERIUM:
        image = ImageAsset.card_etherium;
        break;
      case CardBrand.BITCOINCASH:
        image = ImageAsset.card_bitcoin_cash;
        break;
      case CardBrand.LIGHTCOIN:
        image = ImageAsset.card_lightcoin;
        break;
      case CardBrand.YANDEX:
        image = ImageAsset.card_yandex;
        break;
      case CardBrand.QIWI:
        image = ImageAsset.card_qiwi;
        break;
      case CardBrand.ELO:
        image = ImageAsset.card_elo;
        break;
      case CardBrand.SHOPPAY:
        image = ImageAsset.card_shop_pay;
        break;
      case CardBrand.AMAZONPAY:
        image = ImageAsset.card_amazon_pay;
        break;
      case CardBrand.ALIPAY:
        image = ImageAsset.card_alipay;
        break;
      case CardBrand.WECHAT:
        image = ImageAsset.card_wechat;
        break;
      case CardBrand.IDEAL:
        image = ImageAsset.card_ideal;
        break;
      case CardBrand.GIROPAY:
        image = ImageAsset.card_giropay;
        break;
      case CardBrand.UNIONPAY:
        image = ImageAsset.card_union_pay;
        break;
      case CardBrand.JCB:
        image = ImageAsset.card_jcb;
        break;
      case CardBrand.WEBMONEY:
        image = ImageAsset.card_webmoney;
        break;
      case CardBrand.CITADELE:
        image = ImageAsset.card_citadele;
        break;
      case CardBrand.SOFORT:
        image = ImageAsset.card_sofort;
        break;
      case CardBrand.KLARNA:
        image = ImageAsset.card_klarna;
        break;
      case CardBrand.SKRILL:
        image = ImageAsset.card_skrill;
        break;
      case CardBrand.BANCONTACT:
        image = ImageAsset.card_bancontact;
        break;
      case CardBrand.SEPA:
        image = ImageAsset.card_sepa;
        break;
      case CardBrand.FORBRUGSFORENINGEN:
        image = ImageAsset.card_forbrugsforeningen;
        break;
      case CardBrand.PAYONEER:
        image = ImageAsset.card_payoneer;
        break;
      case CardBrand.AFFIRM:
        image = ImageAsset.card_affirm;
        break;
      case CardBrand.PAYSAFE:
        image = ImageAsset.card_paysafe;
        break;
      case CardBrand.FACEBOOKPAY:
        image = ImageAsset.card_facebook_pay;
        break;
      case CardBrand.POLI:
        image = ImageAsset.card_poli;
        break;
      case CardBrand.VENMO:
        image = ImageAsset.card_venmo;
        break;
      default:
        image;
        break;
    }

    return SvgPicture.asset(
      image,
      width: width,
      height: height,
    );
  }

  static String detectCreditCardType({required String cardNumber}) {
    String cleanedCardNumber = cardNumber.replaceAll(RegExp(r'[^0-9]'), '');
    int cardLength = cleanedCardNumber.length;
    const int visaLength = 16;
    const int mastercardLength = 16;
    const int amexLength = 15;
    const int discoverLength = 16;
    const int dinersClubLength = 14;
    const int jcbLength = 16;
    const int unionPayLength = 16;
    const int maestroLength = 16;
    const int mirLength = 16;
    const int eloLength = 16;
    const int hiperHipercardLength = 16;
    if (cardLength == visaLength && cleanedCardNumber.startsWith("4")) {
      return CardBrand.VISA;
    } else if (cardLength == mastercardLength &&
        (cleanedCardNumber.startsWith("51") ||
            cleanedCardNumber.startsWith("52") ||
            cleanedCardNumber.startsWith("53") ||
            cleanedCardNumber.startsWith("54") ||
            cleanedCardNumber.startsWith("55"))) {
      return CardBrand.MASTERCARD;
    } else if (cardLength == amexLength &&
        (cleanedCardNumber.startsWith("34") ||
            cleanedCardNumber.startsWith("37"))) {
      return CardBrand.AMEX;
    } else if (cardLength == discoverLength &&
        cleanedCardNumber.startsWith("6011")) {
      return CardBrand.DISCOVER;
    } else if (cardLength == dinersClubLength &&
        (cleanedCardNumber.startsWith("300") ||
            cleanedCardNumber.startsWith("301") ||
            cleanedCardNumber.startsWith("302") ||
            cleanedCardNumber.startsWith("303") ||
            cleanedCardNumber.startsWith("304") ||
            cleanedCardNumber.startsWith("305") ||
            cleanedCardNumber.startsWith("36") ||
            cleanedCardNumber.startsWith("38"))) {
      return CardBrand.DINERSCLUB;
    } else if (cardLength == jcbLength && cleanedCardNumber.startsWith("35")) {
      return CardBrand.JCB;
    } else if (cardLength == unionPayLength &&
        cleanedCardNumber.startsWith("62")) {
      return CardBrand.UNIONPAY;
    } else if (cardLength == maestroLength &&
        (cleanedCardNumber.startsWith("5018") ||
            cleanedCardNumber.startsWith("5020") ||
            cleanedCardNumber.startsWith("5038") ||
            cleanedCardNumber.startsWith("6304") ||
            cleanedCardNumber.startsWith("6759") ||
            cleanedCardNumber.startsWith("6761") ||
            cleanedCardNumber.startsWith("6763"))) {
      return CardBrand.MAESTRO;
    } else if (cardLength == mirLength && cleanedCardNumber.startsWith("22")) {
      // MIR
      return '';
    } else if (cardLength == eloLength &&
        (cleanedCardNumber.startsWith("4011") ||
            cleanedCardNumber.startsWith("4312") ||
            cleanedCardNumber.startsWith("4389") ||
            cleanedCardNumber.startsWith("4514") ||
            cleanedCardNumber.startsWith("4573") ||
            cleanedCardNumber.startsWith("4576") ||
            cleanedCardNumber.startsWith("5041") ||
            cleanedCardNumber.startsWith("5066") ||
            cleanedCardNumber.startsWith("5067") ||
            cleanedCardNumber.startsWith("5090") ||
            cleanedCardNumber.startsWith("5094") ||
            cleanedCardNumber.startsWith("5099") ||
            cleanedCardNumber.startsWith("6362") ||
            cleanedCardNumber.startsWith("6363") ||
            cleanedCardNumber.startsWith("6504") ||
            cleanedCardNumber.startsWith("6504") ||
            cleanedCardNumber.startsWith("6504") ||
            cleanedCardNumber.startsWith("6505") ||
            cleanedCardNumber.startsWith("6506") ||
            cleanedCardNumber.startsWith("6507") ||
            cleanedCardNumber.startsWith("6508") ||
            cleanedCardNumber.startsWith("6509") ||
            cleanedCardNumber.startsWith("6510") ||
            cleanedCardNumber.startsWith("6511") ||
            cleanedCardNumber.startsWith("6512") ||
            cleanedCardNumber.startsWith("6513") ||
            cleanedCardNumber.startsWith("6550"))) {
      return CardBrand.ELO;
    } else if (cardLength == hiperHipercardLength &&
        (cleanedCardNumber.startsWith("3841") ||
            cleanedCardNumber.startsWith("3842"))) {
      // Hiper/Hipercard
      return '';
    } else {
      // UNKNOWN
      return '';
    }
  }

  static String toJwt(dynamic jsonPayload) {
    try {
      final jwt = JWT(jsonPayload);
      String jwtToken = jwt.sign(
        SecretKey('dqlvMQPhgMMaXCcbx97KpRmFLeGqbAHT'),
        expiresIn: const Duration(minutes: 5),
      );
      return jwtToken;
    } catch (e) {
      return '';
    }
  }

  static _showCalendarPicker(BuildContext context, DateTime date) async {
    final config = CalendarDatePicker2WithActionButtonsConfig(
      calendarType: CalendarDatePicker2Type.single,
      selectedDayHighlightColor: Colors.blueAccent,
    );
    final values = await showCalendarDatePicker2Dialog(
      context: context,
      config: config,
      dialogSize: const Size.fromHeight(400),
      borderRadius: BorderRadius.circular(4),
      value: [date],
      dialogBackgroundColor: Colors.white,
    );

    return values?.single ?? date;
  }

  static void getCheckStatusCharging(BuildContext context) {
    UserManagementUseCase useCase = getIt();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<StatusChargingCubit>(context).loadingCheckStatus();
      Utilities.requestAccessToken(
        useCase,
        ({required accessToken, required deviceCode, required username}) async {
          final result = await useCase.statusCharging(
            accessToken,
            StatusChargerForm(
              deviceCode: deviceCode,
              username: username,
              orgCode: ConstValue.orgCode,
            ),
          );
          result.fold(
            (failure) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                dialogIsVisible(context);
                Utilities.alertOneButtonAction(
                  context: context,
                  type: AppAlertType.DEFAULT,
                  isForce: true,
                  title: translate('alert.title.default'),
                  description: '${failure.message}',
                  textButton: translate('button.try_again'),
                  onPressButton: () {
                    Navigator.of(context).pop();
                  },
                );
              });
            },
            (data) async {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                CheckStatusChargingData chargingData = getIt();
                chargingData.checkStatusEntity = data;
                try {
                  BlocProvider.of<StatusChargingCubit>(context)
                      .statusCharging(data);
                } catch (e) {
                  debugPrint('CATCH AT UTILITIES GET STATUS');
                }
              });
            },
          );
        },
        'GlobalStatusCharging',
      );
    });
  }

  static void alertAfterSaveAction({
    required BuildContext context,
    required String type,
    required String text,
    int time = 3,
  }) {
    Color color = AppTheme.green80;
    IconData icon = Icons.check_circle_outline;
    switch (type) {
      case AppAlertType.SUCCESS:
        color = AppTheme.green80;
        icon = Icons.check_circle_outline;
        break;
      case AppAlertType.WARNING:
        color = AppTheme.red;
        icon = Icons.cancel_outlined;
        break;
      case AppAlertType.DEFAULT:
        color = AppTheme.orange;
        icon = Icons.info_outline;
      default:
        color = AppTheme.orange;
        icon = Icons.info_outline;
    }

    toastification.show(
      context: context,
      dismissDirection: DismissDirection.up,
      // type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 5),
      title: TextLabel(
        text: '$text',
        fontSize:
            Utilities.sizeFontWithDesityForDisplay(context, AppFontSize.normal),
        color: AppTheme.white,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      alignment: Alignment.topCenter,
      animationDuration: const Duration(milliseconds: 300),
      icon: Icon(icon, color: AppTheme.white),
      primaryColor: color,
      backgroundColor: color,
      margin: const EdgeInsets.only(top: 0, left: 12, right: 12, bottom: 8),
      borderRadius: BorderRadius.circular(12),
      showProgressBar: false,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: false,
      callbacks: ToastificationCallbacks(
        onTap: (toastItem) {
          toastification.dismiss(toastItem);
        },
        // onCloseButtonTap: (toastItem) =>
        //     print('Toast ${toastItem.id} close button tapped'),
        // onAutoCompleteCompleted: (toastItem) =>
        //     print('Toast ${toastItem.id} auto complete completed'),
        // onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
      ),
    );
  }

  static String getWordStatus(String checkStatus) {
    switch (checkStatus) {
      case ConstValue.OCCUPIED:
        return translate('station_details_page.status_charger.occupied');
      case ConstValue.PREPARING:
        return translate('station_details_page.status_charger.preparing');
      case ConstValue.AVAILABLE:
        return translate('station_details_page.status_charger.available');
      case ConstValue.MAINTENANCE:
        return translate('station_details_page.status_charger.maintenance');
      default:
        return translate('station_details_page.status_charger.outofservice');
    }
  }

  static Color getColorStatus(String checkStatus) {
    switch (checkStatus) {
      case ConstValue.OCCUPIED:
        return AppTheme.red;
      case ConstValue.PREPARING:
        return AppTheme.red;
      case ConstValue.AVAILABLE:
        return AppTheme.green;
      case ConstValue.MAINTENANCE:
        return AppTheme.brown;
      default:
        return AppTheme.gray9CA3AF;
    }
  }
}
