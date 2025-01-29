import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:app_settings/app_settings.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter/src/presentation/pages/splash_screen/check_status_charging.dart';
import 'package:jupiter/src/presentation/status_charging/cubit/status_charging_cubit.dart';
import 'package:jupiter/src/presentation/widgets/check_internet_signal.dart';
import 'package:jupiter/src/presentation/widgets/lifecycle_watcher_state.dart';
import 'package:jupiter_api/config/api/api_config.dart';
import 'package:jupiter_api/data/data_models/request/payment_type_form.dart';
import 'package:jupiter_api/data/data_models/request/request_access_key_form.dart';
import 'package:jupiter_api/data/data_models/response/charging_socket/charging_info_model.dart';
import 'package:jupiter_api/domain/entities/charger_realtime_entity.dart';
import 'package:jupiter_api/domain/entities/charging_info_entity.dart';
import 'package:jupiter_api/domain/entities/charging_info_receipt_entity.dart';
import 'package:jupiter_api/domain/entities/check_status_entity.dart';
import 'package:jupiter_api/domain/entities/payment_type_has_defalut_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/receipt/cubit/receipt_success_cubit.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/receipt/widgets/button_go_to_fleet_operation.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/receipt/widgets/button_save_img.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/receipt/widgets/modal_select_payment.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/receipt/widgets/receiept_page_loading.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/receipt/widgets/row_with_two_text_for_coupon.dart';
import 'package:jupiter/src/presentation/socket_charging/socket_jupiter.dart';
import 'package:jupiter/src/presentation/widgets/dash_line.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/presentation/widgets/row_with_two_text.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/jupiter_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import '../../../../firebase_log.dart';
import '../../../../route_names.dart';
import 'widgets/bg_image.dart';
import 'widgets/col_text_with_image.dart';
import 'widgets/receipt_border.dart';
import 'widgets/row_payment_method.dart';
import 'widgets/row_total_price.dart';

class JupiterChargingReceiptPage extends StatefulWidget {
  const JupiterChargingReceiptPage({
    super.key,
    required this.qrCodeData,
    required this.chargerRealtimeEntity,
    this.fleetType,
    this.fromFleet,
    this.fleetNo,
    this.refCode,
    this.fleetCardNo,
  });

  final String qrCodeData;
  final ChargerRealtimeEntity? chargerRealtimeEntity;
  final String? fleetType;
  final bool? fromFleet;
  final int? fleetNo;
  final String? refCode;
  final String? fleetCardNo;

  @override
  State<JupiterChargingReceiptPage> createState() =>
      _JupiterChargingReceiptPageState();
}

