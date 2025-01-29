import 'dart:async';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/config/api/api_firebase.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter/src/presentation/pages/main_menu/widgets/custom_button_charging.dart';
import 'package:jupiter/src/presentation/pages/splash_screen/check_status_charging.dart';
import 'package:jupiter_api/data/data_models/request/status_charger_form.dart';
import 'package:jupiter_api/domain/entities/charger_realtime_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/charging/charging_page.dart';
import 'package:jupiter/src/presentation/pages/index.dart';
import 'package:jupiter/src/presentation/pages/login/cubit/login_cubit.dart';
import 'package:jupiter/src/presentation/pages/main_menu/cubit/main_menu_cubit.dart';
import 'package:jupiter/src/presentation/pages/more/more_page.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import '../../../firebase_log.dart';
import '../../../injection.dart';
import '../../../route_names.dart';
import '../../status_charging/cubit/status_charging_cubit.dart';
import '../home/home_page.dart';
import '../profile/cubit/profile_cubit.dart';

class MainMenuWrapperProvider extends StatelessWidget {
  const MainMenuWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MainMenuCubit>(),
      child: MainMenuPage(),
    );
  }
}

// ignore: must_be_immutable
class MainMenuPage extends StatefulWidget {
  MainMenuPage({
    Key? key,
    // this.checkStatusEntity,
    this.isOpenFirstTime = false,
    this.recommendedToMap = false,
  }) : super(key: key);

  // CheckStatusEntity? checkStatusEntity;
  bool isOpenFirstTime;

  bool recommendedToMap;

