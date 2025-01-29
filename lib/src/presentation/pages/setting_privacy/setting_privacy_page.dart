import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter/src/navigation_service.dart';
import 'package:jupiter/src/presentation/pages/delete_account/delete_account_page.dart';
import 'package:jupiter/src/presentation/pages/notification_setting/notification_setting_page.dart';
import 'package:jupiter/src/presentation/pages/policy/policy_page.dart';
import 'package:jupiter/src/presentation/pages/setting_privacy/cubit/setting_privacy_cubit.dart';
import 'package:jupiter/src/presentation/pages/update_password/update_password_otp/update_password_otp_page.dart';
import 'package:jupiter/src/presentation/widgets/loading_page.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/root_app.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:local_auth/local_auth.dart';

import '../../../firebase_log.dart';
import 'widgets/row_button.dart';
import 'widgets/row_switch.dart';

class SettingPrivacyPage extends StatefulWidget {
  const SettingPrivacyPage({super.key});
  @override
  State<SettingPrivacyPage> createState() => _SettingPrivacyPageState();
}

class _SettingPrivacyPageState extends State<SettingPrivacyPage> {
  final NavigationService navigationService = getIt<NavigationService>();
  bool? language = false;
  bool? notification = false;
  bool? faceTouchId = false;
  bool isLoadingPage = false;
  bool? checklanguage = false;
  bool loadingForLaguage = false;
  bool? supportFaceTouchId = false;
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    FirebaseLog.logPage(this);
    initSetting();
    super.initState();
  }

  Future<void> initSetting() async {
    language = jupiterPrefsAndAppData.language;
    notification = jupiterPrefsAndAppData.notification;
    supportFaceTouchId = await checkEnableBiometricIsGrant();
    debugPrint("SettingPrivacyPage $notification");
    debugPrint("SettingPrivacyPage $faceTouchId");
    setState(() {});
  }

  Future<bool> checkEnableBiometricIsGrant() async {
    bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    if (canAuthenticate) {
      return true;
    }
    return false;
  }

  Future<void> onPressedBackButton() async {
    Navigator.of(context).pop();
  }

  Future<void> onChangeSwitchLanguage(bool value) async {
    Utilities.alertTwoButtonAction(
      context: context,
      type: AppAlertType.DEFAULT,
      title: translate('alert_change_language.title'),
      description: translate('alert_change_language.description'),
      textButtonLeft: translate('button.cancel'),
      textButtonRight: translate('button.confirm'),
      onPressButtonLeft: () {
        Navigator.of(context).pop();
        setState(() {
          isLoadingPage = false;
          language = !value;
          checklanguage = language;
        });
      },
      onPressButtonRight: () async {
        checklanguage = value;
        fetchSetLanguage();
      },
    );
  }

  void onChangeSwitchNotification(bool value) {
    setState(() {
      notification = value;
      jupiterPrefsAndAppData.saveSettingNotification(notification ?? false);
    });
  }

  // void onChangeSwitchFaceTouchId(bool value) {
  //   setState(() {
  //     faceTouchId = value;
  //     Utilities.saveSettingFaceOrTouchId(faceTouchId ?? false);
  //   });
  // }

  void fetchSetLanguage() {
    Navigator.of(context).pop();
    try {
      BlocProvider.of<SettingPrivacyCubit>(context)
          .setLanguage(checklanguage ?? false ? 'EN' : 'TH');
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (isLoadingPage) {
          setState(() {
            isLoadingPage = false;
          });
          BlocProvider.of<SettingPrivacyCubit>(context).resetStatetoInital();
        }
      });
    }
  }

  void onPressGoToSetting() {
    try {
      if (Platform.isAndroid) {
        AppSettings.openAppSettings(
          type: AppSettingsType.security,
          asAnotherTask: true,
        );
      } else {
        AppSettings.openAppSettings(
          type: AppSettingsType.settings,
          asAnotherTask: true,
        );
      }
    } catch (e) {
      debugPrint('ERROR TO OPEN APP SETTING SECURITY');
    }
  }

  void actionSettingPrivacyLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isLoadingPage) {
        setState(() {
          isLoadingPage = true;
          loadingForLaguage = true;
        });
      }
    });
  }

  void actionSettingPrivacySuccess() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (isLoadingPage) {
        language = checklanguage;
        jupiterPrefsAndAppData.saveSettingLanguage(language ?? false);
        String? refreshToken = jupiterPrefsAndAppData.refreshToken;
        debugPrint('refreshToken : ${refreshToken}');

        RootApp.setLocale(language ?? false);

        setState(() {
          isLoadingPage = false;
        });
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            loadingForLaguage = false;
          });
        });
      }
    });
  }

  void actionSettingPrivacyFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoadingPage) {
        setState(() {
          isLoadingPage = false;
          loadingForLaguage = false;
        });
        BlocProvider.of<SettingPrivacyCubit>(context).resetStatetoInital();
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.DEFAULT,
          isForce: true,
          title: translate('alert.title.default'),
          description: state.message ?? translate('alert.description.default'),
          textButton: translate('button.try_again'),
          onPressButton: () {
            Navigator.of(context).pop();
          },
        );
      }
    });
  }

  void actionResetInitial() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoadingPage) {
        setState(() {
          isLoadingPage = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("startBuild");
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              backgroundColor: AppTheme.white,
              bottomOpacity: 0.0,
              elevation: 0.0,
              iconTheme: const IconThemeData(
                color: AppTheme.blueDark, //change your color here
              ),
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppTheme.blueDark),
                  onPressed: onPressedBackButton),
              centerTitle: true,
              title: TextLabel(
                text: translate('app_title.security'),
                color: AppTheme.blueDark,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.title),
                fontWeight: FontWeight.w700,
              ),
            ),
            body: BlocBuilder<SettingPrivacyCubit, SettingPrivacyState>(
              builder: (BuildContext context, state) {
                switch (state.runtimeType) {
                  case SettingPrivacyLoading:
                    actionSettingPrivacyLoading();
                    break;
                  case SettingPrivacySuccess:
                    actionSettingPrivacySuccess();
                    break;
                  case SettingPrivacyFailure:
                    actionSettingPrivacyFailure(state);
                    break;
                  default:
                    actionResetInitial();
                    break;
                }
                return renderSettingPrivacy();
              },
            )),
        LoadingPage(visible: isLoadingPage || loadingForLaguage)
      ],
    );
  }

  Widget renderSettingPrivacy() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      height: MediaQuery.of(context).size.height * 0.9,
      color: AppTheme.white,
      width: MediaQuery.of(context).size.width,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextLabel(
                text: translate('security_page.general.title'),
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.large),
                color: AppTheme.gray9CA3AF,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 4),
              RowSwitch(
                title: translate('security_page.general.language'),
                switchValue: language ?? false,
                onChangedValue: onChangeSwitchLanguage,
                hasText: true,
                textLeft: 'TH',
                textRight: 'EN',
              ),
              // RowSwitch(
              //   title: translate('security_page.general.notification'),
              //   switchValue: notification ?? false,
              //   onChangedValue: onChangeSwitchNotification,
              // ),
              RowButton(
                title: translate('security_page.general.notification'),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return NotificationSettingPage();
                  }));
                },
              ),
              const SizedBox(height: 16),
              TextLabel(
                text: translate('security_page.privacy.title'),
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.large),
                color: AppTheme.gray9CA3AF,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 4),
              // RowSwitch(
              //   title: translate('security_page.privacy.face_touch_id'),
              //   switchValue: faceTouchId ?? false,
              //   onChangedValue: onChangeSwitchFaceTouchId,
              // ),
              supportFaceTouchId ?? false
                  ? RowButton(
                      title: translate('security_page.privacy.face_touch_id'),
                      onPressed: onPressGoToSetting,
                    )
                  : const SizedBox(),
              supportFaceTouchId ?? false
                  ? const SizedBox(height: 8)
                  : const SizedBox(),
              RowButton(
                title: translate('security_page.privacy.update_password'),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return UpdatePasswordOtpPage();
                  }));
                },
              ),
              const SizedBox(height: 16),
              TextLabel(
                text: translate('security_page.legal.title'),
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.large),
                color: AppTheme.gray9CA3AF,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 4),
              RowButton(
                title: translate('security_page.legal.term'),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return PolicyPage();
                  }));
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return DeleteAccountPage();
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextLabel(
                        text: translate('security_page.delete_account'),
                        color: AppTheme.red,
                        fontWeight: FontWeight.w700,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.large),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