class _JupiterChargingReceiptPageState
    extends LifecycleWatcherState<JupiterChargingReceiptPage> {
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  bool hasBgImage = false;

  // RESPONSE DATA
  CheckStatusEntity? responseData;
  ChargingInfoReceiptEntity? receiptData;

  // LOADING PAGE
  bool isLoadingConfirm = false;

  // SAVE IMAGE
  bool isSaveImage = false;
  WidgetsToImageController controller = WidgetsToImageController();
  Uint8List? bytes;

  // VALUE RECEIPT PAGE
  String location = '';
  String chargerName = '';
  String startTime = '';
  String endTime = '';
  String energyRate = '';
  String energyDelivered = '';
  String chargingFee = '';
  String reserveDiscount = '';
  String couponDiscount = '';
  String priceBeforeVAT = '';
  String vat = '';
  String totalPrice = '';
  String paymentMethod = '';
  bool reserveStatus = false;
  bool statusAddCoupon = false;
  bool statusUseCoupon = false;
  double widthHalf = 0.45;
  ChargingInfoEntity? dataCharging;
  bool statusPayment = false;
  bool statusdebt = false;
  bool checkLoadPage = false;
  bool onPressedConfirm = false;
  String carBand = '';
  String licensePlate = '';

  // PAYMENT
  bool checkPaymentSelected = false;
  int indexPaymentSelected = 0;
  int lastedIndexPaymentSelected = 0;
  List<PaymentTypeHasDefalutEntity> listPaymentItem = [];
  bool loadingPayment = false;
  bool errorPayment = false;
  bool loadingDebt = false;
  bool checkCaseDebt = true;
  CheckStatusChargingData? checkStatusChargingData;
  bool isPushPage = false;
  // SOCKET
  bool hasNewData = false;
  bool checkOpenSocket = false;
  StreamSocket streamSocket = StreamSocket();
  Socket socketRealtime = io(
      '${JupiterApi.getBaseUrl(ApiConfig.env)}/information-realtime-charging/',
      OptionBuilder()
          .setQuery({'token': ''})
          .setTransports(['websocket'])
          .setPath('/information-realtime-charging/')
          .build());

  // FLEET
  bool backtoFleet = false;

  @override
  void initState() {
    FirebaseLog.logPage(this);
    BlocProvider.of<ReceiptSuccessCubit>(context).fetchResetCubitToInital();
    super.initState();
    hasBgImage = false;
    fetchCheckStatusFromType();
    requestPermissionPhoto();
    checkStatusChargingData = getIt();
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
  }

  @override
  void onResumed() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        bool isLocked = jupiterPrefsAndAppData.isLocked;
        if (!isPushPage && !isLocked) {
          fetchCheckStatusFromType();
        }
      });
    });
  }

  Future<void> onPressedGoToSetting() async {
    try {
      await AppSettings.openAppSettings(
        type: AppSettingsType.settings,
        asAnotherTask: true,
      );
    } catch (e) {
      debugPrint('ERROR TO OPEN APP SETTING');
    }
  }

  void modalAskPermissionPhotos({required bool goToFleetOperation}) async {
    bool getPermssionIsGranted = await requestPermissionPhoto();
    if (!getPermssionIsGranted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Utilities.alertTwoButtonAction(
          context: context,
          type: AppAlertType.DEFAULT,
          title: translate('alert_permission_photos.title'),
          description: translate('alert_permission_photos.description'),
          textButtonLeft: translate('alert_permission_photos.button_continue'),
          textButtonRight: translate('button.setting'),
          onPressButtonLeft: () {
            Navigator.of(context).pop();
            if (goToFleetOperation) {
              onPressedGoToFleetOperation();
            } else {
              onPressedBackButton();
            }
          },
          onPressButtonRight: () {
            Navigator.of(context).pop();
            onPressedGoToSetting();
          },
        );
      });
    } else {
      if (goToFleetOperation) {
        onPressedGoToFleetOperation();
      } else {
        onPressedBackButton();
      }
    }
  }

  Future<bool> requestPermissionPhoto() async {
    bool canSaveImageNew = false;
    bool status = false;
    try {
      if (Platform.isAndroid) {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        if (androidInfo.version.sdkInt >= 33) {
          status = await Permission.photos.isGranted;
        } else {
          status = await Permission.storage.isGranted;
        }
      } else {
        // iOS
        bool statusiOS_1 = await Permission.photos.isGranted;
        bool statusiOS_2 = await Permission.photos.isLimited;
        status = statusiOS_1 || statusiOS_2;
      }
      if (!status) {
        PermissionStatus newStatus;
        if (Platform.isAndroid) {
          DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          if (androidInfo.version.sdkInt >= 33) {
            newStatus = await Permission.photos.request();
          } else {
            newStatus = await Permission.storage.request();
          }
        } else {
          // iOS
          newStatus = await Permission.photos.request();
        }
        if (newStatus.isGranted) {
          canSaveImageNew = true;
        } else {
          canSaveImageNew = false;
        }
      } else {
        canSaveImageNew = true;
      }
      return canSaveImageNew;
    } catch (e) {
      return canSaveImageNew;
    }
  }

  void fetchCheckStatusFromType() {
    switch (widget.fleetType) {
      case FleetType.CARD:
        BlocProvider.of<ReceiptSuccessCubit>(context).fetchFleetCardCheckStatus(
          fleetNo: widget.fleetNo ?? -1,
          fleetType: (widget.fleetType ?? '').toLowerCase(),
          refCode: widget.refCode ?? '',
        );
        break;
      case FleetType.OPERATION:
        BlocProvider.of<ReceiptSuccessCubit>(context)
            .fetchFleetOperationCheckStatus(
          fleetNo: widget.fleetNo ?? -1,
          fleetType: (widget.fleetType ?? '').toLowerCase(),
          qrCode: widget.qrCodeData,
        );
        break;
      default:
        BlocProvider.of<ReceiptSuccessCubit>(context).fetchCheckStatus();
        break;
    }
  }

  void onClickAddCard() {
    _navigateAndLoadCardlist(context);
  }

  String getLastFourCharacter(String paymentMethod) {
    try {
      final splitted = paymentMethod.split('/');
      if (splitted[0].isNotEmpty && splitted.length > 0) {
        return splitted[0].substring(splitted[0].length - 4);
      } else if (splitted[0].length == 4) {
        return splitted[0];
      } else {
        return 'N/A';
      }
    } catch (e) {
      return 'N/A';
    }
  }

  String getTypeFromValue(String paymentMethod) {
    try {
      final splitted = paymentMethod.split('/');
      if (splitted[0].isNotEmpty && splitted.length > 1) {
        return splitted[1];
      } else {
        return 'N/A';
      }
    } catch (e) {
      return 'N/A';
    }
  }

  Future<void> _navigateAndLoadCardlist(context) async {
    Navigator.of(context).pop();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isPushPage = true;
      });
    });
    await Navigator.pushNamed(context, RouteNames.payment_kbank);
    // streamSocket = StreamSocket();
    BlocProvider.of<ReceiptSuccessCubit>(context).fetchListPayment(
      qrCode: widget.qrCodeData,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isPushPage = false;
      });
    });
  }

  Future<void> onPressedGoToFleetOperation() async {
    try {
      if (!onPressedConfirm) {
        await socketRealtime.disconnect();
        autoSaveImg();
        setState(() {
          onPressedConfirm = true;
          backtoFleet = true;
        });
        Future.delayed(const Duration(milliseconds: 500), () {
          BlocProvider.of<ReceiptSuccessCubit>(context)
              .fetchConfirmTransactionFleetOperation(
            qrCodeData: widget.qrCodeData,
            chargerRealtimeEntity: widget.chargerRealtimeEntity,
            fleetNo: widget.fleetNo ?? -1,
            fleetType: (widget.fleetType ?? '').toLowerCase(),
          );
        });
      }
    } catch (e) {
      if (onPressedConfirm) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            onPressedConfirm = false;
          });
        });
      }
    }
  }

  Future<void> onPressedBackButton() async {
    try {
      if (!onPressedConfirm) {
        await socketRealtime.disconnect();
        autoSaveImg();
        setState(() {
          onPressedConfirm = true;
        });
        if (widget.fromFleet != true) {
          Future.delayed(const Duration(milliseconds: 500), () {
            BlocProvider.of<ReceiptSuccessCubit>(context)
                .fetchConfirmTransaction(
              qrCodeData: widget.qrCodeData,
              chargerRealtimeEntity: widget.chargerRealtimeEntity,
            );
          });
        } else {
          switch (widget.fleetType) {
            case FleetType.CARD:
              Future.delayed(const Duration(milliseconds: 500), () {
                BlocProvider.of<ReceiptSuccessCubit>(context)
                    .fetchConfirmTransactionFleetCard(
                  qrCodeData: widget.qrCodeData,
                  chargerRealtimeEntity: widget.chargerRealtimeEntity,
                  fleetNo: widget.fleetNo ?? -1,
                  fleetType: (widget.fleetType ?? '').toLowerCase(),
                );
              });
              break;
            case FleetType.OPERATION:
              Future.delayed(const Duration(milliseconds: 500), () {
                BlocProvider.of<ReceiptSuccessCubit>(context)
                    .fetchConfirmTransactionFleetOperation(
                  qrCodeData: widget.qrCodeData,
                  chargerRealtimeEntity: widget.chargerRealtimeEntity,
                  fleetNo: widget.fleetNo ?? -1,
                  fleetType: (widget.fleetType ?? '').toLowerCase(),
                );
              });
              break;
            default:
          }
        }
      }
    } catch (e) {
      if (onPressedConfirm) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            onPressedConfirm = false;
          });
        });
      }
    }
  }

  String generateFileName(int length) {
    return 'jupiter_${DateTime.now().millisecondsSinceEpoch}';
  }

  String formatDateString(String dateString) {
    if (dateString.isNotEmpty) {
      final DateTime dateTime = DateTime.parse(dateString).toLocal();
      final DateFormat formatter = DateFormat('dd MMM yyyy, HH:mm:ss');
      final String formattedDate = '${formatter.format(dateTime)} hr';
      return formattedDate;
    } else {
      return 'N/A';
    }
  }

  void autoSaveImg() async {
    bool getPermssionIsGranted = await requestPermissionPhoto();
    if (!isSaveImage && getPermssionIsGranted) {
      final bytes = await controller.capture();
      Directory? tempDir = await getApplicationDocumentsDirectory();
      File file =
          await File('${tempDir.path}/${generateFileName}.png').create();
      file.writeAsBytesSync(bytes!);
      debugPrint("Path ${file.absolute}");

      final result =
          await ImageGallerySaver.saveImage(bytes.buffer.asUint8List());
      debugPrint(" ImageResult ${result.toString()}");
      // ignore: use_build_context_synchronously
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text(translate('receipt_page.save_image'))),
      // );
      try {
        if (mounted) {
          Utilities.alertAfterSaveAction(
            context: context,
            type: AppAlertType.SUCCESS,
            text: translate('receipt_page.save_image'),
          );
        }
      } catch (e) {}
      isSaveImage = true;
    }
  }

  List<PaymentTypeHasDefalutEntity> parsePaymentTypes(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<PaymentTypeHasDefalutEntity>(
            (json) => PaymentTypeHasDefalutEntity.fromJson(json))
        .toList();
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

  onSelectPayment(int payment) {
    setState(() {
      indexPaymentSelected = payment;
    });
  }

  confirmPayment() {
    BlocProvider.of<ReceiptSuccessCubit>(context).fetchUpdateSelectPayment(
      qrCode: widget.qrCodeData,
      paymentSelected: PaymentTypeForm(
        type: listPaymentItem[indexPaymentSelected].type,
        display: listPaymentItem[indexPaymentSelected].display,
        token: listPaymentItem[indexPaymentSelected].token,
        brand: listPaymentItem[indexPaymentSelected].brand,
        name: listPaymentItem[indexPaymentSelected].name,
      ),
    );
    // Navigator.of(context).pop();
  }

  void checkPaymentCaseDebtError() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (checkCaseDebt) {
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.WARNING,
          isForce: true,
          title: translate('receipt_page.alert_error_payment'),
          description: translate('receipt_page.description'),
          textButton: translate('button.try_again'),
          onPressButton: () {
            Navigator.of(context).pop();
            BlocProvider.of<ReceiptSuccessCubit>(context).fetchCheckStatus();
          },
        );
        setState(() {
          checkCaseDebt = false;
        });
      }
    });
  }

  /***** Start Socket *****/
  Future<void> fetchTokenToOpenSocket() async {
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

  String getEventSocket() {
    JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
    String? username = jupiterPrefsAndAppData.username;
    CheckStatusChargingData chargingData = getIt();
    String event =
        's${chargingData.checkStatusEntity?.data?.chargerName}|${ConstValue.orgCode}|${username}';
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
              setNewResponseDataFromSocket(data, true)
            });
    socketRealtime.onConnectError((data) => {
          debugPrint('connectError $data'),
        });
    socketRealtime.onError((data) => debugPrint('onError $data'));
    socketRealtime.onDisconnect((_) => debugPrint(
        '===============\DISCONNECT FROM REALTIME PAGE\n==============='));
  }

  void setNewResponseDataFromSocket(dynamic data, bool hasData) {
    setState(() {
      hasNewData = true;
    });
    debugPrint('========= hasNewData : $hasNewData =========');
    if (hasNewData) {
      dataCharging = ChargingInfoModel.fromJson(data);
      statusPayment = dataCharging?.statusPayment ?? false;
      paymentMethod = dataCharging?.receiptData?.paymentMethod ?? '';
      statusdebt = dataCharging?.statusDebt ?? false;

      checkLoadPage = true;

      if (statusPayment && statusdebt) {
        checkPaymentCaseDebtError();
      }
    }
  }
  /***** End Socket *****/

  void actionConfirmTransactionLoading() {
    if (!isLoadingConfirm) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          isLoadingConfirm = true;
        });
      });
    }
  }

  void actionConfirmTransactionFailure() {
    CheckStatusEntity data = CheckStatusEntity(
      chargingStatus: true,
      data: responseData?.data,
      informationCharger: responseData?.informationCharger,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        onPressedConfirm = false;
        isLoadingConfirm = false;
      });
      if (widget.fromFleet == true) {
        while (Navigator.canPop(context)) {
          Navigator.of(context).pop({'isGotoFleetOperation': backtoFleet});
        }
      } else {
        while (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        checkStatusChargingData?.checkStatusEntity = data;
        BlocProvider.of<StatusChargingCubit>(context).statusCharging(data);
        // Navigator.pushReplacement(
        //   context,
        //   PageRouteBuilder(
        //     pageBuilder: (BuildContext context, Animation<double> animation,
        //         Animation<double> secondaryAnimation) {
        //       return MainMenuPage(
        //         checkStatusEntity: data,
        //       );
        //     },
        //     transitionsBuilder: (BuildContext context,
        //         Animation<double> animation,
        //         Animation<double> secondaryAnimation,
        //         Widget child) {
        //       return ScaleTransition(
        //         scale: Tween<double>(
        //           begin: 0,
        //           end: 1,
        //         ).animate(CurvedAnimation(
        //             parent: animation, curve: Curves.linearToEaseOut)),
        //         child: child,
        //       );
        //     },
        //   ),
        // );
      }
    });
  }

  void actionConfirmTransactionSuccess() {
    CheckStatusEntity data = CheckStatusEntity(
      chargingStatus: false,
      data: null,
      informationCharger: null,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        onPressedConfirm = false;
        isLoadingConfirm = false;
      });
      if (widget.fromFleet == true) {
        while (Navigator.canPop(context)) {
          Navigator.of(context).pop({'isGotoFleetOperation': backtoFleet});
        }
      } else {
        while (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        checkStatusChargingData?.checkStatusEntity = data;
        BlocProvider.of<StatusChargingCubit>(context).statusCharging(data);
        // Navigator.pushReplacement(
        //   context,
        //   PageRouteBuilder(
        //     pageBuilder: (BuildContext context, Animation<double> animation,
        //         Animation<double> secondaryAnimation) {
        //       return MainMenuPage(
        //         checkStatusEntity: data,
        //       );
        //     },
        //     transitionsBuilder: (BuildContext context,
        //         Animation<double> animation,
        //         Animation<double> secondaryAnimation,
        //         Widget child) {
        //       return ScaleTransition(
        //         scale: Tween<double>(
        //           begin: 0,
        //           end: 1,
        //         ).animate(CurvedAnimation(
        //             parent: animation, curve: Curves.linearToEaseOut)),
        //         child: child,
        //       );
        //     },
        //   ),
        // );
      }
    });
  }

  void actionReceiptSuccessCheckStatusLoading() {
    if (!isLoadingConfirm) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          isLoadingConfirm = true;
        });
      });
    }
  }

  Future<void> actionReceiptSuccessCheckStatusFailure() async {
    if (isLoadingConfirm) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          isLoadingConfirm = false;
        });
      });
    }
  }

  Future<void> actionReceiptSuccessCheckStatusSuccess(dynamic state) async {
    responseData = state.checkStatusEntity;
    if (widget.fromFleet == true &&
        widget.fleetType == FleetType.OPERATION &&
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
            Navigator.pop(context, {'forceRefresh': true});
          },
        );
      });
      return;
    }
    bool status_charger = responseData?.data?.statusCharger ?? false;
    bool status_receipt = responseData?.data?.statusReceipt ?? false;
    if (!status_charger && status_receipt) {
      // DATA
      receiptData = responseData?.data?.receiptData;
      location = responseData?.informationCharger?.stationName ?? 'N/A';
      chargerName = responseData?.informationCharger?.chargerName ?? 'N/A';
      startTime = receiptData?.chargingStartTime ?? '';
      endTime = receiptData?.chargingEndTime ?? '';
      energyRate = receiptData?.energyRate ?? ' 0.00 THB/kWh';
      energyDelivered = receiptData?.energyDelivered ?? ' 0.00 kWh';
      chargingFee = receiptData?.priceBeforeDiscount ?? '0.00 THB';
      reserveDiscount = receiptData?.reserveDiscount ?? '0.00 THB';
      priceBeforeVAT = receiptData?.priceBeforeTax ?? '0.00 THB';
      couponDiscount = receiptData?.couponDiscount ?? '- 0 THB';
      vat = receiptData?.tax ?? '0.00 THB';
      totalPrice = receiptData?.totalPrice ?? '0.00 THB';
      paymentMethod = receiptData?.paymentMethod ?? '';
      reserveStatus = receiptData?.reserveStatus ?? false;
      statusAddCoupon = receiptData?.statusAddCoupon ?? false;
      statusUseCoupon = receiptData?.statusUseCoupon ?? false;
      statusPayment = responseData?.data?.statusPayment ?? false;
      statusdebt = responseData?.data?.statusDebt ?? false;
      carBand =
          '${responseData?.informationCharger?.carSelect?.brand ?? ''} ${responseData?.informationCharger?.carSelect?.model ?? ''}';
      licensePlate =
          '${responseData?.informationCharger?.carSelect?.licensePlate ?? ''} ${responseData?.informationCharger?.carSelect?.province ?? ''}';

      checkLoadPage = true;

      /** status_debt **/
      if (statusPayment && statusdebt) {
        checkPaymentCaseDebtError();
      } else {
        if (!statusPayment) {
          fetchTokenToOpenSocket();
          BlocProvider.of<ReceiptSuccessCubit>(context).fetchListPayment(
            qrCode: widget.qrCodeData,
          );
        }
      }
      if (isLoadingConfirm) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            isLoadingConfirm = false;
          });
        });
      }
    } else {
      if (isLoadingConfirm) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            isLoadingConfirm = false;
          });
        });
      }
    }
  }

  void actionChargingGetPaymentLoading() {
    loadingPayment = true;
  }

  void actionChargingGetPaymentFailure() {
    loadingPayment = false;
    errorPayment = true;
  }

  void actionChargingGetPaymentSuccess(dynamic state) {
    List<dynamic> data = state.listPayment;
    var testets = json.encode(data, toEncodable: (e) => e.toJsonAttr());
    List<PaymentTypeHasDefalutEntity> paymentTypes = parsePaymentTypes(testets);
    listPaymentItem = paymentTypes;
    checkIndexSelectPaymentType();
    loadingPayment = false;
    BlocProvider.of<ReceiptSuccessCubit>(context).fetchResetCubitToInital();
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
  }

  void actionChargingUpdatePaymentSuccess() {
    if (loadingPayment) {
      loadingPayment = false;
      lastedIndexPaymentSelected = indexPaymentSelected;
      BlocProvider.of<ReceiptSuccessCubit>(context).fetchUpdatePaymentCharging(
        qrCode: widget.qrCodeData,
      );
    }
  }

  void actionPaymentChargingLoading() {
    if (!isLoadingConfirm) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          isLoadingConfirm = true;
        });
      });
    }
  }

  void actionPaymentChargingFailure(state) {
    if (isLoadingConfirm) {
      isLoadingConfirm = false;
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
  }

  void actionPaymentChargingSuccess() {
    if (isLoadingConfirm) {
      isLoadingConfirm = false;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool value) {
        debugPrint('PopScope : ${value}');
        if (!value) {
          modalAskPermissionPhotos(goToFleetOperation: false);
        }
      },
      child: IgnorePointer(
        ignoring: isLoadingConfirm,
        child: Stack(
          children: [
            Scaffold(
              backgroundColor:
                  statusPayment ? AppTheme.blueLight : AppTheme.white,
              appBar: AppBar(
                backgroundColor:
                    statusPayment ? AppTheme.blueLight : AppTheme.white,
                bottomOpacity: 0.0,
                elevation: 0.0,
                leading: SizedBox(),
                actions: [
                  Container(
                    margin: EdgeInsets.all(statusPayment ? 0 : 12),
                    child: CheckInternetSignal(
                      colorCircle: statusPayment
                          ? AppTheme.white.withOpacity(0.6)
                          : AppTheme.lightBlue10,
                    ),
                  ),
                  statusPayment
                      ? IconButton(
                          icon:
                              const Icon(Icons.close, color: AppTheme.blueDark),
                          onPressed: () {
                            modalAskPermissionPhotos(goToFleetOperation: false);
                          })
                      : const SizedBox(),
                ],
                centerTitle: true,
                title: TextLabel(
                  color: statusPayment ? AppTheme.blueDark : AppTheme.red,
                  text: checkLoadPage
                      ? statusPayment
                          ? translate('receipt_page.successful')
                          : statusdebt
                              ? translate('receipt_page.payment_declined')
                              : translate('receipt_page.payment_progress')
                      : '',
                  fontWeight: FontWeight.w700,
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.superlarge),
                ),
                iconTheme: const IconThemeData(
                  color: AppTheme.blueDark, //change your color here
                ),
              ),
              body: BlocBuilder<ReceiptSuccessCubit, ReceiptSuccessState>(
                  builder: (context, state) {
                switch (state.runtimeType) {
                  case ConfirmTransactionLoading:
                    actionConfirmTransactionLoading();
                    break;
                  case ConfirmTransactionFailure:
                    actionConfirmTransactionFailure();
                    break;
                  case ConfirmTransactionSuccess:
                    actionConfirmTransactionSuccess();
                    break;
                  case ReceiptSuccessCheckStatusLoading:
                    actionReceiptSuccessCheckStatusLoading();
                    break;
                  case ReceiptSuccessCheckStatusFailure:
                    actionReceiptSuccessCheckStatusFailure();
                    break;
                  case ReceiptSuccessCheckStatusSuccess:
                    actionReceiptSuccessCheckStatusSuccess(state);
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
                  case PaymentChargingLoading:
                    actionPaymentChargingLoading();
                    break;
                  case PaymentChargingFailure:
                    actionPaymentChargingFailure(state);
                    break;
                  case PaymentChargingSuccess:
                    actionPaymentChargingSuccess();
                    break;
                  default:
                    break;
                }
                return renderReceiptPage(statusPayment);
              }),
            ),
            isLoadingConfirm ? ReceiptPageLoading() : Container(),
          ],
        ),
      ),
    );
  }

  Widget renderReceiptPage(bool statusPayment) {
    return SingleChildScrollView(
      child: Container(
        color: statusPayment ? AppTheme.blueLight : AppTheme.white,
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        child: Column(
          children: [
            WidgetsToImage(
              controller: controller,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(
                      minHeight: 200,
                    ),
                    decoration: statusPayment
                        ? const ShapeDecoration(
                            shape: ReceiptBorder(
                              pathWidth: 1,
                              radius: 10,
                              borderColor: AppTheme.borderGray,
                              rightBotReverse: true,
                              leftBotReverse: true,
                              bottomDash: true,
                              bottomBorderColor: AppTheme.blueD,
                            ),
                            color: AppTheme.white,
                          )
                        : BoxDecoration(
                            border: Border.all(color: AppTheme.borderGray),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                    child: Stack(
                      children: [
                        //* Background Image
                        BGImage(hasBgImage: hasBgImage),
                        Container(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RowTotalPrice(
                                hasBgImage: hasBgImage,
                                total: '${receiptData?.totalPrice ?? '. . .'}',
                              ),
                              const SizedBox(height: 16),
                              //* Dash in Container
                              !hasBgImage
                                  ? DashLine(width: 0.9, color: AppTheme.blueD)
                                  : const SizedBox(),
                              const SizedBox(height: 20),
                              TextLabel(
                                color: AppTheme.black,
                                text: location,
                                fontSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                  context,
                                  20,
                                ),
                                fontWeight: FontWeight.w700,
                              ),
                              TextLabel(
                                color: AppTheme.black,
                                text: chargerName,
                                fontSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                  context,
                                  18,
                                ),
                                fontWeight: FontWeight.w700,
                              ),
                              const SizedBox(height: 12),
                              ((widget.fromFleet ?? false) &&
                                      widget.fleetType == FleetType.OPERATION)
                                  ? RowWithTwoText(
                                      textLeft:
                                          translate('receipt_page.car_band'),
                                      textRight: carBand,
                                      textLeftFontColor: AppTheme.black40,
                                      textRightFontColor: AppTheme.black,
                                      textRightFontWeight: FontWeight.w400,
                                      textLeftSize: Utilities
                                          .sizeFontWithDesityForDisplay(
                                        context,
                                        20,
                                      ),
                                      textRightSize: Utilities
                                          .sizeFontWithDesityForDisplay(
                                        context,
                                        20,
                                      ),
                                    )
                                  : const SizedBox(),
                              ((widget.fromFleet ?? false) &&
                                      widget.fleetType == FleetType.OPERATION)
                                  ? const SizedBox(height: 8)
                                  : const SizedBox(),
                              ((widget.fromFleet ?? false) &&
                                      widget.fleetType == FleetType.OPERATION)
                                  ? RowWithTwoText(
                                      textLeft: translate(
                                          'receipt_page.license_plate'),
                                      textRight: licensePlate,
                                      textLeftFontColor: AppTheme.black40,
                                      textRightFontColor: AppTheme.black,
                                      textRightFontWeight: FontWeight.w400,
                                      textLeftSize: Utilities
                                          .sizeFontWithDesityForDisplay(
                                        context,
                                        20,
                                      ),
                                      textRightSize: Utilities
                                          .sizeFontWithDesityForDisplay(
                                        context,
                                        20,
                                      ),
                                    )
                                  : const SizedBox(),
                              ((widget.fromFleet ?? false) &&
                                      widget.fleetType == FleetType.OPERATION)
                                  ? const SizedBox(height: 8)
                                  : const SizedBox(),
                              RowWithTwoText(
                                textLeft: translate('receipt_page.start_time'),
                                textRight: formatDateString(startTime),
                                textLeftFontColor: AppTheme.black40,
                                textRightFontColor: AppTheme.black,
                                textRightFontWeight: FontWeight.w400,
                                textLeftSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                  context,
                                  20,
                                ),
                                textRightSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                  context,
                                  20,
                                ),
                              ),
                              const SizedBox(height: 8),
                              RowWithTwoText(
                                textLeft: translate('receipt_page.end_time'),
                                textRight: formatDateString(endTime),
                                textLeftFontColor: AppTheme.black40,
                                textRightFontColor: AppTheme.black,
                                textRightFontWeight: FontWeight.w400,
                                textLeftSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                  context,
                                  20,
                                ),
                                textRightSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                  context,
                                  20,
                                ),
                              ),
                              const SizedBox(height: 8),
                              RowWithTwoText(
                                textLeft: translate('receipt_page.energy_rate'),
                                textRight: energyRate,
                                textLeftFontColor: AppTheme.black40,
                                textRightFontColor: AppTheme.black,
                                textRightFontWeight: FontWeight.w400,
                                textLeftSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                  context,
                                  20,
                                ),
                                textRightSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                        context, 20),
                              ),
                              const SizedBox(height: 8),
                              RowWithTwoText(
                                flexLeft: 1,
                                flexRight: 1,
                                textLeft:
                                    translate('receipt_page.energy_delivered'),
                                textRight: energyDelivered,
                                textLeftFontColor: AppTheme.black40,
                                textRightFontColor: AppTheme.black,
                                textRightFontWeight: FontWeight.w700,
                                textLeftSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                  context,
                                  20,
                                ),
                                textRightSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                  context,
                                  20,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Container(
                                  height: 1,
                                  color: AppTheme.black20,
                                ),
                              ),
                              const SizedBox(height: 12),
                              RowWithTwoText(
                                textLeft:
                                    translate('receipt_page.charging_fee'),
                                textRight: chargingFee,
                                textLeftFontColor: AppTheme.black40,
                                textRightFontColor: AppTheme.black,
                                textRightFontWeight: FontWeight.w400,
                                textLeftSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                  context,
                                  20,
                                ),
                                textRightSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                  context,
                                  20,
                                ),
                              ),
                              const SizedBox(height: 8),
                              reserveStatus
                                  ? RowWithTwoText(
                                      textLeft:
                                          translate('receipt_page.reserve_fee'),
                                      textRight: '- $reserveDiscount',
                                      textLeftFontColor: AppTheme.blueDark,
                                      textRightFontColor: AppTheme.blueDark,
                                      textRightFontWeight: FontWeight.w400,
                                      textLeftSize: Utilities
                                          .sizeFontWithDesityForDisplay(
                                        context,
                                        20,
                                      ),
                                      textRightSize: Utilities
                                          .sizeFontWithDesityForDisplay(
                                        context,
                                        20,
                                      ),
                                    )
                                  : const SizedBox(),
                              reserveStatus
                                  ? const SizedBox(height: 8)
                                  : const SizedBox(),
                              statusAddCoupon
                                  ? RowWithTwoTextForCoupon(
                                      couponDiscount: couponDiscount,
                                      statusUseCoupon: statusUseCoupon,
                                    )
                                  : const SizedBox(),
                              statusAddCoupon
                                  ? const SizedBox(height: 8)
                                  : const SizedBox(),
                              RowWithTwoText(
                                textLeft: translate('receipt_page.vat'),
                                textRight: vat,
                                textLeftFontColor: AppTheme.black40,
                                textRightFontColor: AppTheme.black,
                                textRightFontWeight: FontWeight.w400,
                                textLeftSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                  context,
                                  20,
                                ),
                                textRightSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                  context,
                                  20,
                                ),
                              ),
                              const SizedBox(height: 8),
                              RowWithTwoText(
                                textLeft:
                                    translate('receipt_page.price_before_vat'),
                                textRight: priceBeforeVAT,
                                textLeftFontColor: AppTheme.black40,
                                textRightFontColor: AppTheme.black,
                                textRightFontWeight: FontWeight.w400,
                                textLeftSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                  context,
                                  20,
                                ),
                                textRightSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                  context,
                                  20,
                                ),
                              ),
                              const SizedBox(height: 8),
                              RowWithTwoText(
                                textLeft: translate('receipt_page.total'),
                                textRight: totalPrice,
                                textLeftFontColor: AppTheme.black40,
                                textRightFontColor: AppTheme.blueDark,
                                textRightFontWeight: FontWeight.w700,
                                textLeftSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                  context,
                                  20,
                                ),
                                textRightSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                  context,
                                  24,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Container(
                                  height: 1,
                                  color: AppTheme.black20,
                                ),
                              ),
                              const SizedBox(height: 12),
                              statusPayment
                                  ? RowPaymentMethod(
                                      value: paymentMethod,
                                      fromFleet: widget.fromFleet,
                                    )
                                  : _renderdebt(statusdebt)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  checkLoadPage
                      ? statusPayment
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 16),
                              width: double.infinity,
                              decoration: const ShapeDecoration(
                                shape: ReceiptBorder(
                                  pathWidth: 1,
                                  radius: 10,
                                  borderColor: AppTheme.borderGray,
                                  leftTopReverse: true,
                                  rightTopReverse: true,
                                  topVisible: false,
                                  bottomBorderColor: AppTheme.borderGray,
                                ),
                                color: AppTheme.white,
                              ),
                              child: const ColTextWithImage(),
                            )
                          : Container(
                              padding: EdgeInsets.only(top: 20),
                              child: TextLabel(
                                maxLines: 1,
                                text: statusdebt
                                    ? translate(
                                        'receipt_page.payment_declined_update')
                                    : '',
                                fontSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                  context,
                                  20,
                                ),
                                color: AppTheme.red,
                              ),
                            )
                      : SizedBox.square(),
                ],
              ),
            ),
            const SizedBox(height: 12),
            renderButtonBottom(),
          ],
        ),
      ),
    );
  }

  Widget _chargerCreditCard(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if (loadingPayment) {
      return Container(
        width: width * widthHalf,
        height: 45,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.grayD4A50),
            color: AppTheme.white),
        child: const Center(
          child: SizedBox(
            width: 20,
            height: 30,
            child: CircularProgressIndicator(
              color: AppTheme.blueD,
              strokeCap: StrokeCap.round,
            ),
          ),
        ),
      );
    } else if (errorPayment) {
      return Container(
        width: width * widthHalf,
        height: 45,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.grayD4A50),
            color: AppTheme.white),
        child: Center(
          child: TextLabel(
            text: translate('charging_page.error_load_creditcard'),
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.small),
            fontWeight: FontWeight.bold,
            color: AppTheme.blueDark,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    } else {
      return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              enableDrag: false,
              isDismissible: false,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12))),
              builder: (BuildContext context) {
                return ModalSelectPayment(
                    idSelectedPayment: lastedIndexPaymentSelected,
                    listPaymentItem: listPaymentItem,
                    onSelectPayment: onSelectPayment,
                    confirmPayment: confirmPayment,
                    onPressedAddCards: onClickAddCard);
              },
            );
            // .whenComplete(onAllActionCloseModal);
          },
          child: Container(
              width: width * 0.3,
              height: 45,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.red),
                  color: AppTheme.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _renderIconCreditCard(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            padding: const EdgeInsets.only(left: 8),
                            // width: width * 0.24,
                            child: TextLabel(
                              text: getLastFourCharacter(paymentMethod),
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.little),
                              fontWeight: FontWeight.bold,
                              color: AppTheme.blueDark,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                      )
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppTheme.blueDark,
                  )
                ],
              )));
    }
  }

  Widget _renderIconCreditCard() {
    return Container(
        width: 32,
        child: Utilities.assetCreditCard(
            cardBrand: getTypeFromValue(paymentMethod),
            defaultCard: ImageAsset.card_default_logo));
  }

  Widget _renderdebt(bool debt) {
    if (debt) {
      return Container(
        child: Row(
          children: [
            TextLabel(
              maxLines: 1,
              text: translate('receipt_page.payment_method'),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                context,
                20,
              ),
              color: AppTheme.red,
            ),
            const Expanded(child: SizedBox()),
            _chargerCreditCard(context)
          ],
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 12, bottom: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.grayD4A50),
            color: AppTheme.white),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: AppTheme.blueD,
                  strokeCap: StrokeCap.round,
                ),
              ),
              const SizedBox(height: 8),
              TextLabel(
                text: translate('receipt_page.payment_progress'),
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context,
                  20,
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  Widget renderButtonBottom() {
    if (statusPayment) {
      if (widget.fromFleet != true) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.1),
            ButtonSaveImg(
              text: translate('button.back_to_home'),
              onClickButton: () {
                modalAskPermissionPhotos(goToFleetOperation: false);
              },
              fleetType: widget.fleetType,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.1),
          ],
        );
      } else {
        switch (widget.fleetType) {
          case FleetType.CARD:
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                ButtonSaveImg(
                  text: translate('button.back_to_home'),
                  onClickButton: () {
                    modalAskPermissionPhotos(goToFleetOperation: false);
                  },
                  fleetType: widget.fleetType,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
              ],
            );
          case FleetType.OPERATION:
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonGoToFleetOperation(
                  text: translate('button.back_to_operation'),
                  onClickButton: () {
                    modalAskPermissionPhotos(goToFleetOperation: true);
                  },
                ),
                ButtonSaveImg(
                  text: translate('button.back_to_home'),
                  onClickButton: () {
                    modalAskPermissionPhotos(goToFleetOperation: false);
                  },
                  fleetType: widget.fleetType,
                ),
              ],
            );
          default:
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                ButtonSaveImg(
                  text: translate('button.back_to_home'),
                  onClickButton: () {
                    modalAskPermissionPhotos(goToFleetOperation: false);
                  },
                  fleetType: widget.fleetType,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
              ],
            );
        }
      }
    } else
      return const SizedBox.shrink();
  }
}
