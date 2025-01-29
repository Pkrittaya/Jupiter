import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/charging/widgets/dialog_waiting_charger.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/select_vehicle/select_vehicle_page.dart';
import 'package:jupiter/src/presentation/pages/splash_screen/check_status_charging.dart';
import 'package:jupiter/src/presentation/status_charging/cubit/status_charging_cubit.dart';
import 'package:jupiter/src/presentation/widgets/check_internet_signal.dart';
import 'package:jupiter_api/config/api/api_config.dart';
import 'package:jupiter_api/data/data_models/request/payment_type_form.dart';
import 'package:jupiter_api/data/data_models/request/request_access_key_form.dart';
import 'package:jupiter_api/data/data_models/response/charging_socket/charging_info_model.dart';
import 'package:jupiter_api/domain/entities/car_select_entity.dart';
import 'package:jupiter_api/domain/entities/check_status_entity.dart';
import 'package:jupiter_api/domain/entities/facility_entity.dart';
import 'package:jupiter_api/domain/entities/payment_type_has_defalut_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/charging/cubit/charging_realtime_cubit.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/charging/widgets/charging_option.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/charging/widgets/charging_page_loading.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/charging/widgets/facility.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/charging/widgets/floating_action_slider_button.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/charging/widgets/modal_bottom_battery.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/charging/widgets/modal_select_payment.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/receipt/receipt_page.dart';
import 'package:jupiter/src/presentation/socket_charging/socket_jupiter.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/presentation/widgets/lifecycle_watcher_state.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/jupiter_api.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../../../firebase_log.dart';
import '../../../../route_names.dart';
import 'widgets/charging_charge_data.dart';
import 'widgets/charging_energy_and_amount.dart';
import 'widgets/charging_other_data.dart';

class JupiterChargingPage extends StatefulWidget {
  const JupiterChargingPage({
    super.key,
    required this.qrCodeData,
    this.fleetType,
    this.fromFleet,
    this.fleetNo,
    this.refCode,
    this.chargingType,
    this.fleetCardNo,
    this.showModalWaitingCharger,
  });

  final String qrCodeData;
  final String? fleetType;
  final bool? fromFleet;
  final int? fleetNo;
  final String? refCode;
  final String? chargingType;
  final String? fleetCardNo;
  final bool? showModalWaitingCharger;

  @override
  State<JupiterChargingPage> createState() => _JupiterChargingPageState();
}

