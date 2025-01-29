import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in/widgets/low_priority.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in/widgets/verify_car_fleet_card.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/confirm_license_plate/confirm_license_plate.dart';
import 'package:jupiter/src/presentation/widgets/check_internet_signal.dart';
import 'package:jupiter_api/config/api/api_config.dart';
import 'package:jupiter_api/data/data_models/request/car_select_form.dart';
import 'package:jupiter_api/data/data_models/request/optional_detail_form.dart';
import 'package:jupiter_api/data/data_models/request/payment_coupon_form.dart';
import 'package:jupiter_api/data/data_models/request/payment_type_form.dart';
import 'package:jupiter_api/data/data_models/response/charging_socket/realtime_status_checkin_model.dart';
import 'package:jupiter_api/domain/entities/car_select_entity.dart';
import 'package:jupiter_api/domain/entities/charger_information_entity.dart';
import 'package:jupiter_api/domain/entities/payment_type_has_defalut_entity.dart';
import 'package:jupiter_api/domain/entities/search_coupon_for_used_entity.dart';
import 'package:jupiter_api/domain/entities/status_charger_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/charging/charging_page.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in/cubit/cubit/check_in_cubit.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in/widgets/advance_options_charging.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in/widgets/check_in_page_loading.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in/widgets/check_in_page_text_error.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in/widgets/floating_action_slider_button.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in/widgets/modal_bottom_battery.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in/widgets/modal_bottom_offer.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in/widgets/select_payment.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in/widgets/select_vehicle.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in/widgets/text_empty_select_payment.dart';
import 'package:jupiter/src/presentation/socket_charging/socket_jupiter.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jupiter_api/jupiter_api.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../../../firebase_log.dart';
import '../../../../route_names.dart';
import 'widgets/charger_data.dart';
import 'widgets/charging_mode.dart';
import 'widgets/select_offers.dart';
import 'package:jupiter/src/presentation/widgets/lifecycle_watcher_state.dart';

class JupiterChargingCheckInPage extends StatefulWidget {
  const JupiterChargingCheckInPage({
    super.key,
    required this.qrCodeData,
    this.fleetType,
    this.fromFleet,
    this.fleetNo,
  });

  final String qrCodeData;
  final String? fleetType;
  final bool? fromFleet;
  final int? fleetNo;

  @override
  State<JupiterChargingCheckInPage> createState() =>
      _JupiterChargingCheckInPageState();
}

