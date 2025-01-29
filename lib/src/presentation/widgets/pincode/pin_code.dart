// ignore_for_file: unused_field

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter/src/route_names.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:local_auth/local_auth.dart';
import '../../../apptheme.dart';
import '../../../root_app.dart';
import '../index.dart';
import 'pin_image.dart';
import 'pin_number.dart';
import 'row_circle_pin.dart';

enum PinCodeMode {
  create,
  update,
  pin,
}

// enum _SupportState {
//   unknown,
//   supported,
//   unsupported,
// }

class PinCode extends StatefulWidget {
  const PinCode({
    super.key,
    required this.pinCodeMode,
  });

  final PinCodeMode pinCodeMode;

  @override
  State<PinCode> createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode> {
  ValueNotifier<String> pinCode = ValueNotifier<String>('');
  String pinCodeCreate = '';
  String pinCodeCreateConfirm = '';
  String pinCodeUpdate = '';
  String pinCodeUpdateConfirm = '';
  bool stepVerifyOldPassword = true;
  // ValueNotifier<String> pinCodeCreate = ValueNotifier<String>('');
  // ValueNotifier<String> pinCodeCreateConfirm = ValueNotifier<String>('');
  ValueNotifier<String> textLabel = ValueNotifier<String>('');
  int maxLength = 6;

  String enterYourPin = translate("pin_code.enter_your_pin");
  String createPin = translate("pin_code.create_pin");
  String comfirmYourPin = translate("pin_code.confrim_your_pin");
  String enterYourOldPin = translate("pin_code.enter_your_old_pin");
  String enterYourNewPin = translate("pin_code.enter_your_new_pin");
  String comfirmYourNewPin = translate("pin_code.confirm_your_new_pin");
  String pinDoNotMatch = translate("pin_code.pin_do_not_match");
  String errorText = '';
  String? pin = '';
  List<Widget> listGridItem = List.empty();
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  bool processing = false;
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    initValue();
    initValidationPin();
    initEnableBioMetricsAndPinButton();
    super.initState();
  }

  Future<bool> checkEnableBiometricIsGrant({isForce = false}) async {
    if ((widget.pinCodeMode == PinCodeMode.update ||
            widget.pinCodeMode == PinCodeMode.create) &&
        !isForce) return false;
    bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    debugPrint('availableBiometrics : ${availableBiometrics.length}');
    debugPrint(
        'canAuthenticateWithBiometrics : ${canAuthenticateWithBiometrics}');
    debugPrint('canAuthenticate : ${canAuthenticate}');
    if (canAuthenticate && availableBiometrics.length > 0) {
      return true;
    }
    return false;
  }

  Future<void> initEnableBioMetricsAndPinButton({
    bool resetButtonPin = false,
  }) async {
    bool enableBiometric = await checkEnableBiometricIsGrant();
    listGridItem = [
      PinNumber(
        numberText: '1',
        onValueChanged: (value) {
          pinCode.value += value;
          debugPrint("PinCode $pinCode");
        },
      ),
      PinNumber(
        numberText: '2',
        onValueChanged: (value) {
          pinCode.value += value;
          debugPrint("PinCode $pinCode");
        },
      ),
      PinNumber(
        numberText: '3',
        onValueChanged: (value) {
          pinCode.value += value;
          debugPrint("PinCode $pinCode");
        },
      ),
      PinNumber(
        numberText: '4',
        onValueChanged: (value) {
          pinCode.value += value;
          debugPrint("PinCode $pinCode");
        },
      ),
      PinNumber(
        numberText: '5',
        onValueChanged: (value) {
          pinCode.value += value;
          debugPrint("PinCode $pinCode");
        },
      ),
      PinNumber(
        numberText: '6',
        onValueChanged: (value) {
          pinCode.value += value;
          debugPrint("PinCode $pinCode");
        },
      ),
      PinNumber(
        numberText: '7',
        onValueChanged: (value) {
          pinCode.value += value;
          debugPrint("PinCode $pinCode");
        },
      ),
      PinNumber(
        numberText: '8',
        onValueChanged: (value) {
          pinCode.value += value;
          debugPrint("PinCode $pinCode");
        },
      ),
      PinNumber(
        numberText: '9',
        onValueChanged: (value) {
          pinCode.value += value;
          debugPrint("PinCode $pinCode");
        },
      ),
      enableBiometric
          ? PinImage(
              imageAsset: Platform.isIOS
                  ? ImageAsset.face_id
                  : ImageAsset.android_fingerprint,
              onTap: () {
                debugPrint('faceId clicked');
                debugPrint('$pinCode clicked ');
                onPressStartBiometric();
                setState(() {});
              },
            )
          : SizedBox(),
      PinNumber(
        numberText: '0',
        onValueChanged: (value) {
          pinCode.value += value;
          debugPrint("PinCode $pinCode");
        },
      ),
      PinImage(
        imageAsset: ImageAsset.pin_delete,
        onTap: () async {
          pinCode.value = pinCode.value.substring(0, pinCode.value.length - 1);
          debugPrint('pin_delete clicked');
          debugPrint('Now Pin $pinCode');
          setState(() {});
        },
      ),
    ];
    setState(() {});
    if (widget.pinCodeMode == PinCodeMode.pin && !resetButtonPin) {
      onPressStartBiometric();
    }
  }