class _JupiterChargingPageState
    extends LifecycleWatcherState<JupiterChargingPage> {
  double heightAppbar = AppBar().preferredSize.height;
  // RESPONSE DATA
  CheckStatusEntity? responseData;
  List<String> listFac = [];
  bool isLoadingPage = false;
  bool isSetState = false;

  // PAYMENT
  bool checkPaymentSelected = false;
  int indexPaymentSelected = 0;
  int lastedIndexPaymentSelected = 0;
  List<PaymentTypeHasDefalutEntity> listPaymentItem = [];
  bool loadingPayment = false;
  bool errorPayment = false;

  // SCROLL PAGE
  ScrollController scrollController = ScrollController();

  // SOCKET
  bool hasNewData = false;
  bool checkOpenSocket = false;
  ChargingInfoModel? realtimeData;
  StreamSocket streamSocket = StreamSocket();
  Socket socketRealtime = io(
      '${JupiterApi.getBaseUrl(ApiConfig.env)}/information-realtime-charging/',
      OptionBuilder()
          .setQuery({'token': ''})
          .setTransports(['websocket'])
          .setPath('/information-realtime-charging/')
          .build());

  // BATTERY
  final TextEditingController _batteryOptionController =
      TextEditingController();
  bool hasBat = false;
  bool loadingChangeBattery = false;

  // LOADING BUTTON
  bool isLoadingStopCharging = false;
  bool isPushPage = false;
  bool isProcessGoBack = false;

  // DATA REALTIME VALUE
  String batteryRealtime = '';
  String chargingTime = '';
  String distanceUnit = '';
  String powerCharging = '';
  double powerRealtime = 0;
  double distanceValue = 0;
  String energyDelivered = 'N/A';
  String amountPaid = 'N/A';

  @override
  void initState() {
    FirebaseLog.logPage(this);
    realtimeData = null;
    checkPaymentSelected = false;
    isLoadingPage = true;
    loadingPayment = true;
    fetchCheckStatusFromType();
    super.initState();
  }

  @override
  void dispose() {
    try {
      super.dispose();
    } catch (e) {
      debugPrint('ERROR super.dispose()');
    }
  }

  @override
  void onDetached() {
    debugPrint('DETACHED PAGE XX');
  }

  @override
  void onPaused() {
    debugPrint('PAUSE PAGE XX');
  }

  @override
  void onInactive() {
    debugPrint('INACTIVE PAGE XX');
    if (!isPushPage) {
      resetOnLockScreen();
    }
  }

  @override
  void onResumed() {
    debugPrint('RESUME PAGE XX');
    if (!isPushPage) {
      Utilities.dialogIsVisible(context);
      onPressedBackButton();
    }
  }

  void resetOnLockScreen() {
    try {
      socketRealtime.disconnect();
      Utilities.dialogIsVisible(context);
      if (widget.fromFleet == true) {
        Navigator.pop(context);
      } else {
        while (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      }
    } catch (e) {}
  }

  void fetchCheckStatusFromType() {
    switch (widget.fleetType) {
      case FleetType.CARD:
        BlocProvider.of<ChargingRealtimeCubit>(context)
            .fetchCheckStatusFleetCard(
          fleetNo: widget.fleetNo ?? -1,
          fleetType: (widget.fleetType ?? '').toLowerCase(),
          refCode: widget.refCode ?? '',
        );
        break;
      case FleetType.OPERATION:
        BlocProvider.of<ChargingRealtimeCubit>(context)
            .fetchCheckStatusFleetOperation(
          fleetNo: widget.fleetNo ?? -1,
          fleetType: (widget.fleetType ?? '').toLowerCase(),
          qrCode: widget.qrCodeData,
        );
        break;
      default:
        BlocProvider.of<ChargingRealtimeCubit>(context).fetchCheckStatus();
    }
  }

  Future<void> fetchTokenToOpenSocket() async {
    if (!checkOpenSocket) {
      UserManagementUseCase useCase = getIt();
      JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
      String? refreshToken = jupiterPrefsAndAppData.refreshToken;
      String? username = jupiterPrefsAndAppData.username;
      String? deviceCode = jupiterPrefsAndAppData.deviceId;
      final result = await useCase.requestAccessToken(RequestAccessKeyForm(
        username: username ?? '',
        refreshToken: refreshToken ?? '',
        deviceCode: deviceCode ?? '',
        orgCode: ConstValue.orgCode,
      ));
      result.fold((failure) {}, (data) async {
        String newToken = data.token.accessToken;
        useSocketToGetStatusCharging(newToken);
      });
    }
  }

  String getEventSocket() {
    JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
    String? username = jupiterPrefsAndAppData.username;
    CheckStatusChargingData chargingData = getIt();
    String event =
        '${chargingData.checkStatusEntity?.data?.chargerName}|${ConstValue.orgCode}|${username}';
    if (widget.fromFleet == true) {
      if (widget.fleetType == FleetType.CARD) {
        event =
            '${widget.qrCodeData}|${ConstValue.orgCode}|${widget.fleetNo}|${FleetType.CARD.toLowerCase()}|${widget.fleetCardNo}';
        debugPrint('SOCKET EVENT : ${event}');
        return event;
      } else if (widget.fleetType == FleetType.OPERATION) {
        event =
            '${widget.qrCodeData}|${ConstValue.orgCode}|${widget.fleetNo}|${FleetType.OPERATION.toLowerCase()}';
        debugPrint('SOCKET EVENT : ${event}');
        return event;
      } else {
        event =
            '${chargingData.checkStatusEntity?.data?.chargerName}|${ConstValue.orgCode}|${username}';
        debugPrint('SOCKET EVENT : ${event}');
        return event;
      }
    } else {
      event =
          '${chargingData.checkStatusEntity?.data?.chargerName}|${ConstValue.orgCode}|${username}';
      debugPrint('SOCKET EVENT : ${event}');
      return event;
    }
  }

  Future<void> useSocketToGetStatusCharging(String token) async {
    if (!checkOpenSocket) {
      streamSocket = StreamSocket();
      socketRealtime = io(
          '${JupiterApi.getBaseUrl(ApiConfig.env)}/information-realtime-charging/',
          OptionBuilder()
              .setQuery({'token': token})
              .setTransports(['websocket'])
              .setPath('/information-realtime-charging/')
              .build());
      socketRealtime.onConnect((_) {
        debugPrint('connect');
      });
      socketRealtime.on(
          getEventSocket(),
          (data) => {
                debugPrint('REALTIME DATA : $data'),
                setNewResponseDataFromSocket(data)
                // streamSocket.addResponse(ChargingInfoModel.fromJson(data)),
              });
      socketRealtime.onConnectError((data) => {
            debugPrint('connectError $data'),
          });
      socketRealtime.onError((data) => debugPrint('onError $data'));
      socketRealtime.onDisconnect((_) => debugPrint(
          '===============\DISCONNECT FROM REALTIME PAGE\n==============='));
      checkOpenSocket = true;
    }
  }

  Future<void> onClickAddCard() async {
    String qrCode = widget.qrCodeData;
    Navigator.of(context).pop();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isPushPage = true;
      });
    });
    await Navigator.of(context).pushNamed(RouteNames.payment_kbank);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isPushPage = false;
      });
    });
    BlocProvider.of<ChargingRealtimeCubit>(context)
        .fetchListPayment(qrCode: qrCode);
  }

  void setNewResponseDataFromSocket(dynamic data) {
    hasNewData = true;
    if (!isSetState) {
      try {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() {
              isSetState = true;
            });
          }
        });
      } catch (e) {}
    }
    debugPrint('========= hasNewData : $hasNewData =========');
    if (hasNewData) {
      streamSocket.addResponse(ChargingInfoModel.fromJson(data));
    }
  }

  void checkIndexSelectPaymentType() {
    if (!checkPaymentSelected) {
      String? tokenPayment =
          responseData?.informationCharger?.paymentType![0].token ?? '';
      int lengthOfPayment = listPaymentItem.length;
      for (int i = 0; i < lengthOfPayment; i++) {
        if (tokenPayment == listPaymentItem[i].token) {
          indexPaymentSelected = i;
          lastedIndexPaymentSelected = i;
        }
      }
      checkPaymentSelected = true;
    }
  }

  void onSelectPayment(int id) {
    setState(() {
      indexPaymentSelected = id;
    });
  }

  void onAllActionCloseModal() {
    if (!isLoadingStopCharging) {
      if (lastedIndexPaymentSelected != indexPaymentSelected) {
        BlocProvider.of<ChargingRealtimeCubit>(context)
            .fetchUpdateSelectPayment(
          qrCode: widget.qrCodeData,
          paymentSelected: PaymentTypeForm(
            type: listPaymentItem[indexPaymentSelected].type,
            display: listPaymentItem[indexPaymentSelected].display,
            token: listPaymentItem[indexPaymentSelected].token,
            brand: listPaymentItem[indexPaymentSelected].brand,
            name: listPaymentItem[indexPaymentSelected].name,
          ),
        );
      }
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

  Future<bool?> onActionStopButton() {
    setState(() {
      isLoadingStopCharging = true;
    });
    if (widget.fromFleet == true) {
      if (widget.fleetType == FleetType.CARD) {
        BlocProvider.of<ChargingRealtimeCubit>(context).fleetStopChargingCard(
          qrCode: widget.qrCodeData,
          chargerRealtimeEntity: responseData?.informationCharger,
          fleetNo: widget.fleetNo ?? -1,
          fleetType: FleetType.CARD,
        );
      } else if (widget.fleetType == FleetType.OPERATION) {
        BlocProvider.of<ChargingRealtimeCubit>(context)
            .fleetStopChargingOperation(
          qrCode: widget.qrCodeData,
          chargerRealtimeEntity: responseData?.informationCharger,
          fleetNo: widget.fleetNo ?? -1,
          fleetType: FleetType.OPERATION,
        );
      } else {
        BlocProvider.of<ChargingRealtimeCubit>(context).fetchStopCharging(
            qrCode: widget.qrCodeData,
            chargerRealtimeEntity: responseData?.informationCharger);
      }
    } else {
      BlocProvider.of<ChargingRealtimeCubit>(context).fetchStopCharging(
          qrCode: widget.qrCodeData,
          chargerRealtimeEntity: responseData?.informationCharger);
    }
    return Future.value(true);
  }

  Future<void> checkGotoReceiptPage() async {
    if (realtimeData != null) {
      bool statusCharger = realtimeData?.statusCharger ?? false;
      bool statusReceipt = realtimeData?.statusReceipt ?? false;
      if (!statusCharger && statusReceipt) {
        await socketRealtime.disconnect();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (widget.fromFleet == true) {
            if (widget.chargingType ==
                    FleetOperationStatus.CHARGING_AUTOCHARGE ||
                widget.chargingType == FleetOperationStatus.CHARGING_RFID) {
              isLoadingStopCharging = false;
              debugPrint('checkGotoReceiptPage : CALL');
              onPressedBackButton(noReset: true);
            } else {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return JupiterChargingReceiptPage(
                  qrCodeData: widget.qrCodeData,
                  refCode: widget.refCode ?? '',
                  chargerRealtimeEntity: responseData?.informationCharger,
                  fleetNo: widget.fleetNo,
                  fleetType: widget.fleetType,
                  fromFleet: widget.fromFleet,
                  fleetCardNo: widget.fleetCardNo,
                );
              }));
            }
          } else {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return JupiterChargingReceiptPage(
                qrCodeData: widget.qrCodeData,
                chargerRealtimeEntity: responseData?.informationCharger,
              );
            }));
          }
        });
      }
    }
  }

  void onPressedBackButton({bool? noReset}) {
    if (!isLoadingStopCharging && !isProcessGoBack) {
      isProcessGoBack = true;
      socketRealtime.disconnect();
      if (widget.fromFleet == true) {
        Navigator.pop(context);
      } else {
        try {
          Utilities.getCheckStatusCharging(context);
        } catch (e) {}
        while (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        // Navigator.pushReplacement(
        //   context,
        //   PageRouteBuilder(
        //     pageBuilder: (BuildContext context, animation1, animation2) =>
        //         MainMenuPage(
        //       checkStatusEntity: data,
        //     ),
        //     transitionDuration: Duration.zero,
        //     reverseTransitionDuration: Duration.zero,
        //   ),
        // );
      }
      if (noReset != true) {
        isProcessGoBack = false;
      }
    }
  }

  List<PaymentTypeHasDefalutEntity> parsePaymentTypes(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<PaymentTypeHasDefalutEntity>(
            (json) => PaymentTypeHasDefalutEntity.fromJson(json))
        .toList();
  }

  void setListFacility(List<FacilityEntity>? listData) {
    int lengthData = listData?.length ?? 0;
    if (lengthData > 0) {
      for (int i = 0; i < lengthData; i++) {
        String imgItem = listData?[i].image ?? '';
        listFac.add(imgItem);
      }
    }
  }

  void onShowModal() {
    try {
      if (batteryRealtime != '' && batteryRealtime.isNotEmpty) {
        List<String> splitText = batteryRealtime.split(new RegExp('\\s+'));
        _batteryOptionController.text = splitText[0];
      }
    } catch (e) {
      _batteryOptionController.text = '';
    }
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      isDismissible: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      builder: (BuildContext context) {
        return ModalBottomBattery(
          // onChangeBattery: widget.onChangeBattery,
          controller: _batteryOptionController,
          onCloseModal: onCloseModal,
          onDoneModal: onDoneModal,
        );
      },
    );
  }

  void onCloseModal() {
    Navigator.pop(context);
  }

  void onDoneModal() {
    bool allowChangeBattery = true;
    if (_batteryOptionController.text == '' ||
        _batteryOptionController.text.isEmpty) {
      allowChangeBattery = false;
    } else {
      try {
        String textTest = _batteryOptionController.text;
        while (textTest.startsWith('0')) {
          textTest = textTest.substring(1);
        }
        _batteryOptionController.text = textTest;
        if (_batteryOptionController.text == '') {
          _batteryOptionController.text = '0';
        } else if (int.parse(_batteryOptionController.text) > 100) {
          _batteryOptionController.text = '100';
        }
      } catch (e) {
        allowChangeBattery = false;
      }
    }
    if (allowChangeBattery) {
      Navigator.pop(context);
      BlocProvider.of<ChargingRealtimeCubit>(context).fetchUpdateCurrentBattery(
        qrCode: widget.qrCodeData,
        currentBattery: int.parse(_batteryOptionController.text),
        fleetStatus: widget.fromFleet ?? false,
        fleetNo: widget.fleetNo ?? -1,
      );
    }
    try {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {});
        }
      });
    } catch (e) {}
  }

  String getTextCarName(CarSelectEntity? car) {
    if (widget.fromFleet == true) {
      if ((car?.licensePlate ?? '') == '' && (car?.province ?? '') == '') {
        return '';
      } else {
        return '${car?.licensePlate} ${car?.province}';
      }
    } else {
      if ((car?.brand ?? '') == '' && (car?.model ?? '') == '') {
        return '';
      } else {
        return '${car?.brand} ${car?.model}';
      }
    }
  }

  void onShowModalSelectPayment() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      builder: (BuildContext context) {
        return ModalSelectPayment(
          idSelectedPayment: indexPaymentSelected,
          listPaymentItem: listPaymentItem,
          onSelectPayment: onSelectPayment,
          onPressedAddCards: onClickAddCard,
        );
      },
    ).whenComplete(onAllActionCloseModal);
  }

  bool getEnabledSlideButton() {
    if ((widget.fromFleet ?? false) &&
        (widget.chargingType == FleetOperationStatus.CHARGING_RFID)) {
      return true;
    } else {
      return isLoadingPage;
    }
  }

  String getLabelSlideButton() {
    if ((widget.fromFleet ?? false) &&
        (widget.chargingType == FleetOperationStatus.CHARGING_RFID)) {
      return translate('charging_page.button_stop_rfid');
    } else {
      return translate('charging_page.slide_button_stop');
    }
  }

  Future<void> onNavigateSelectVehicle() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isPushPage = true;
      });
    });
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SelectVehiclePage(
        typePage: 'CHARGING',
        onSaveVehicle: (index) {},
        indexSelected: -1,
        fleetType: widget.fleetType,
        fromFleet: widget.fromFleet,
        fleetNo: widget.fleetNo,
        qrCodeData: widget.qrCodeData,
      );
    }));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isPushPage = false;
        isSetState = false;
      });
    });
    checkOpenSocket = false;
    streamSocket = StreamSocket();
    fetchCheckStatusFromType();
  }

  void actionChargingCheckStatusLoading() {
    if (widget.fromFleet != true) {
      BlocProvider.of<StatusChargingCubit>(context).loadingCheckStatus();
    }
    isLoadingPage = true;
  }

  void actionChargingCheckStatusFailure() {
    isLoadingPage = false;
  }

  void actionChargingCheckStatusSuccess(dynamic state) {
    isLoadingPage = false;
    responseData = state.checkStatusEntity;
    if (widget.fromFleet == true &&
        (widget.fleetType == FleetType.OPERATION ||
            widget.fleetType == FleetType.CARD) &&
        responseData?.chargingStatus != true) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.SUCCESS,
          isForce: true,
          title: translate('alert.title.success'),
          description: translate('alert.description.charging_success'),
          textButton: translate('button.close'),
          onPressButton: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        );
      });
      return;
    }
    setListFacility(responseData?.informationCharger?.facilityName ?? []);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isLoadingStopCharging = false;
        chargingTime = responseData?.data?.data?.startTimeCharging ?? '';
        batteryRealtime = responseData?.data?.data?.percent?.unit == '%'
            ? '${responseData?.data?.data?.percent?.value.toInt()} ${responseData?.data?.data?.percent?.unit}'
            : '';
        _batteryOptionController.text =
            responseData?.data?.data?.percent?.unit == '%'
                ? '${responseData?.data?.data?.percent?.value.toInt()}'
                : '';
        distanceUnit = responseData?.data?.data?.estimateDistance?.unit ?? '';
        powerCharging =
            '${responseData?.data?.data?.power?.value} ${responseData?.data?.data?.power?.unit}';
        powerRealtime = responseData?.data?.data?.totalPrice?.value ?? 0;
        distanceValue = responseData?.data?.data?.estimateDistance?.value ?? 0;
        energyDelivered =
            '${responseData?.data?.data?.powerRealtime?.value.toStringAsFixed(3) ?? 'N/A'}';
        amountPaid =
            '${responseData?.data?.data?.totalPrice?.value.toStringAsFixed(2) ?? 'N/A'}';
      });
    });
    if (widget.fromFleet != true) {
      CheckStatusChargingData chargingData = getIt();
      chargingData.checkStatusEntity = responseData;
      BlocProvider.of<StatusChargingCubit>(context)
          .statusCharging(responseData);
      BlocProvider.of<ChargingRealtimeCubit>(context).fetchListPayment(
          qrCode: widget.qrCodeData != ''
              ? widget.qrCodeData
              : '${responseData?.data?.chargerName ?? ''}');
    } else {
      try {
        dynamic data = responseData?.informationCharger?.paymentType?[0];
        List<PaymentTypeHasDefalutEntity> paymentTypes =
            List.empty(growable: true);
        paymentTypes.add(
          PaymentTypeHasDefalutEntity(
            type: data.type,
            display: data.display,
            token: data.token,
            brand: data.brand,
            defalut: true,
            name: data.name,
          ),
        );
        checkIndexSelectPaymentType();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            loadingPayment = false;
            listPaymentItem = paymentTypes;
          });
        });
      } catch (e) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            loadingPayment = false;
            errorPayment = true;
          });
        });
      }
    }
    bool statusCharger = responseData?.data?.statusCharger ?? false;
    bool statusReceipt = responseData?.data?.statusReceipt ?? false;
    if (!statusCharger && statusReceipt) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.fromFleet == true) {
          if (widget.chargingType == FleetOperationStatus.CHARGING_AUTOCHARGE ||
              widget.chargingType == FleetOperationStatus.CHARGING_RFID) {
            isLoadingStopCharging = false;
            onPressedBackButton();
          } else {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return JupiterChargingReceiptPage(
                qrCodeData: widget.qrCodeData,
                refCode: widget.refCode ?? '',
                chargerRealtimeEntity: responseData?.informationCharger,
                fleetNo: widget.fleetNo,
                fleetType: widget.fleetType,
                fromFleet: widget.fromFleet,
                fleetCardNo: widget.fleetCardNo,
              );
            }));
          }
        } else {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return JupiterChargingReceiptPage(
              qrCodeData: widget.qrCodeData,
              chargerRealtimeEntity: responseData?.informationCharger,
            );
          }));
        }
      });
    } else {
      fetchTokenToOpenSocket();
      renderModalWaitingCharger();
    }
    BlocProvider.of<ChargingRealtimeCubit>(context).fetchResetCubitToInital();
  }

  void actionChargingGetPaymentLoading() {
    if (!loadingPayment) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          loadingPayment = true;
          errorPayment = false;
        });
      });
    }
  }

  void actionChargingGetPaymentFailure() {
    if (loadingPayment) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          loadingPayment = false;
          errorPayment = true;
        });
      });
    }
  }

  void actionChargingUpdateBatteryLoading() {
    if (!loadingChangeBattery) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          loadingChangeBattery = true;
        });
      });
    }
  }

  void actionChargingUpdateBatteryFailure(state) {
    if (loadingChangeBattery) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          loadingChangeBattery = false;
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
            try {
              Future.delayed(const Duration(milliseconds: 500), () {
                if (mounted) {
                  setState(() {});
                }
              });
            } catch (e) {}
          },
        );
      });
      BlocProvider.of<ChargingRealtimeCubit>(context).fetchResetCubitToInital();
    }
  }

  void actionChargingUpdateBatterySuccess() {
    if (loadingChangeBattery) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          batteryRealtime = _batteryOptionController.text + ' %';
          loadingChangeBattery = false;
        });
        try {
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              setState(() {});
            }
          });
        } catch (e) {}
      });
    }
    BlocProvider.of<ChargingRealtimeCubit>(context).fetchResetCubitToInital();
  }

  void actionChargingUpdatePaymentLoading() {
    if (!loadingPayment) {
      loadingPayment = true;
    }
  }

  void actionChargingUpdatePaymentFailure(state) {
    if (loadingPayment) {
      loadingPayment = false;
      indexPaymentSelected = lastedIndexPaymentSelected;
      WidgetsBinding.instance.addPostFrameCallback((_) {
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
      });
    }
    BlocProvider.of<ChargingRealtimeCubit>(context).fetchResetCubitToInital();
  }

  void actionChargingUpdatePaymentSuccess() {
    if (loadingPayment) {
      loadingPayment = false;
      lastedIndexPaymentSelected = indexPaymentSelected;
    }
    BlocProvider.of<ChargingRealtimeCubit>(context).fetchResetCubitToInital();
  }

  void actionChargingGetPaymentSuccess(dynamic state) {
    if (loadingPayment) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        List<dynamic> data = state.listPayment;
        var testets = json.encode(data, toEncodable: (e) => e.toJsonAttr());
        List<PaymentTypeHasDefalutEntity> paymentTypes =
            parsePaymentTypes(testets);
        listPaymentItem = paymentTypes;
        checkIndexSelectPaymentType();
        loadingPayment = false;
        BlocProvider.of<ChargingRealtimeCubit>(context)
            .fetchResetCubitToInital();
      });
    }
  }

  void actionChargingStopChargingFailure(state) {
    if (isLoadingStopCharging) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          isLoadingStopCharging = false;
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
      });
    }
  }

  void actionChargingStopChargingSuccess() {
    debugPrint('WAITING SOCKET PUSH RECEIPT PAGE');
  }

  void renderModalWaitingCharger() {
    if (widget.showModalWaitingCharger == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => PopScope(
            canPop: false,
            child: DialogWaitingCharger(),
          ),
        );
      });
    }
  }

  Widget renderRealtimePage() {
    if (!isLoadingPage) {
      return Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 1,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: ListView(
                controller: scrollController,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      children: [
                        // REALTIME CHARGING DATA
                        StreamBuilder<ChargingInfoModel>(
                          stream: streamSocket.getResponse,
                          builder: (context, snapshot) {
                            if (snapshot.data != null && hasNewData) {
                              realtimeData = snapshot.data;
                              chargingTime =
                                  realtimeData?.data?.startTimeCharging ?? '';
                              batteryRealtime = realtimeData
                                          ?.data?.percent?.unit ==
                                      '%'
                                  ? '${realtimeData?.data?.percent?.value.toInt()} ${realtimeData?.data?.percent?.unit}'
                                  : '';
                              distanceUnit =
                                  '${realtimeData?.data?.estimateDistance?.unit}';
                              powerCharging =
                                  '${realtimeData?.data?.power?.value} ${realtimeData?.data?.power?.unit}';
                              powerRealtime =
                                  realtimeData?.data?.totalPrice?.value ?? 0;
                              distanceValue =
                                  realtimeData?.data?.estimateDistance?.value ??
                                      0;
                              energyDelivered =
                                  '${realtimeData?.data?.powerRealtime?.value.toStringAsFixed(3) ?? 'N/A'}';
                              amountPaid =
                                  '${realtimeData?.data?.totalPrice?.value.toStringAsFixed(2) ?? 'N/A'}';
                              hasNewData = false;
                              checkGotoReceiptPage();
                            }
                            return Column(
                              children: [
                                const SizedBox(height: 8),
                                ChargingChargeData(
                                  image: responseData?.informationCharger
                                          ?.carSelect?.image ??
                                      '',
                                  batteryRealtime: batteryRealtime,
                                  carName: getTextCarName(responseData
                                      ?.informationCharger?.carSelect),
                                  chargingTime: chargingTime,
                                  distance: distanceUnit,
                                  powerCharging: powerCharging,
                                  powerRealtime: powerRealtime,
                                  distanceValue: distanceValue,
                                  onShowModal: onShowModal,
                                  isLoadingUpdateBattery: loadingChangeBattery,
                                  fleetType: widget.fleetType,
                                  fromFleet: widget.fromFleet,
                                  fleetNo: widget.fleetNo,
                                  chargingType: widget.chargingType,
                                  qrCodeData: widget.qrCodeData,
                                  onNavigateSelectVehicle:
                                      onNavigateSelectVehicle,
                                ),
                                const SizedBox(height: 16),
                                ChargingEnergyAndAmount(
                                  energyDelivered: energyDelivered,
                                  amountPaid: amountPaid,
                                ),
                                const SizedBox(height: 20),
                              ],
                            );
                          },
                        ),
                        // CHARGER INFO AND LIST PAYMENT
                        Column(
                          children: [
                            ChargingOtherData(
                              location:
                                  '${responseData?.informationCharger?.stationName}',
                              chargerName:
                                  '${responseData?.informationCharger?.chargerName}',
                              chargerType:
                                  '${responseData?.informationCharger?.chargerType} ${Utilities.nameConnecterType('${responseData?.informationCharger?.chargerType}', '${responseData?.informationCharger?.connector?.connectorType}')}',
                              chargerIndex:
                                  '${responseData?.informationCharger?.connector?.connectorIndex.toString()}',
                              chargerID:
                                  '${responseData?.informationCharger?.connector?.connectorId.toString()}',
                              chargingMode:
                                  '${responseData?.informationCharger?.chargingMode?.mode}',
                              chargingPrice:
                                  ' ${responseData?.informationCharger?.chargingMode?.price} ${responseData?.informationCharger?.chargingMode?.priceUnit}',
                              chargingPower:
                                  '${responseData?.informationCharger?.chargingMode?.power} ${responseData?.informationCharger?.chargingMode?.powerUnit}',
                              creditCardType: loadingPayment
                                  ? ''
                                  : '${errorPayment ? '' : listPaymentItem[indexPaymentSelected].brand}',
                              creditCardNumber: loadingPayment
                                  ? ''
                                  : '${errorPayment ? 'ERROR' : listPaymentItem[indexPaymentSelected].display}',
                              isLoadingListPayment: loadingPayment,
                              isErrorPayment: errorPayment,
                              listPaymentItem: listPaymentItem,
                              couponTitle:
                                  responseData?.data?.receiptData?.couponMethod,
                              onShowModalSelectPayment:
                                  onShowModalSelectPayment,
                              fromFleet: widget.fromFleet,
                              isLowPriority:
                                  responseData?.data?.lowPriorityTariff == true,
                            ),
                            const SizedBox(height: 8)
                          ],
                        ),
                        // OPTION
                        Column(
                          children: [
                            ChargingOption(
                              type: responseData?.informationCharger
                                      ?.optionalCharging?.optionalType ??
                                  '',
                              value: responseData?.informationCharger
                                      ?.optionalCharging?.optionalValue ??
                                  0,
                              unit: responseData?.informationCharger
                                      ?.optionalCharging?.optionalUnit ??
                                  '',
                            ),
                          ],
                        ),
                        // FACILITY
                        Column(
                          children: [
                            listFac.length > 0
                                ? Facility(
                                    onExpansionChanged: onExpansionChanged,
                                    data: listFac,
                                  )
                                : SizedBox.square(),
                            SizedBox(
                              width: double.infinity,
                              height: (MediaQuery.of(context).size.height -
                                      heightAppbar) *
                                  0.1,
                            ),
                          ],
                        )
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
              processReady: isLoadingStopCharging,
              disable: getEnabledSlideButton(),
              action: onActionStopButton,
              label: getLabelSlideButton(),
              icon: SvgPicture.asset(
                getEnabledSlideButton()
                    ? ImageAsset.stop_charging_disable
                    : ImageAsset.stop_charging,
                width: 48,
                height: 48,
                matchTextDirection: true,
              ),
            ),
          )
        ],
      );
    } else {
      return ChargingPageLoading();
    }
  }

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
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AppTheme.white,
            bottomOpacity: 0.0,
            elevation: 0.0,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppTheme.blueDark),
                onPressed: onPressedBackButton),
            centerTitle: true,
            title: TextLabel(
              text: translate('charging_page.title'),
              color: AppTheme.blueDark,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.title),
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
          child: BlocBuilder<ChargingRealtimeCubit, ChargingRealtimeState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case ChargingCheckStatusLoading:
                  actionChargingCheckStatusLoading();
                  break;
                case ChargingCheckStatusFailure:
                  actionChargingCheckStatusFailure();
                  break;
                case ChargingCheckStatusSuccess:
                  actionChargingCheckStatusSuccess(state);
                  break;
                case ChargingGetPaymentLoading:
                  actionChargingGetPaymentLoading();
                  break;
                case ChargingGetPaymentFailure:
                  actionChargingGetPaymentFailure();
                  break;
                case ChargingGetPaymentSuccess:
                  actionChargingGetPaymentSuccess(state);
                  break;
                case ChargingUpdatePaymentLoading:
                  actionChargingUpdatePaymentLoading();
                  break;
                case ChargingUpdatePaymentFailure:
                  actionChargingUpdatePaymentFailure(state);
                  break;
                case ChargingUpdatePaymentSuccess:
                  actionChargingUpdatePaymentSuccess();
                  break;
                case ChargingUpdateBatteryLoading:
                  actionChargingUpdateBatteryLoading();
                  break;
                case ChargingUpdateBatteryFailure:
                  actionChargingUpdateBatteryFailure(state);
                  break;
                case ChargingUpdateBatterySuccess:
                  actionChargingUpdateBatterySuccess();
                  break;
                case ChargingStopChargingFailure:
                  actionChargingStopChargingFailure(state);
                  break;
                case ChargingStopChargingSuccess:
                  actionChargingStopChargingSuccess();
                  break;
                default:
                  actionChargingCheckStatusFailure();
                  break;
              }
              return renderRealtimePage();
            },
          ),
        ),
      ),
    );
  }
}
