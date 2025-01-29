import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/config/api/api_firebase.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/pages/notification_setting/cubit/notification_setting_cubit.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter/src/presentation/pages/notification_setting/widgets/reload_notification_setting.dart';
import 'package:jupiter/src/presentation/pages/notification_setting/widgets/row_button_setting.dart';
import 'package:jupiter/src/presentation/pages/notification_setting/widgets/row_checkbox.dart';
import 'package:jupiter/src/presentation/widgets/lifecycle_watcher_state.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/domain/entities/notification_setting_entity.dart';

class NotificationSettingPage extends StatefulWidget {
  const NotificationSettingPage({super.key});

  @override
  State<NotificationSettingPage> createState() =>
      _NotificationSettingPageState();
}

class _NotificationSettingPageState
    extends LifecycleWatcherState<NotificationSettingPage> {
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  String notiAuthorized = 'authorized';
  bool checkSystems = false;
  bool checkNews = false;
  bool isClick = false;
  bool loadingPage = true;
  bool isAuth = false;
  bool processing = false;
  bool disableCheckbox = true;
  bool loadingFalse = false;
  String messageLoadingFalse = '';
  String loadingCheckbox = '';

  NotificationSettingEntity? getNoti;

  @override
  void initState() {
    checkAlertPermission();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        bool isLocked = jupiterPrefsAndAppData.isLocked;
        if (!isLocked) {
          checkIsAuth();
        }
      });
    });
  }

  void checkAlertPermission() async {
    setState(() {
      loadingPage = true;
    });
    isAuth = await getPermissionNoti();
    if (!isAuth) {
      Utilities.dialogIsVisible(context);
      alertCheckPermissionNoti(context);
      setState(() {});
    } else {
      getNotificationSetting();
    }
  }

  Future<void> checkIsAuth() async {
    debugPrint('onResumed checkIsAuth ${new DateTime.now().toLocal()}');
    if (!processing) {
      debugPrint('processing : true');
      processing = true;
      isAuth = await getPermissionNoti();
      if (isAuth) {
        Utilities.dialogIsVisible(context);
        // loadingPage = false;

        Future.delayed(const Duration(seconds: 1), () {
          processing = false;
          getNotificationSetting();
        });
      } else {
        Utilities.dialogIsVisible(context);
        alertCheckPermissionNoti(context);
        // loadingPage = false;

        Future.delayed(const Duration(seconds: 1), () {
          processing = false;
        });
      }
      setState(() {});
    }
  }

  Future<bool> getPermissionNoti() async {
    try {
      ApiFirebase apiFirebase = ApiFirebase();
      NotificationSettings statusFirebaseMessaging =
          await apiFirebase.firebaseMessaging.requestPermission();
      debugPrint(
          'FirebaseNoti : ${statusFirebaseMessaging.authorizationStatus.name}');
      String statusPermission =
          statusFirebaseMessaging.authorizationStatus.name;
      if (statusPermission != notiAuthorized) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  void alertCheckPermissionNoti(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Utilities.alertTwoButtonAction(
        context: context,
        type: AppAlertType.DEFAULT,
        title:
            translate('notification_setting_page.alert_permission_noti.title'),
        description: translate(
            'notification_setting_page.alert_permission_noti.description'),
        textButtonLeft: translate(
            'notification_setting_page.alert_permission_noti.button_left'),
        textButtonRight: translate(
            'notification_setting_page.alert_permission_noti.button_right'),
        onPressButtonLeft: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        onPressButtonRight: () {
          openAppSettings();
        },
      );
    });
  }

  void openAppSettings() {
    try {
      AppSettings.openAppSettings(
        type: AppSettingsType.notification,
        asAnotherTask: true,
      );
    } catch (e) {
      debugPrint('ERROR TO OPEN APP SETTING NOTIFICATION');
    }
  }

  Future<void> onPressedBackButton() async {
    // if (!loadingPage) {
    BlocProvider.of<NotiSettingCubit>(context).resetStateInitial();
    Navigator.of(context).pop();
    // }
  }

  void onPressedCheckbox(String title) {
    if (!loadingPage) {
      if (!isClick) {
        isClick = true;
        switch (title) {
          case NotificationType.SYSTEMS:
            loadingCheckbox = NotificationType.SYSTEMS;
            BlocProvider.of<NotiSettingCubit>(context).setNotificationSetting(
                notificationSystem: !checkSystems, notificationNews: checkNews);
            break;
          case NotificationType.NEWS:
            loadingCheckbox = NotificationType.NEWS;
            BlocProvider.of<NotiSettingCubit>(context).setNotificationSetting(
                notificationSystem: checkSystems, notificationNews: !checkNews);
            break;
          default:
            break;
        }
      }
    }
  }

  void getNotificationSetting() {
    BlocProvider.of<NotiSettingCubit>(context).getNotificationSetting();
  }

  void actionNotiSettingLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingPage) {
        setState(() {
          loadingPage = true;
          messageLoadingFalse = '';
        });
      }
    });
  }

  void actionSetNotiSettingFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
          isClick = false;
        });
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
        BlocProvider.of<NotiSettingCubit>(context).resetStateInitial();
      }
    });
  }

  void actionSetNotiSettingSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        // setState(() {
        //   loadingPage = false;
        // });
        getNotificationSetting();
      }
    });
  }

  void actionGetNotiSettingFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
          loadingFalse = true;
          messageLoadingFalse =
              state.message ?? translate('alert.description.default');
          isClick = false;
          disableCheckbox = true;
          loadingCheckbox = '';
        });
        BlocProvider.of<NotiSettingCubit>(context).resetStateInitial();
      }
    });
  }

  void actionGetNotiSettingSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          getNoti = state.notificationSetting;
          checkSystems = getNoti?.notificationSystem ?? false;
          checkNews = getNoti?.notificationNews ?? false;
          loadingPage = false;
          loadingFalse = false;
          isClick = false;
          disableCheckbox = false;
          loadingCheckbox = '';
        });
        BlocProvider.of<NotiSettingCubit>(context).resetStateInitial();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            text: translate('notification_setting_page.title'),
            color: AppTheme.blueDark,
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.title),
            fontWeight: FontWeight.w700,
          ),
        ),
        body: BlocBuilder<NotiSettingCubit, NotiSettingState>(
          builder: (BuildContext context, state) {
            switch (state.runtimeType) {
              case NotiSettingLoading:
                actionNotiSettingLoading();
                break;
              case SetNotiSettingSuccess:
                actionSetNotiSettingSuccess(state);
                break;
              case SetNotiSettingFailure:
                actionSetNotiSettingFailure(state);
                break;
              case GetNotiSettingSuccess:
                actionGetNotiSettingSuccess(state);
                break;
              case GetNotiSettingFailure:
                actionGetNotiSettingFailure(state);
                break;
              default:
                break;
            }
            return renderCheckboxNoti();
          },
        ));
  }

  Widget renderCheckboxNoti() {
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
              RowButtonSetting(
                title: translate('notification_setting_page.push_notification'),
                textStatus: isAuth
                    ? translate('notification_setting_page.allowed')
                    : translate('notification_setting_page.not_allowed'),
                onPressed: () {
                  openAppSettings();
                },
              ),
              const SizedBox(height: 16),
              TextLabel(
                text: translate(
                    'notification_setting_page.application_notification'),
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.large),
                color: AppTheme.gray9CA3AF,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 4),
              Visibility(
                  visible: loadingFalse,
                  child: ReloadNotificationSetting(
                    loadingPage: loadingPage,
                    loadingFalse: loadingFalse,
                    message: messageLoadingFalse,
                  )),
              Visibility(
                visible: !loadingFalse,
                child: RowCheckbox(
                  title: translate('notification_setting_page.systems'),
                  description: translate(
                      'notification_setting_page.systems_description'),
                  value: checkSystems,
                  onPressed: () => onPressedCheckbox(NotificationType.SYSTEMS),
                  disable: disableCheckbox,
                  loadingPage: loadingPage,
                  loadingCheckbox:
                      (loadingCheckbox == NotificationType.SYSTEMS) ||
                          (loadingCheckbox == ''),
                ),
              ),
              const SizedBox(height: 8),
              Visibility(
                visible: !loadingFalse,
                child: RowCheckbox(
                  title: translate('notification_setting_page.news'),
                  description:
                      translate('notification_setting_page.news_description'),
                  value: checkNews,
                  onPressed: () => onPressedCheckbox(NotificationType.NEWS),
                  disable: disableCheckbox,
                  loadingPage: loadingPage,
                  loadingCheckbox: (loadingCheckbox == NotificationType.NEWS) ||
                      (loadingCheckbox == ''),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