  @override
  _MainMenuPageState createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage>
    with TickerProviderStateMixin {
  final autoSizeGroup = AutoSizeGroup();
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation borderRadiusCurve;
  late bool car_charging = false;
  CheckStatusChargingData? checkStatusChargingData;
  late Animation<double> fabAnimation;
  late CurvedAnimation fabCurve;
  final iconListActive = [
    ImageAsset.ic_home_active,
    ImageAsset.ic_station_active,
    ImageAsset.ic_history_active,
    ImageAsset.ic_profile_active,
  ];

  final iconListInActive = [
    ImageAsset.ic_home_inactive,
    ImageAsset.ic_station_inactive,
    ImageAsset.ic_history_inactive,
    ImageAsset.ic_profile_inactive,
  ];

  bool loadCheckStatus = false;
  List<String> nameList = [
    translate('bottom_navigation.home'),
    translate('bottom_navigation.station'),
    translate('bottom_navigation.history'),
    translate('bottom_navigation.menu'),
  ];

  String qrCodeData = '';
  bool showModalDebt = false;
  late bool status_charger = false;
  late bool status_receipt = false;

  var _activeColor = AppTheme.lightBlue;
  var _backgroundFloatingScan = AppTheme.lightBlue;
  late AnimationController _borderRadiusAnimationController;
  var _bottomNavIndex = 0; //default index of a first screen
  late AnimationController _fabAnimationController;
  late AnimationController _hideBottomBarAnimationController;
  final _unActiveColor = AppTheme.black60;
  bool isLoading = true;
  bool isPause = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    FirebaseLog.logPage(this);
    super.initState();
    debugPrint('MainMenuInitState');
    debugPrint('MainMenuInitState ${Navigator.canPop(context)}');
    // debugPrint('MainMenuInitState ${widget.checkStatusEntity?.chargingStatus}');
    checkStatusChargingData = getIt();
    debugPrint(
        'MainMenuInitState ${checkStatusChargingData?.checkStatusEntity?.chargingStatus}');
    car_charging =
        checkStatusChargingData?.checkStatusEntity?.chargingStatus ?? false;
    status_charger =
        checkStatusChargingData?.checkStatusEntity?.data?.statusCharger ??
            false;
    status_receipt =
        checkStatusChargingData?.checkStatusEntity?.data?.statusReceipt ??
            false;
    BlocProvider.of<StatusChargingCubit>(context)
        .statusCharging(checkStatusChargingData?.checkStatusEntity);
    getPreferencesCheckLoginFirst();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // Status bar color
      statusBarColor: Colors.transparent,
      // Status bar brightness (optional)
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
    ));
    // final systemTheme = SystemUiOverlayStyle.light.copyWith(
    //   systemNavigationBarColor: HexColor('#373A36'),
    //   systemNavigationBarIconBrightness: Brightness.light,
    // );
    // SystemChrome.setSystemUIOverlayStyle(systemTheme);
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );
    _hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    Future.delayed(
      const Duration(seconds: 1),
      () => _fabAnimationController.forward(),
    );
    Future.delayed(
      const Duration(seconds: 1),
      () => _borderRadiusAnimationController.forward(),
    );
    BlocProvider.of<ProfileCubit>(context).loadProfile();
    BlocProvider.of<LoginCubit>(context).resetState();
    onLaunchAppGotoNotificationPage();
    if (widget.recommendedToMap) {
      _bottomNavIndex = 1;
    }
  }

  getPreferencesCheckLoginFirst() async {
    JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
    bool? checkFirstLogin = jupiterPrefsAndAppData.checkFirstLogin;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        loadCheckStatus = true;
      });
    });
    if (checkFirstLogin == true) {
      // Utilities.getCheckStatusCharging(context);
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   Future.delayed(const Duration(milliseconds: 500), () {
      //     setState(() {
      //       loadCheckStatus = false;
      //     });
      //     checkPaymentDebt();
      //   });
      // });
      UserManagementUseCase useCase = getIt();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        BlocProvider.of<StatusChargingCubit>(context).loadingCheckStatus();
        Utilities.requestAccessToken(
          useCase,
          ({
            required accessToken,
            required deviceCode,
            required username,
          }) async {
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
                  Utilities.dialogIsVisible(context);
                  Utilities.alertOneButtonAction(
                    context: context,
                    type: AppAlertType.DEFAULT,
                    isForce: true,
                    title: translate('alert.title.default'),
                    description: '${failure.message}',
                    textButton: translate('button.try_again'),
                    onPressButton: () {
                      Navigator.of(context).pop();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          loadCheckStatus = false;
                        });
                      });
                    },
                  );
                });
              },
              (data) async {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  checkStatusChargingData = getIt();
                  checkStatusChargingData?.checkStatusEntity = data;
                  BlocProvider.of<StatusChargingCubit>(context)
                      .statusCharging(data);
                });
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    loadCheckStatus = false;
                  });
                  checkPaymentDebt();
                });
              },
            );
          },
          'GlobalStatusCharging',
        );
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          loadCheckStatus = false;
        });
      });
      checkStatusChargingData = getIt();
      car_charging =
          checkStatusChargingData?.checkStatusEntity?.chargingStatus ?? false;
      status_charger =
          checkStatusChargingData?.checkStatusEntity?.data?.statusCharger ??
              false;
      status_receipt =
          checkStatusChargingData?.checkStatusEntity?.data?.statusReceipt ??
              false;
      BlocProvider.of<StatusChargingCubit>(context)
          .statusCharging(checkStatusChargingData?.checkStatusEntity);
      checkPaymentDebt();
    }
    jupiterPrefsAndAppData.removeCheckFirstLogin();
  }

  void checkPaymentDebt() {
    checkStatusChargingData = getIt();
    bool statusCharger =
        checkStatusChargingData?.checkStatusEntity?.data?.statusCharger ??
            false;
    bool statusReceipt =
        checkStatusChargingData?.checkStatusEntity?.data?.statusReceipt ??
            false;
    bool statusPayment =
        checkStatusChargingData?.checkStatusEntity?.data?.statusPayment ??
            false;
    bool statusDebt =
        checkStatusChargingData?.checkStatusEntity?.data?.statusDebt ?? false;
    String totalPrice = checkStatusChargingData
            ?.checkStatusEntity?.data?.receiptData?.totalPrice ??
        '';
    if (!statusCharger && statusReceipt && !statusPayment && statusDebt) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!showModalDebt) {
          setState(() {
            showModalDebt = true;
          });
          Utilities.alertOneButtonAction(
            context: context,
            type: AppAlertType.WARNING,
            isForce: true,
            title:
                '${translate('alert_payment_debt.title')} \n ${totalPrice != '' ? totalPrice : '0'}',
            description: '${translate('alert_payment_debt.description')}',
            textButton: '${translate('alert_payment_debt.text_button')}',
            onPressButton: () {
              onPressedWhenCharging();
            },
          );
        }
      });
    }
  }

  Future<void> onLaunchAppGotoNotificationPage() async {
    JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
    bool? hasInitNotification = jupiterPrefsAndAppData.hasInitNotification;
    bool? isLaunchFromNoti =
        await ApiFirebase().checkLaunchAppFromNotification();
    debugPrint('isLaunchFromNoti : ${isLaunchFromNoti}');
    debugPrint('hasInitNotification : ${hasInitNotification}');
    debugPrint('widget.isOpenFirstTime  : ${widget.isOpenFirstTime}');
    if (isLaunchFromNoti == true &&
        widget.isOpenFirstTime &&
        hasInitNotification == true) {
      Navigator.of(context).pushNamed(RouteNames.notification);
    }
    jupiterPrefsAndAppData.removeHasInitNotification();
  }

  String getQRCode() {
    debugPrint(
        "QRCODE ${checkStatusChargingData?.checkStatusEntity?.data?.chargerName}");
    if (checkStatusChargingData?.checkStatusEntity?.data?.chargerName != null &&
        checkStatusChargingData?.checkStatusEntity?.data?.chargerName != '') {
      return checkStatusChargingData?.checkStatusEntity?.data?.chargerName ??
          '';
    } else {
      return qrCodeData;
    }
  }

  Future<void> onPressedWhenCharging() async {
    if (!status_charger && status_receipt) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return JupiterChargingReceiptPage(
          qrCodeData: getQRCode(),
          chargerRealtimeEntity: ChargerRealtimeEntity(
            stationId: '',
            stationName: '',
            chargerName: '',
            chargerSerialNo: '',
            chargerBrand: '',
            pricePerUnit: '',
            totalConnector: 0,
            chargerType: '',
            connector: checkStatusChargingData
                ?.checkStatusEntity?.informationCharger?.connector,
            chargingMode: null,
            optionalCharging: null,
            facilityName: null,
            carSelect: null,
            paymentType: null,
            lowPriorityTariff: false,
          ),
        );
      }));
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          isPause = true;
        });
      });
      await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return JupiterChargingPage(qrCodeData: getQRCode());
      }));
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          isPause = false;
        });
      });
    }
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          _hideBottomBarAnimationController.reverse();
          _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _hideBottomBarAnimationController.forward();
          _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }

  void actionMainMenuSetStateForChangeLanguage() {
    setState(() {
      nameList = <String>[
        translate('bottom_navigation.home'),
        translate('bottom_navigation.station'),
        translate('bottom_navigation.history'),
        translate('bottom_navigation.menu'),
      ];
    });
    BlocProvider.of<MainMenuCubit>(context).resetMainMenuStateInitial();
  }

  void onPressScanQRCode() {
    if (!loadCheckStatus) {
      Navigator.pushNamed(context, RouteNames.scan_qrcode);

      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) {
      //   return const JupiterChargingReceiptPage(
      //     qrCodeData: 'ju0001ju0001201ju0001462',
      //     chargerRealtimeEntity: null,
      //   );
      // }));

      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return const JupiterChargingCheckInPage(
      //       qrCodeData: 'ju0001ju0001358ju0001826');
      // }));

      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) {
      //   return const JupiterChargingPage(
      //       qrCodeData: 'ju0001ju0001201ju0001462');
      // }));
    }
  }

  void _onTapIndex(index) {
    checkHasChargingOnTapIndexRecallCheckStatus();
    setState(() {
      _bottomNavIndex = index;
    });
  }

  void checkHasChargingOnTapIndexRecallCheckStatus() {
    checkStatusChargingData = getIt();
    if ((checkStatusChargingData?.checkStatusEntity != null) &&
        (checkStatusChargingData?.checkStatusEntity?.chargingStatus ?? false) &&
        (checkStatusChargingData?.checkStatusEntity?.data?.statusCharger ==
            true) &&
        (checkStatusChargingData?.checkStatusEntity?.data?.statusReceipt ==
            false)) {
      try {
        Utilities.getCheckStatusCharging(context);
      } catch (e) {}
    }
  }

  void actionStatusChargingLoading() {
    if (!isLoading) {
      isLoading = true;
    }
  }

  void actionStatusCharging() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!car_charging) {
        setState(() {
          car_charging = true;
        });
      }
      if (isLoading) {
        checkStatusChargingData = getIt();
        status_charger =
            checkStatusChargingData?.checkStatusEntity?.data?.statusCharger ??
                false;
        status_receipt =
            checkStatusChargingData?.checkStatusEntity?.data?.statusReceipt ??
                false;
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void actionStatusChargingInitial() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (car_charging) {
        setState(() {
          car_charging = false;
        });
      }
      if (isLoading) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  Widget _bottonNavPage(int index) {
    switch (index) {
      case 0:
        return HomePage(onTapIndex: _onTapIndex);
      case 1:
        return const MapPage();
      case 2:
        return const HistoryPage();
      case 3:
        return const MorePage();
      case 4:
        return const ScanQRCodePage();
      default:
        return HomePage(onTapIndex: _onTapIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    var sizeMedia = MediaQuery.of(context).size;
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: Scaffold(
        backgroundColor: AppTheme.black5,
        extendBody: true,
        body: NotificationListener<ScrollNotification>(
          onNotification: onScrollNotification,
          child: Container(
            color: AppTheme.transparent,
            height: sizeMedia.height,
            child: _bottonNavPage(_bottomNavIndex),
          ),
        ),
        floatingActionButton: Visibility(
          visible: !keyboardIsOpen,
          child: BlocListener<StatusChargingCubit, StatusChargingState>(
            listener: (context, state) {
              switch (state.runtimeType) {
                case StatusCharging:
                  actionStatusCharging();
                  break;
                case StatusChargingLoading:
                  actionStatusChargingLoading();
                  break;
                case StatusChargingInitial:
                  actionStatusChargingInitial();
                  break;
              }
            },
            child: SizedBox(
              width: 75,
              height: 75,
              child: car_charging
                  ? CustomButtonCharging(
                      onPressedButton: onPressedWhenCharging,
                      isPause: isPause,
                    )
                  : FloatingActionButton(
                      heroTag: "ScanButton",
                      splashColor: AppTheme.lightBlue,
                      backgroundColor: loadCheckStatus
                          ? AppTheme.gray9CA3AF
                          : _backgroundFloatingScan,
                      child: SvgPicture.asset(
                        ImageAsset.ic_qr_code,
                      ),
                      onPressed: onPressScanQRCode,
                    ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BlocListener<MainMenuCubit, MainMenuState>(
          listener: (context, state) {
            switch (state.runtimeType) {
              case MainMenuInitial:
                break;
              case MainMenuSetStateForChangeLanguage:
                actionMainMenuSetStateForChangeLanguage();
                break;
            }
          },
          child: Stack(
            children: [
              AnimatedBottomNavigationBar.builder(
                height: 80,
                itemCount: iconListActive.length,
                tabBuilder: (int index, bool isActive) {
                  var color = isActive ? _activeColor : _unActiveColor;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        isActive
                            ? iconListActive[index]
                            : iconListInActive[index],
                        width: 26,
                        height: 26,
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: AutoSizeText(
                          nameList[index],
                          maxLines: 1,
                          style: TextStyle(
                              color: color,
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.normal)),
                          group: autoSizeGroup,
                        ),
                      )
                    ],
                  );
                },
                backgroundColor: AppTheme.white,
                activeIndex: _bottomNavIndex,
                splashColor: AppTheme.white,
                notchAndCornersAnimation: borderRadiusAnimation,
                splashSpeedInMilliseconds: 300,
                notchSmoothness: NotchSmoothness.defaultEdge,
                gapLocation: GapLocation.center,
                onTap: _onTapIndex,
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 16),
                height: 80,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: AutoSizeText(
                        car_charging
                            ? translate('bottom_navigation.charging')
                            : translate('bottom_navigation.scan'),
                        maxLines: 1,
                        style: TextStyle(
                            color: _unActiveColor,
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, AppFontSize.normal)),
                        group: autoSizeGroup,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