  Future<void> initValidationPin() async {
    pin = jupiterPrefsAndAppData.pinCode;
  }

  Future<void> onPressStartBiometric() async {
    try {
      if (processing)
        return;
      else {
        processing = true;
        bool authenticated = false;
        authenticated = await auth.authenticate(
          localizedReason:
              'Scan your fingerprint (or face or whatever) to authenticate',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ),
        );
        if (authenticated) {
          processing = false;
          RootApp.of(context)!.didUnlock(
              {"validated": true, "destination": RouteNames.mainmenu});
        } else {
          processing = false;
        }
      }
    } catch (e) {
      initEnableBioMetricsAndPinButton(resetButtonPin: true);
      processing = false;
    }
  }

  void initValue() {
    pinCode = ValueNotifier<String>('');
    pinCodeCreate = '';
    pinCodeCreateConfirm = '';
    textLabel = ValueNotifier<String>('');
    pinCode.addListener(
      () {
        String value = pinCode.value;
        debugPrint("PinCodeChange ${pinCode.value}");
        if (value.length >= 6) {
          pinCode.value = pinCode.value.substring(0, 6);
          switch (widget.pinCodeMode) {
            case PinCodeMode.create:
              createPinCode();
              break;
            case PinCodeMode.update:
              updatePinCode();
              break;
            case PinCodeMode.pin:
              validatePinCode(value);
              break;
            default:
              break;
          }
        } else {
          if (value.length > 0) {
            errorText = '';
          }
        }
        debugPrint("PinRealValue ${pinCode.value}");
        debugPrint("PinRealValue ${pin}");
        setState(() {});
      },
    );

    switch (widget.pinCodeMode) {
      case PinCodeMode.create:
        textLabel.value = createPin;
        break;
      case PinCodeMode.update:
        textLabel.value = enterYourOldPin;
        break;
      case PinCodeMode.pin:
        textLabel.value = enterYourPin;
        break;
      default:
        textLabel.value = enterYourPin;
        break;
    }
  }

  void updatePinCode() {
    debugPrint("PinCodeUpdate $pinCodeUpdate");
    debugPrint("PinCodeUpdateConfirm $pinCodeUpdateConfirm");
    if (pinCode.value.length >= 6) {
      if (pin != jupiterPrefsAndAppData.encrypt(pinCode.value) &&
          pinCodeUpdate.isEmpty &&
          pinCodeUpdateConfirm.isEmpty &&
          stepVerifyOldPassword) {
        errorText = pinDoNotMatch;
        pinCode.value = '';
        setState(() {});
      } else if (pin == jupiterPrefsAndAppData.encrypt(pinCode.value) &&
          pinCodeUpdate.isEmpty &&
          pinCodeUpdateConfirm.isEmpty &&
          stepVerifyOldPassword) {
        stepVerifyOldPassword = false;
        pinCode.value = '';
        textLabel.value = enterYourNewPin;
        setState(() {});
      } else if (pinCodeUpdate.isEmpty && pinCodeUpdateConfirm.isEmpty) {
        pinCodeUpdate = pinCode.value;
        textLabel.value = comfirmYourNewPin;
        pinCode.value = '';
      } else {
        pinCodeUpdateConfirm = pinCode.value;
        if (pinCodeUpdate == pinCodeUpdateConfirm) {
          jupiterPrefsAndAppData.savePinCode(pinCodeUpdateConfirm);
          Utilities.alertOneButtonAction(
            context: context,
            type: AppAlertType.SUCCESS,
            isForce: true,
            title: translate("alert.title.success"),
            description: translate("pin_code.change_pin_success"),
            textButton: translate("button.Ok"),
            onPressButton: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          );
        } else {
          errorText = pinDoNotMatch;
          pinCode.value = '';
          setState(() {});
        }
      }
    }
  }

  void validatePinCode(String value) {
    if (jupiterPrefsAndAppData.encrypt(value) == pin) {
      pinCode.value = '';
      RootApp.of(context)!
          .didUnlock({"validated": true, "destination": RouteNames.mainmenu});
    } else {
      pinCode.value = '';
      errorText = pinDoNotMatch;
      setState(() {});
    }
  }

  Future<void> createPinCode() async {
    if (pinCodeCreate == '') {
      pinCodeCreate = pinCode.value;
      textLabel.value = comfirmYourPin;
      pinCode.value = '';
      setState(() {});
    } else {
      pinCodeCreateConfirm = pinCode.value;
      if (pinCodeCreate == pinCodeCreateConfirm) {
        jupiterPrefsAndAppData.savePinCode(pinCodeCreateConfirm);
        RootApp.of(context)?.enable();
        RootApp.of(context)!.showLockScreen(
            replace: true, destination: RouteNames.mainmenu, onStart: false);
        // Utilities.alertTwoButtonAction(
        //   context: context,
        //   type: AppAlertType.DEFAULT,
        //   title: Platform.isIOS
        //       ? translate("pin_code.alert_biometric_title_ios")
        //       : translate("pin_code.alert_biometric_title_android"),
        //   description: Platform.isIOS
        //       ? translate("pin_code.alert_biometric_description_ios")
        //       : translate("pin_code.alert_biometric_description_android"),
        //   textButtonLeft: translate("pin_code.alert_biometric_left_btn"),
        //   textButtonRight: translate("pin_code.alert_biometric_right_btn"),
        //   onPressButtonLeft: () {
        //     RootApp.of(context)!.showLockScreen(
        //         replace: true,
        //         destination: RouteNames.mainmenu,
        //         onStart: false);
        //   },
        //   onPressButtonRight: () {
        //     RootApp.of(context)!.showLockScreen(
        //         replace: true,
        //         destination: RouteNames.mainmenu,
        //         onStart: false);
        //   },
        // );
      }
    }
    if (pinCodeCreate.isNotEmpty &&
        pinCodeCreateConfirm.isNotEmpty &&
        pinCodeCreate != pinCodeCreateConfirm) {
      errorText = pinDoNotMatch;
      pinCode.value = '';
      setState(() {});
    } else {
      errorText = '';
      pinCode.value = '';
      setState(() {});
    }
  }

  double widthMulti = 0.7;
  @override
  Widget build(BuildContext context) {
    jupiterPrefsAndAppData = getIt();
    debugPrint("PinCode refreshToken: ${jupiterPrefsAndAppData.refreshToken}");
    debugPrint("PinCode username: ${jupiterPrefsAndAppData.username}");
    debugPrint("PinCode pinCode: ${jupiterPrefsAndAppData.pinCode}");
    debugPrint("PinCode notification: ${jupiterPrefsAndAppData.notification}");
    debugPrint("PinCode language: ${jupiterPrefsAndAppData.language}");
    debugPrint("PinCode Bio textLabel${textLabel.value}");
    var sizeMedia = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(maxWidth: sizeMedia.width * widthMulti),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextLabel(
            text: textLabel.value,
            color: AppTheme.blueDark,
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.title),
            fontWeight: FontWeight.w700,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: FutureBuilder(
              builder: (context, snapshot) {
                return ValueListenableBuilder<String>(
                  builder: (BuildContext context, String value, Widget? child) {
                    return RowCirclePin(
                      pinCode: pinCode.value,
                    );
                  },
                  valueListenable: pinCode,
                  child: RowCirclePin(
                    pinCode: pinCode.value,
                  ),
                );
              },
              future: null,
            ),
          ),
          SizedBox(
            height: sizeMedia.height * 0.03,
          ),
          TextLabel(
            text: errorText,
            color: AppTheme.red,
            fontWeight: FontWeight.w400,
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.normal),
          ),
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: GridView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: (sizeMedia.width * widthMulti - 48) / 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 12,
                itemBuilder: (BuildContext ctx, index) {
                  if (listGridItem.length <= 0) {
                    return SizedBox();
                  } else {
                    return listGridItem[index];
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