class _JupiterChargingCheckInPageState
    extends LifecycleWatcherState<JupiterChargingCheckInPage>
    with TickerProviderStateMixin {
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  StatusChargerEntity? statusChargerEntity;
  ChargerInformationEntity? responseChargerData;
  List<CarSelectEntity> listCar = [];
  List<PaymentTypeHasDefalutEntity> listPayment = [];
  String connectStatus = '';
  double heightAppbar = AppBar().preferredSize.height;
  bool isLoadingCheckIn = false;
  bool isPushPageAddCard = false;
  bool isPushPageAddVehicle = false;
  // SLIEDER BUTTON
  late bool processReady;
  late bool startChargingEnabled = false;
  late bool isVerifyCarByOcr = false; // FOR VERIFT FLEET CARD
  late bool isCheckedFirst = false;
  // OCR
  String imagePath = ''; // FOR VERIFT FLEET CARD
  bool isOpeningCamera = false;
  bool isUseOcr = false;
  bool configOpenOcr = false;
  // TAB MODE
  late TabController _tabModeController;
  Color _standardColor = AppTheme.white;
  Color _highSpeedColor = AppTheme.blueD;
  // TAB OPTION CHARGING
  late TabController _tabOptionChargingController;
  ScrollController scrollController = ScrollController();
  // CAR & PAYMENT
  bool isCheckDefaultCar = false;
  bool isCheckDefaultCard = false;
  int carIndexSelected = -1;
  int paymentIndexSelected = -1;
  bool emptyPayment = false;
  // CHARGING ENERGY
  double defaultEnergyValue = 10;
  double minEnergyValue = 10;
  double maxEnergyValue = 150;
  final TextEditingController _energyOptionController = TextEditingController();
  // CHARGING DURATION
  int hourSelectedIndex = 0;
  int minuteSelectedIndex = 0;
  // CHARGING AMOUNT
  int costSelectedIndex = 0;
  List<int> listItemCost = [100, 150, 200, 250, 300, 350, 400, 450, 500];
  // BATTERY
  final TextEditingController _batteryOptionController =
      TextEditingController();
  bool hasBat = false;
  // SOCKET
  bool checkOpenSocket = false;
  RealtimeStatusCheckinModel? realtimeData;
  StreamSocketStatus streamSocketStatus = StreamSocketStatus();
  Socket socket = io(
      '${JupiterApi.getBaseUrl(ApiConfig.env)}/information-realtime-charging/',
      OptionBuilder()
          .setQuery({'token': ''})
          .setTransports(['websocket'])
          .setPath('/information-realtime-charging/')
          .build());
  List<SearchCouponItemForUsedEntity> listCoupon = List.empty(growable: true);
  SearchCouponItemForUsedEntity? couponSelected;
  bool hightspeedStatus = false;
  // COUPON
  bool checkUseCoupon = true;
  int limitShowListVenhicle = 5;
  List<CarSelectEntity> listCarOld = [];

  @override
  void initState() {
    FirebaseLog.logPage(this);
    processReady = false;
    _batteryOptionController.text = '0';
    initTabModeController(isForce: true);
    initTabOptionController();
    initEnergyOptionController();
    fetchCheckInApi();
    super.initState();
  }

  @override
  void dispose() {
    try {
      _tabModeController.dispose();
      _tabOptionChargingController.dispose();
    } catch (e) {}
    super.dispose();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        bool isLocked = jupiterPrefsAndAppData.isLocked;
        if (!processReady &&
            !isPushPageAddCard &&
            !isPushPageAddVehicle &&
            !isLocked) {
          onRefreshApi();
        }
      });
    });
  }

  void onRefreshApi() {
    if (!isLoadingCheckIn && !processReady) {
      checkOpenSocket = false;
      streamSocketStatus = StreamSocketStatus();
      socket = io(
          '${JupiterApi.getBaseUrl(ApiConfig.env)}/information-realtime-charging/',
          OptionBuilder()
              .setQuery({'token': ''})
              .setTransports(['websocket'])
              .setPath('/information-realtime-charging/')
              .build());
      fetchCheckInApi();
    }
  }

  void fetchCheckInApi() {
    switch (widget.fleetType) {
      case FleetType.CARD:
        BlocProvider.of<CheckInCubit>(context)
            .fetchCheckInFleetCard(widget.qrCodeData, widget.fleetNo ?? -1);
        break;
      case FleetType.OPERATION:
        BlocProvider.of<CheckInCubit>(context).fetchCheckInFleetOperation(
            widget.qrCodeData, widget.fleetNo ?? -1);
        break;
      default:
        BlocProvider.of<CheckInCubit>(context)
            .loadInfomation(widget.qrCodeData);
        break;
    }
  }

  String getEventSocket() {
    String event = 'status|${widget.qrCodeData}';
    debugPrint('SOCKET EVENT : ${event}');
    return event;
  }

  Future<void> useSocketToGetStatusCharging(String token) async {
    if (!checkOpenSocket) {
      socket = io(
          '${JupiterApi.getBaseUrl(ApiConfig.env)}/information-realtime-charging/',
          OptionBuilder()
              .setQuery({'token': token})
              .setTransports(['websocket'])
              .setPath('/information-realtime-charging/')
              .build());

      socket.onConnect((_) {
        debugPrint('connect');
      });
      socket.on(
          getEventSocket(),
          (data) => {
                debugPrint('SOCKET STATUS : $data'),
                streamSocketStatus
                    .addResponse(RealtimeStatusCheckinModel.fromJson(data)),
              });
      socket.onConnectError((data) => {
            debugPrint('connectError $data'),
          });
      socket.onError((data) => debugPrint('onError $data'));
      socket.onDisconnect((_) => debugPrint('disconnect'));
      checkOpenSocket = true;
    }
  }

  void initEnergyOptionController() {
    _energyOptionController.text = defaultEnergyValue.toString();
  }

  void initTabModeController({bool? isForce}) {
    if (isForce == true) {
      _tabModeController = TabController(length: 1, vsync: this);
      return;
    }
    if (hightspeedStatus) {
      _tabModeController = TabController(length: 2, vsync: this);
    } else {
      _tabModeController = TabController(length: 1, vsync: this);
    }
    _tabModeController.addListener(() {
      if (!_tabModeController.indexIsChanging) {
        // Your code goes here.
        // To get index of current tab use tabController.index
        int index = _tabModeController.index;
        if (index == 0) {
          _standardColor = AppTheme.white;
          _highSpeedColor = AppTheme.blueD;
        }
        if (index == 1) {
          _standardColor = AppTheme.blueDark;
          _highSpeedColor = AppTheme.white;
        }
        setState(() {});
      }
    });
  }

  void initTabOptionController() {
    _tabOptionChargingController = TabController(length: 4, vsync: this);
    _tabOptionChargingController.addListener(() {
      if (!_tabOptionChargingController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  bool getEnabledSlideButton() {
    if (configOpenOcr) {
      return isVerifyCarByOcr && startChargingEnabled;
    } else {
      return startChargingEnabled;
    }
  }

  String getLabelSlideButton() {
    if (configOpenOcr) {
      if (isVerifyCarByOcr && startChargingEnabled) {
        return translate('check_in_page.slide_button_active');
      } else if (startChargingEnabled && !isVerifyCarByOcr) {
        return translate('check_in_page.verify_ocr.slide_button_please_verify');
      } else if (!startChargingEnabled && isVerifyCarByOcr) {
        return translate('check_in_page.slide_button_inactive');
      } else {
        return translate('check_in_page.verify_ocr.slide_button_inactive_both');
      }
    } else {
      switch (startChargingEnabled) {
        case true:
          return translate('check_in_page.slide_button_active');
        case false:
          return translate('check_in_page.slide_button_inactive');
      }
    }
  }

  void showDialogTutorial() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => PopScope(
        canPop: false,
        onPopInvoked: (bool value) {},
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          actionsAlignment: MainAxisAlignment.center,
          titlePadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
          contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 0),
          actionsPadding: EdgeInsets.fromLTRB(24, 16, 24, 20),
          title: Center(
              child: Column(
            children: [
              Image.asset(
                ImageAsset.gif_car_ocr,
              ),
              TextLabel(
                text: translate('check_in_page.verify_ocr.text_title'),
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
                  text: translate('check_in_page.verify_ocr.info_des'),
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
                      backgroundColor: AppTheme.blueD,
                      elevation: 0.0,
                      shadowColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(200)),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onPressedOpenCameraToOcr();
                    },
                    child: TextLabel(
                      text: translate('check_in_page.verify_ocr.start_scan'),
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
    );
  }

  Future<void> onPressedOpenCameraToOcr() async {
    if (carIndexSelected < 0) {
      Utilities.alertOneButtonAction(
        context: context,
        type: AppAlertType.DEFAULT,
        isForce: true,
        title: translate('alert.title.default'),
        description: translate('check_in_page.verify_ocr.please_select_car'),
        textButton: translate('button.Ok'),
        onPressButton: () {
          Navigator.of(context).pop();
        },
      );
    } else {
      if (!isOpeningCamera) {
        try {
          isOpeningCamera = true;
          var result = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return ConfirmLicensePlate(
              license_plate_check: listCar[carIndexSelected].licensePlate ?? '',
            );
          }));
          if (result.toString() == OcrStatus.APPROVED) {
            setState(() {
              isOpeningCamera = false;
              isVerifyCarByOcr = true;
              isUseOcr = true;
            });
          } else if (result.toString() == OcrStatus.REJECTED) {
            setState(() {
              isOpeningCamera = false;
              isVerifyCarByOcr = false;
              isUseOcr = true;
            });
          } else {
            setState(() {
              isOpeningCamera = false;
            });
          }
        } catch (e) {
          setState(() {
            isOpeningCamera = false;
          });
        }
      }
    }
  }

  void checkActiveButtonStartChargingFirst(String status) {
    if (status != '') {
      if (status == 'preparing') {
        setState(() {
          startChargingEnabled = true;
          connectStatus = status;
        });
      } else {
        setState(() {
          startChargingEnabled = false;
          connectStatus = status;
        });
      }
    }
    isCheckedFirst = true;
  }

  void checkActiveButtonStartCharging(String status) {
    if (status != '' && connectStatus != status) {
      if (status == 'preparing') {
        setState(() {
          startChargingEnabled = true;
          connectStatus = status;
        });
      } else {
        setState(() {
          startChargingEnabled = false;
          connectStatus = status;
        });
      }
    }
  }

  void setBatteryOfSelectedVehicle(int index) {
    if (listCar[index].batteryCapacity != null &&
        listCar[index].batteryCapacity == 0) {
      hasBat = false;
      _batteryOptionController.text = '0';
    } else {
      _batteryOptionController.text = listCar[index].batteryCapacity != null
          ? listCar[index].batteryCapacity!.toInt().toString()
          : '0';
      hasBat = true;
    }
  }

  void onSelectVehicle(int index) {
    _batteryOptionController.text = '0';
    // เรียงให้รถที่เลือกใน ดูเพิ่มเติม มาอยู่ตำแหน่งแรก
    if (listCar.length >= limitShowListVenhicle) {
      if (index < limitShowListVenhicle - 1) {
        carIndexSelected = index;
      } else {
        CarSelectEntity itemSelected = listCar[index];
        listCar.removeAt(index);
        listCar.insert(0, itemSelected);

        listCarOld = listCar;
        carIndexSelected = 0;
      }
    } else {
      carIndexSelected = index;
    }

    setState(() {
      hasBat = false;
    });
  }

  void onClickAddVehicle() {
    if (!processReady) {
      _navigateAndLoadCarlist(context);
    }
  }

  void onCloseModal() {
    hasBat = false;
    _batteryOptionController.text = '0';
    setState(() {});
    Navigator.pop(context);
  }

  void onDoneModal() {
    hasBat = true;
    if (_batteryOptionController.text != '') {
      String textTest = _batteryOptionController.text;
      while (textTest.startsWith('0')) {
        textTest = textTest.substring(1);
      }
      _batteryOptionController.text = textTest;
    }
    if (_batteryOptionController.text == '') {
      _batteryOptionController.text = '0';
    } else if (int.parse(_batteryOptionController.text) > 100) {
      _batteryOptionController.text = '100';
    }
    setState(() {});
    Navigator.pop(context);
  }

  void onSelectPayment(int index) {
    setState(() {
      paymentIndexSelected = index;
      emptyPayment = false;
    });
  }

  void onClickAddCard() {
    if (!processReady) {
      _navigateAndLoadCardlist(context);
    }
  }

  void onClickIncreaseChargingEnergy() {
    double energy = double.parse(_energyOptionController.text);
    if (energy < maxEnergyValue) {
      energy += 10;
    }
    if (energy + 10 > maxEnergyValue) {
      energy = maxEnergyValue;
    }
    _energyOptionController.text = energy.toString();
    onSlideChangeChargingEnergy(energy);
  }

  void onClickReduceChargingEnergy() {
    double energy = double.parse(_energyOptionController.text);
    if (energy - 10 <= minEnergyValue) {
      energy = minEnergyValue;
    } else {
      energy -= 10;
    }
    _energyOptionController.text = energy.toString();
    onSlideChangeChargingEnergy(energy);
  }

  void onSlideChangeChargingEnergy(double value) {
    _energyOptionController.text = value.floor().toString();
    setState(() {});
  }

  void onSelectedHourItem(int index) {
    hourSelectedIndex = index;
    setState(() {});
  }

  void onSelectedMinuteItem(int index) {
    minuteSelectedIndex = index;
    setState(() {});
  }

  void onClickItemCost(int index) {
    costSelectedIndex = index;
    setState(() {});
  }

  void setDefaultCar() {
    if (!isCheckDefaultCar) {
      int countDefalut = 0;
      for (int i = 0; i < listCar.length; i++) {
        if (listCar[i].defalut ?? false) {
          carIndexSelected = i;
          ++countDefalut;
          break;
        }
      }
      if (countDefalut == 0) {
        // กรณีไม่พบรถ defalut
        carIndexSelected = -1;
      } else {
        // เรียงให้รถที่ defalut มาอยู่ตำแหน่งแรก
        CarSelectEntity itemSelected = listCar[carIndexSelected];
        listCar.removeAt(carIndexSelected);
        listCar.insert(0, itemSelected);
        carIndexSelected = 0;
      }
      listCarOld = listCar;

      isCheckDefaultCar = true;
    } else {
      setSelectCar();
    }
  }

  void setDefaultCard() {
    if (!isCheckDefaultCard) {
      for (int i = 0; i < listPayment.length; i++) {
        if (listPayment[i].defalut ?? false) {
          paymentIndexSelected = i;
          break;
        }
      }
      isCheckDefaultCard = true;
    }
  }

  void setSelectCar() {
    if (isCheckDefaultCard && carIndexSelected != -1) {
      int searchCar = listCar.indexWhere((item) =>
          ((item.licensePlate == listCarOld[carIndexSelected].licensePlate) &&
              (item.province == listCarOld[carIndexSelected].province)));
      if (searchCar >= 0) {
        // เรียงให้รถที่เลือกมาอยู่ตำแหน่งแรก
        CarSelectEntity itemSelected = listCar[searchCar];
        listCar.removeAt(searchCar);
        listCar.insert(0, itemSelected);
        carIndexSelected = 0;
      }
      listCarOld = listCar;
    }
  }

  void onExpansionChanged(bool isExpand) {
    if (isExpand) {
      Timer(const Duration(milliseconds: 300), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 100),
        );
      });
    }
  }

  String getValueOptionChargingFromIndex() {
    switch (_tabOptionChargingController.index) {
      case 0:
        return 'full';
      case 1:
        return 'energy';
      case 2:
        return 'duration';
      case 3:
        return 'amount';
      default:
        return 'full';
    }
  }

  String getUnitOptionChargingFromIndex() {
    switch (_tabOptionChargingController.index) {
      case 0:
        return 'N/A';
      case 1:
        return 'kW';
      case 2:
        return 'minute';
      case 3:
        return '฿';
      default:
        return 'N/A';
    }
  }

  String getValueModeFromIndex() {
    switch (_tabModeController.index) {
      case 0:
        return 'standard';
      case 1:
        return 'hightspeed';
      default:
        return 'standard';
    }
  }

  double getValueDurationFromHourAndMinuteSelected() {
    return (hourSelectedIndex * 60) + (minuteSelectedIndex * 15);
  }

  double getValueCostFromAmountSelected() {
    return 100 + (costSelectedIndex * 50);
  }

  double getValueOptionFromOptionIndex() {
    switch (_tabOptionChargingController.index) {
      case 0:
        return 0;
      case 1:
        if (_energyOptionController.text.isEmpty) {
          return 10;
        }
        if (double.parse(_energyOptionController.text) > 150) {
          return 150;
        }
        return double.parse(_energyOptionController.text);
      case 2:
        return getValueDurationFromHourAndMinuteSelected();
      case 3:
        return getValueCostFromAmountSelected();
      default:
        return 0;
    }
  }

  String getTextBattery() {
    if (hasBat) {
      return '${translate('check_in_page.battery.current_battery')} ${_batteryOptionController.text}%';
    } else {
      return translate('check_in_page.select_vehicle.add_battery');
    }
  }

  void onPressedBackButton() {
    if (!processReady) {
      socket.disconnect();
      if (widget.fromFleet == true && widget.fleetType == FleetType.CARD) {
        Navigator.of(context).pop({
          'qrcode': '',
          'isShow': false,
        });
      } else {
        Navigator.of(context).pop();
      }
    }
  }

  Future<bool?> onActionStartCharging() async {
    if (paymentIndexSelected < 0) {
      debugPrint('PAYMENT SELECTED : NOT SELECT');
      scrollController.animateTo(
        scrollController.position.maxScrollExtent / 2,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 100),
      );
      setState(() {
        emptyPayment = true;
      });
      setState(() {
        processReady = true;
      });
      Utilities.alertOneButtonAction(
        context: context,
        type: AppAlertType.DEFAULT,
        isForce: true,
        title: translate('alert.title.default'),
        description: translate('check_in_page.select_payment.error'),
        textButton: translate('button.try_again'),
        onPressButton: () {
          Navigator.of(context).pop();
          setState(() {
            processReady = false;
          });
        },
      );
    } else if (checkUseCoupon == false) {
      debugPrint('COUPON : NOT USE COUPON');
      setState(() {
        processReady = true;
      });
      Utilities.alertOneButtonAction(
        context: context,
        type: AppAlertType.DEFAULT,
        isForce: true,
        title: translate('alert.title.default'),
        description: translate("check_in_page.select_offers.error"),
        textButton: translate('button.try_again'),
        onPressButton: () {
          Navigator.of(context).pop();
          setState(() {
            processReady = false;
          });
        },
      );
    } else if (connectStatus != 'preparing') {
      debugPrint('CHARGER : NOT PREPARING');
    } else if (widget.fromFleet == true && carIndexSelected < 0) {
      debugPrint('CAR SELECTED : NOT SELECT');
      setState(() {
        processReady = true;
      });
      Utilities.alertOneButtonAction(
        context: context,
        type: AppAlertType.DEFAULT,
        isForce: true,
        title: translate('alert.title.default'),
        description: translate('check_in_page.select_vehicle.error'),
        textButton: translate('button.try_again'),
        onPressButton: () {
          Navigator.of(context).pop();
          setState(() {
            processReady = false;
          });
        },
      );
    } else {
      setState(() {
        processReady = true;
      });
      if (widget.fromFleet == true) {
        switch (widget.fleetType) {
          case FleetType.CARD:
            BlocProvider.of<CheckInCubit>(context).fleetStartChargingCard(
              chargerId: responseChargerData?.connector?.chargerId,
              connectorId: responseChargerData?.connector?.connectorId,
              connectorIndex: responseChargerData?.connector?.connectorIndex,
              chargingType: getValueModeFromIndex(),
              chargerType: responseChargerData?.chargerType,
              fleetNo: widget.fleetNo ?? -1,
              fleetType: (widget.fleetType ?? '').toLowerCase(),
              optionalCharging: OptionalDetailForm(
                optionalType: getValueOptionChargingFromIndex(),
                optionalValue: getValueOptionFromOptionIndex(),
                optionalUnit: getUnitOptionChargingFromIndex(),
              ),
              qrCode: widget.qrCodeData,
              orgCode: ConstValue.orgCode,
              carSelected: carIndexSelected == -1
                  ? CarSelectForm(
                      vehicleNo: listCar[0].vehicleNo,
                      brand: listCar[0].brand ?? '',
                      licensePlate: listCar[0].licensePlate ?? '',
                      model: listCar[0].model ?? '',
                      province: listCar[0].province ?? '',
                      batteryCapacity: listCar[0].batteryCapacity ?? 0,
                      currentPercentBattery:
                          double.parse(_batteryOptionController.text),
                      maximumChargingPowerAc:
                          listCar[0].maximumChargingPowerAc ?? 0,
                      maximumChargingPowerDc:
                          listCar[0].maximumChargingPowerDc ?? 0,
                      image: listCar[0].image ?? '',
                      maxDistance: listCar[0].maxDistance ?? 0,
                    )
                  : CarSelectForm(
                      vehicleNo: listCar[carIndexSelected].vehicleNo,
                      brand: listCar[carIndexSelected].brand ?? '',
                      licensePlate:
                          listCar[carIndexSelected].licensePlate ?? '',
                      model: listCar[carIndexSelected].model ?? '',
                      province: listCar[carIndexSelected].province ?? '',
                      batteryCapacity:
                          listCar[carIndexSelected].batteryCapacity ?? 0,
                      currentPercentBattery: hasBat
                          ? double.parse(_batteryOptionController.text)
                          : -1,
                      maximumChargingPowerAc:
                          listCar[carIndexSelected].maximumChargingPowerAc ?? 0,
                      maximumChargingPowerDc:
                          listCar[carIndexSelected].maximumChargingPowerDc ?? 0,
                      image: listCar[carIndexSelected].image ?? '',
                      maxDistance: listCar[carIndexSelected].maxDistance ?? 0,
                    ),
              paymentSelected: PaymentTypeForm(
                type: listPayment[paymentIndexSelected].type,
                display: listPayment[paymentIndexSelected].display,
                token: listPayment[paymentIndexSelected].token,
                brand: listPayment[paymentIndexSelected].brand,
                name: listPayment[paymentIndexSelected].name,
              ),
              data: responseChargerData!,
              couponSelected: null,
            );
            break;
          case FleetType.OPERATION:
            BlocProvider.of<CheckInCubit>(context).fleetStartChargingOperation(
              chargerId: responseChargerData?.connector?.chargerId,
              connectorId: responseChargerData?.connector?.connectorId,
              connectorIndex: responseChargerData?.connector?.connectorIndex,
              chargingType: getValueModeFromIndex(),
              chargerType: responseChargerData?.chargerType,
              fleetNo: widget.fleetNo ?? -1,
              fleetType: (widget.fleetType ?? '').toLowerCase(),
              optionalCharging: OptionalDetailForm(
                optionalType: getValueOptionChargingFromIndex(),
                optionalValue: getValueOptionFromOptionIndex(),
                optionalUnit: getUnitOptionChargingFromIndex(),
              ),
              qrCode: widget.qrCodeData,
              orgCode: ConstValue.orgCode,
              carSelected: carIndexSelected == -1
                  ? CarSelectForm(
                      vehicleNo: listCar[0].vehicleNo,
                      brand: listCar[0].brand ?? '',
                      licensePlate: listCar[0].licensePlate ?? '',
                      model: listCar[0].model ?? '',
                      province: listCar[0].province ?? '',
                      batteryCapacity: listCar[0].batteryCapacity ?? 0,
                      currentPercentBattery:
                          double.parse(_batteryOptionController.text),
                      maximumChargingPowerAc:
                          listCar[0].maximumChargingPowerAc ?? 0,
                      maximumChargingPowerDc:
                          listCar[0].maximumChargingPowerDc ?? 0,
                      image: listCar[0].image ?? '',
                      maxDistance: listCar[0].maxDistance ?? 0,
                    )
                  : CarSelectForm(
                      vehicleNo: listCar[carIndexSelected].vehicleNo,
                      brand: listCar[carIndexSelected].brand ?? '',
                      licensePlate:
                          listCar[carIndexSelected].licensePlate ?? '',
                      model: listCar[carIndexSelected].model ?? '',
                      province: listCar[carIndexSelected].province ?? '',
                      batteryCapacity:
                          listCar[carIndexSelected].batteryCapacity ?? 0,
                      currentPercentBattery: hasBat
                          ? double.parse(_batteryOptionController.text)
                          : -1,
                      maximumChargingPowerAc:
                          listCar[carIndexSelected].maximumChargingPowerAc ?? 0,
                      maximumChargingPowerDc:
                          listCar[carIndexSelected].maximumChargingPowerDc ?? 0,
                      image: listCar[carIndexSelected].image ?? '',
                      maxDistance: listCar[carIndexSelected].maxDistance ?? 0,
                    ),
              paymentSelected: PaymentTypeForm(
                type: listPayment[paymentIndexSelected].type,
                display: listPayment[paymentIndexSelected].display,
                token: listPayment[paymentIndexSelected].token,
                brand: listPayment[paymentIndexSelected].brand,
                name: listPayment[paymentIndexSelected].name,
              ),
              data: responseChargerData!,
              couponSelected: null,
            );
            break;
          default:
        }
      } else {
        BlocProvider.of<CheckInCubit>(context).startCharging(
            chargerId: responseChargerData?.connector?.chargerId,
            connectorId: responseChargerData?.connector?.connectorId,
            connectorIndex: responseChargerData?.connector?.connectorIndex,
            chargingType: getValueModeFromIndex(),
            chargerType: responseChargerData?.chargerType,
            optionalCharging: OptionalDetailForm(
              optionalType: getValueOptionChargingFromIndex(),
              optionalValue: getValueOptionFromOptionIndex(),
              optionalUnit: getUnitOptionChargingFromIndex(),
            ),
            qrCode: widget.qrCodeData,
            orgCode: ConstValue.orgCode,
            carSelected: carIndexSelected == -1
                ? null
                : CarSelectForm(
                    vehicleNo: listCar[carIndexSelected].vehicleNo,
                    brand: listCar[carIndexSelected].brand ?? '',
                    licensePlate: listCar[carIndexSelected].licensePlate ?? '',
                    model: listCar[carIndexSelected].model ?? '',
                    province: listCar[carIndexSelected].province ?? '',
                    batteryCapacity:
                        listCar[carIndexSelected].batteryCapacity ?? 0,
                    currentPercentBattery: hasBat
                        ? double.parse(_batteryOptionController.text)
                        : -1,
                    maximumChargingPowerAc:
                        listCar[carIndexSelected].maximumChargingPowerAc ?? 0,
                    maximumChargingPowerDc:
                        listCar[carIndexSelected].maximumChargingPowerDc ?? 0,
                    image: listCar[carIndexSelected].image ?? '',
                    maxDistance: listCar[carIndexSelected].maxDistance ?? 0,
                  ),
            paymentSelected: PaymentTypeForm(
              type: listPayment[paymentIndexSelected].type,
              display: listPayment[paymentIndexSelected].display,
              token: listPayment[paymentIndexSelected].token,
              brand: listPayment[paymentIndexSelected].brand,
              name: listPayment[paymentIndexSelected].name,
            ),
            data: responseChargerData!,
            couponSelected: couponSelected != null
                ? PaymentCouponForm(
                    couponNo: couponSelected!.couponNo,
                    couponCode: couponSelected!.couponCode,
                    couponName: couponSelected!.couponName,
                    discountType: couponSelected!.discountType,
                    discountValue: couponSelected!.discountValue,
                    minimumPrice: couponSelected!.minimumPrice,
                    maximumDiscountEnable:
                        couponSelected!.maximumDiscountEnable,
                    maximumDiscount: couponSelected!.maximumDiscount)
                : null);
      }
    }
    return Future.value(true);
  }

  Future<void> _navigateAndLoadCarlist(context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isPushPageAddVehicle = true;
      });
    });
    await Navigator.pushNamed(context, RouteNames.ev_information_add);
    streamSocketStatus = StreamSocketStatus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isPushPageAddVehicle = false;
        isCheckDefaultCar = false;
      });
    });
    BlocProvider.of<CheckInCubit>(context).loadInfomation(widget.qrCodeData);
  }

  Future<void> _navigateAndLoadCardlist(context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isPushPageAddCard = true;
      });
    });
    await Navigator.pushNamed(context, RouteNames.payment_kbank);
    streamSocketStatus = StreamSocketStatus();
    emptyPayment = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isPushPageAddCard = false;
      });
    });
    BlocProvider.of<CheckInCubit>(context).loadInfomation(widget.qrCodeData);
  }

  void onTapIsUse(SearchCouponItemForUsedEntity? data) {
    couponSelected = data;
    if (couponSelected == null) {
      checkUseCoupon = true;
    } else {
      checkUseCoupon = couponSelected?.statusCanUse ?? true;
    }
    setState(() {});
  }

  void onPressedShowModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      builder: (BuildContext context) {
        return ModalBottomOffer(
          listItemOffer: listCoupon,
          controllerTextSearch: TextEditingController(),
          onSelectCouponOffer: onTapIsUse,
          ItemOffer: couponSelected,
        );
      },
    );
  }

  void actionCheckInSuccess(dynamic state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoadingCheckIn) {
        isLoadingCheckIn = false;
        responseChargerData = state.chargerInformation;
        listCar = state.chargerInformation?.carSelect ?? [];
        listPayment = state.chargerInformation?.paymentType ?? [];
        setDefaultCar();
        setDefaultCard();
        useSocketToGetStatusCharging(state.token ?? '');
        if (!isCheckedFirst) {
          checkActiveButtonStartChargingFirst(
              state.chargerInformation?.connector?.connectorStatusActive ?? '');
        }
        hightspeedStatus = state?.chargerInformation?.hightspeedStatus ?? false;
        initTabModeController();
        if (widget.fromFleet != true) {
          BlocProvider.of<CheckInCubit>(context).loadCouponSearch();
        }
        BlocProvider.of<CheckInCubit>(context).fetchResetCubitToInital();
      }
    });
  }

  Widget actionCheckInLoading() {
    isLoadingCheckIn = true;
    return CheckInPageLoading();
  }

  Widget actionCheckInFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoadingCheckIn) {
        isLoadingCheckIn = false;
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.DEFAULT,
          isForce: true,
          title: translate('alert.title.default'),
          description: state.message ?? translate('alert.description.default'),
          textButton: translate('button.try_again'),
          onPressButton: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        );
      }
    });
    return CheckInPageTextError();
  }

  void actionCheckInCheckStartChargingFailure(state) {
    if (processReady) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          processReady = false;
        });
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.DEFAULT,
          isForce: true,
          title: translate('alert.title.default'),
          description:
              '${translate('check_in_page.start_charging_error')}\n(${state.message})',
          textButton: translate('button.try_again'),
          onPressButton: () {
            Navigator.of(context).pop();
          },
        );
      });
    }
  }

  void actionCheckInCheckStartChargingSuccess() {
    if (processReady) {
      socket.disconnect();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          processReady = false;
        });
        BlocProvider.of<CheckInCubit>(context).fetchResetCubitToInital();
        switch (widget.fleetType) {
          case FleetType.CARD:
            Navigator.of(context).pop({
              'qrcode': widget.qrCodeData,
              'isShow':
                  (responseChargerData?.chargerType?.toUpperCase() ?? 'N/A') ==
                      'DC',
            });
            // Navigator.of(context)
            //     .pushReplacement(MaterialPageRoute(builder: (context) {
            //   return JupiterChargingPage(
            //     qrCodeData: widget.qrCodeData,
            //     fleetNo: widget.fleetNo ?? -1,
            //     fleetType: widget.fleetType ?? '',
            //     fromFleet: widget.fromFleet,
            //   );
            // }));
            break;
          case FleetType.OPERATION:
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return JupiterChargingPage(
                qrCodeData: widget.qrCodeData,
                fleetNo: widget.fleetNo ?? -1,
                fleetType: widget.fleetType ?? '',
                fromFleet: widget.fromFleet,
                showModalWaitingCharger:
                    (responseChargerData?.chargerType?.toUpperCase() ??
                            'N/A') ==
                        'DC',
              );
            }));
            break;
          default:
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return JupiterChargingPage(
                qrCodeData: widget.qrCodeData,
                showModalWaitingCharger:
                    (responseChargerData?.chargerType?.toUpperCase() ??
                            'N/A') ==
                        'DC',
              );
            }));
        }
      });
    }
  }

  void actionCouponSearchLoading() {}

  void actionCouponSearchSuccess(couponEntity) {
    listCoupon = couponEntity;
  }

  void actionCouponSearchFailure() {}

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool value) {
        debugPrint('PopScope : ${value}');
        if (!value) {
          onPressedBackButton();
        }
      },
      child: RefreshIndicator(
        onRefresh: () async {
          onRefreshApi();
        },
        child: Scaffold(
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
                text: translate('app_title.checkin'),
                color: AppTheme.blueDark,
                fontSize: Utilities.sizeFontWithDesityForDisplay(context, 32),
                fontWeight: FontWeight.w700,
              ),
              actions: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: CheckInternetSignal(
                    sizeCircle: 35,
                  ),
                )
              ]),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.white,
                  AppTheme.blueLight,
                ],
              ),
            ),
            child: BlocBuilder<CheckInCubit, CheckInState>(
                builder: (context, state) {
              switch (state.runtimeType) {
                case CheckInLoading:
                  return actionCheckInLoading();
                case CheckInFailure:
                  return actionCheckInFailure(state);
                case CheckInSuccess:
                  actionCheckInSuccess(state);
                  break;
                case CheckInCheckStartChargingFailure:
                  actionCheckInCheckStartChargingFailure(state);
                  break;
                case CheckInCheckStartChargingSuccess:
                  actionCheckInCheckStartChargingSuccess();
                  break;
                case CouponSearchLoading:
                  actionCouponSearchLoading();
                  break;
                case CouponSearchSuccess:
                  actionCouponSearchSuccess(state.couponSearch);
                  break;
                case CouponSearchFailure:
                  actionCouponSearchFailure();
                  break;
                default:
                  break;
              }
              return Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  FractionallySizedBox(
                    widthFactor: 1,
                    heightFactor: 1,
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification:
                          (OverscrollIndicatorNotification overscroll) {
                        overscroll.disallowIndicator();
                        return true;
                      },
                      child: ListView(
                        physics: ClampingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        controller: scrollController,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                TextLabel(
                                  text: responseChargerData?.stationName ?? '',
                                  fontSize:
                                      Utilities.sizeFontWithDesityForDisplay(
                                          context, AppFontSize.superlarge),
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.blueDark,
                                ),
                                const SizedBox(height: 4),
                                // CHARGER DATA REALTIME
                                StreamBuilder<RealtimeStatusCheckinModel>(
                                  stream: streamSocketStatus.getResponse,
                                  builder: (context, snapshot) {
                                    if (snapshot.data != null) {
                                      realtimeData = snapshot.data;
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        checkActiveButtonStartCharging(
                                            realtimeData?.connectorStatus ??
                                                '');
                                      });
                                    }
                                    return Column(
                                      children: [
                                        ChargerData(
                                          charger_name: responseChargerData
                                                  ?.chargerName ??
                                              '',
                                          charger_type: responseChargerData
                                                  ?.chargerType ??
                                              '',
                                          total_connector: responseChargerData
                                                  ?.totalConnector
                                                  .toString() ??
                                              '',
                                          station_id: responseChargerData
                                                  ?.connector?.stationId ??
                                              '',
                                          charger_id: responseChargerData
                                                  ?.connector?.chargerId ??
                                              '',
                                          owener: responseChargerData
                                                  ?.connector?.owener ??
                                              '',
                                          connector_id: responseChargerData
                                                  ?.connector?.connectorId ??
                                              '',
                                          connector_index: responseChargerData
                                                  ?.connector?.connectorIndex
                                                  .toString() ??
                                              '',
                                          connector_type:
                                              Utilities.nameConnecterType(
                                                  responseChargerData
                                                          ?.chargerType ??
                                                      '',
                                                  responseChargerData?.connector
                                                          ?.connectorType ??
                                                      ''),
                                          connector_position:
                                              responseChargerData?.connector
                                                      ?.connectorPosition ??
                                                  '',
                                          connector_status_active:
                                              connectStatus,
                                        ),
                                        LowPriority(
                                          visible: responseChargerData
                                                  ?.lowPriorityTariff ==
                                              true,
                                        ),
                                        Center(
                                          child: connectStatus != 'preparing'
                                              ? Image.asset(
                                                  ImageAsset.plug_charging)
                                              : Image.asset(
                                                  ImageAsset.slide_charge),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              connectStatus == 'preparing'
                                                  ? Icons.check_circle_outline
                                                  : Icons.info_outline,
                                              color:
                                                  connectStatus == 'preparing'
                                                      ? AppTheme.green
                                                      : AppTheme.black40,
                                              size: 12,
                                            ),
                                            const SizedBox(width: 8),
                                            TextLabel(
                                              maxLines: 2,
                                              textDecoration:
                                                  TextDecoration.none,
                                              fontStyle: FontStyle.normal,
                                              color:
                                                  connectStatus == 'preparing'
                                                      ? AppTheme.green
                                                      : AppTheme.black40,
                                              text: connectStatus == 'preparing'
                                                  ? translate(
                                                      'check_in_page.plug_in_success')
                                                  : translate(
                                                      'check_in_page.plug_in'),
                                              fontSize: Utilities
                                                  .sizeFontWithDesityForDisplay(
                                                      context,
                                                      AppFontSize.normal),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                const SizedBox(height: 12),
                                ChargingMode(
                                  controller: _tabModeController,
                                  standardColor: _standardColor,
                                  highSpeedColor: _highSpeedColor,
                                  standard_charger_power: responseChargerData
                                          ?.standardChargerPower ??
                                      0,
                                  standard_charger_price: responseChargerData
                                          ?.standardChargerPrice ??
                                      '',
                                  standard_charger_power_unit:
                                      responseChargerData
                                              ?.standardChargerPowerUnit ??
                                          '',
                                  standard_charger_price_unit:
                                      responseChargerData
                                              ?.standardChargerPriceUnit ??
                                          '',
                                  hightspeed_charger_power: responseChargerData
                                          ?.hightspeedChargerPower ??
                                      0,
                                  hightspeed_charger_price: responseChargerData
                                          ?.hightspeedChargerPrice ??
                                      '',
                                  hightspeed_charger_power_unit:
                                      responseChargerData
                                              ?.hightspeedChargerPowerUnit ??
                                          '',
                                  hightspeed_charger_price_unit:
                                      responseChargerData
                                              ?.hightspeedChargerPriceUnit ??
                                          '',
                                  hightspeedStatus:
                                      responseChargerData?.hightspeedStatus ??
                                          false,
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 16, 16, 0),
                                  decoration: BoxDecoration(
                                    color: AppTheme.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    children: [
                                      SelectVehicle(
                                        indexSelected: carIndexSelected,
                                        listItemVehicle: listCar,
                                        onSelectVehicle: onSelectVehicle,
                                        onClickAddVehicle: onClickAddVehicle,
                                        fromFleet: widget.fromFleet == true,
                                        limitShowListVenhicle:
                                            limitShowListVenhicle,
                                      ),
                                      configOpenOcr
                                          ? VerifyCarFleetCard(
                                              onTap: showDialogTutorial,
                                              status: isVerifyCarByOcr,
                                              isUseOcr: isUseOcr,
                                              licensePlate: listCar[
                                                          carIndexSelected]
                                                      .licensePlate ??
                                                  translate(
                                                      'check_in_page.verify_ocr.field_des'),
                                            )
                                          : SizedBox(),
                                      const SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          TextLabel(
                                            text: translate(
                                                'check_in_page.select_vehicle.bat_volume'),
                                            fontSize: Utilities
                                                .sizeFontWithDesityForDisplay(
                                                    context, AppFontSize.big),
                                            color: AppTheme.blueDark,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    enableDrag: false,
                                                    isDismissible: false,
                                                    isScrollControlled: true,
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                                top: Radius
                                                                    .circular(
                                                                        12))),
                                                    builder:
                                                        (BuildContext context) {
                                                      return ModalBottomBattery(
                                                        controller:
                                                            _batteryOptionController,
                                                        onCloseModal:
                                                            onCloseModal,
                                                        onDoneModal:
                                                            onDoneModal,
                                                      );
                                                    },
                                                  );
                                                  // .whenComplete(widget.onCloseModal);
                                                },
                                                child: Container(
                                                  child: TextLabel(
                                                    text: getTextBattery(),
                                                    fontSize: Utilities
                                                        .sizeFontWithDesityForDisplay(
                                                            context,
                                                            AppFontSize.big),
                                                    color: AppTheme.blueDark,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 16, 0, 16),
                                        child: Divider(
                                          height: 1,
                                          color: AppTheme.blueD,
                                        ),
                                      ),
                                      SelectPayment(
                                        error: emptyPayment,
                                        indexSelected: paymentIndexSelected,
                                        listItemPayment:
                                            responseChargerData?.paymentType ??
                                                [],
                                        onSelectPayment: onSelectPayment,
                                        onClickAddCard: onClickAddCard,
                                        fromFleet: widget.fromFleet == true,
                                      ),
                                      TextEmptySelectPayment(
                                          error: emptyPayment),
                                      widget.fromFleet != true
                                          ? Column(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 8, 0, 8),
                                                  child: Divider(
                                                    height: 1,
                                                    color: AppTheme.blueD,
                                                  ),
                                                ),
                                                SelectOffer(
                                                    listItemOffer: listCoupon,
                                                    onSelectCouponOffer:
                                                        onTapIsUse,
                                                    ItemOffer: couponSelected),
                                              ],
                                            )
                                          : SizedBox(height: 16),
                                    ],
                                  ),
                                ),
                                AdvanceOptionCharging(
                                  controller: _tabOptionChargingController,
                                  onExpansionChanged: onExpansionChanged,
                                  // ENERGY
                                  minValue: minEnergyValue,
                                  maxValue: maxEnergyValue,
                                  controllerEnergyField:
                                      _energyOptionController,
                                  onClickIncreaseChargingEnergy:
                                      onClickIncreaseChargingEnergy,
                                  onClickReduceChargingEnergy:
                                      onClickReduceChargingEnergy,
                                  onSlideChangeChargingEnergy:
                                      onSlideChangeChargingEnergy,
                                  // DURATION
                                  hourSelectedIndex: hourSelectedIndex,
                                  minuteSelectedIndex: minuteSelectedIndex,
                                  onSelectedHourItem: onSelectedHourItem,
                                  onSelectedMinuteItem: onSelectedMinuteItem,
                                  // AMOUNT
                                  listItemCost: listItemCost,
                                  onClickItemCost: onClickItemCost,
                                  selectedIndex: costSelectedIndex,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: (MediaQuery.of(context).size.height -
                                          heightAppbar) *
                                      0.1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 1,
                    heightFactor: 0.15,
                    child: FloatingActionSliderButton(
                      processReady: processReady,
                      disable: !getEnabledSlideButton(),
                      action: onActionStartCharging,
                      label: getLabelSlideButton(),
                      icon: SvgPicture.asset(
                        ImageAsset.ic_lightning,
                        width: 48,
                        height: 48,
                        colorFilter: ColorFilter.mode(
                          getEnabledSlideButton()
                              ? AppTheme.lightBlue
                              : AppTheme.black40,
                          BlendMode.srcIn,
                        ),
                        matchTextDirection: true,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
