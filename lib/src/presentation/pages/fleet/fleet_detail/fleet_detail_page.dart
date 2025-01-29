import 'dart:io';
import 'dart:math';
import 'package:animated_styled_widget/animated_styled_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/unfocus_area.dart';
import 'package:jupiter_api/domain/entities/car_entity.dart';
import 'package:jupiter_api/domain/entities/car_fleet_info_entity.dart';
import 'package:jupiter_api/domain/entities/charger_realtime_entity.dart';
import 'package:jupiter_api/domain/entities/check_status_entity.dart';
import 'package:jupiter_api/domain/entities/connector_information_entity.dart';
import 'package:jupiter_api/domain/entities/fleet_card_info_entity.dart';
import 'package:jupiter_api/domain/entities/fleet_operation_info_entity.dart';
import 'package:jupiter_api/domain/entities/history_fleet_entity.dart';
import 'package:jupiter_api/domain/entities/llst_station_fleet_card_entity.dart';
import 'package:jupiter_api/domain/entities/llst_station_fleet_operation_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/charging/charging_page.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in/check_in_page.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/receipt/receipt_page.dart';
import 'package:jupiter/src/presentation/pages/ev_information/ev_information_page.dart';
import 'package:jupiter/src/presentation/pages/ev_information_add/ev_information_add_page.dart';
import 'package:jupiter/src/presentation/pages/fleet/cubit/fleet_cubit.dart';
import 'package:jupiter/src/presentation/pages/fleet/fleet_detail/widgets/fleet_detail_top.dart';
import 'package:jupiter/src/presentation/pages/fleet/fleet_detail/widgets/fleet_tab.dart';
import 'package:jupiter/src/presentation/pages/fleet/fleet_detail/widgets/fleet_tab_detail.dart';
import 'package:jupiter/src/presentation/pages/scan_qrcode/scan_qrcode_page.dart';
import 'package:jupiter/src/presentation/widgets/button_progress.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';
import '../../../../firebase_log.dart';

class FleetDetailPage extends StatefulWidget {
  const FleetDetailPage({
    super.key,
    required this.fleetType,
    required this.fleetNo,
    this.fleetCardNo,
    this.fleetCardType,
  });
  final String fleetType;
  final int fleetNo;
  final String? fleetCardNo;
  final String? fleetCardType;

  @override
  State<FleetDetailPage> createState() => _FleetDetailPageState();
}

class _FleetDetailPageState extends State<FleetDetailPage>
    with SingleTickerProviderStateMixin {
  bool loadingPage = true;
  bool loadingCheckStatus = true;
  bool loadingTab = true;
  late TabController tabController;
  int selectedTab = 0;
  // VALUE FROM API
  String image = '';
  String textDisplay = '';
  String textCar = '';
  double max = 100;
  double usage = 1;
  double totalEnergy = 0;
  String billDate = '';
  CarFleetInfoEntity? carFleetInfo;
  List<CarFleetInfoEntity>? carFleetList = List.empty(growable: true);
  ListStationFleetCardEntity? fleetCardStation;
  ListStationFleetOperationEntity? fleetOperationStation;
  // RESPONSE DATA
  CheckStatusEntity? responseData;
  bool statusCharging = false;
  bool? statusCharger = null;
  bool? statusReceipt = null;
  List<HistoryFleetDataEntity>? historyList;
  bool closeExpandedStation = false;

  // String typeFleetCard = FleetCardType.FLEET;

  String getTypeChargeFleet(String type) {
    switch (type) {
      case FleetOperationStatus.CHARGING_AUTOCHARGE:
        return FleetOperationStatus.CHARGING_AUTOCHARGE;
      case FleetOperationStatus.CHARGING_RFID:
        return FleetOperationStatus.CHARGING_RFID;
      case FleetCardType.RFID:
        return FleetOperationStatus.CHARGING_RFID;
      case FleetCardType.AUTOCHARGE:
        return FleetOperationStatus.CHARGING_AUTOCHARGE;
      default:
        return FleetOperationStatus.CHARGING;
    }
  }

  @override
  void initState() {
    FirebaseLog.logPage(this);
    initialTabController();
    loadFleetDetailData();
    super.initState();
  }

  void loadFleetDetailData() {
    switch (widget.fleetType) {
      case FleetType.CARD:
        checkStatusForFleetCard();
        break;
      case FleetType.OPERATION:
        BlocProvider.of<FleetCubit>(context)
            .fetchFleetOperationDetail(fleetNo: widget.fleetNo);
        break;
      default:
        Future.delayed(const Duration(milliseconds: 1000), () {
          setState(() {
            loadingPage = false;
          });
        });
        break;
    }
  }

  void initialTabController() {
    tabController = TabController(vsync: this, length: 2);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        setState(() {
          selectedTab = tabController.index;
        });
        onChangeTab(tabController.index);
      }
    });
  }

  void checkStatusForFleetCard() {
    if (widget.fleetType == FleetType.CARD) {
      BlocProvider.of<FleetCubit>(context).fetchCheckStatusFleetCard(
          fleetNo: widget.fleetNo, refCode: widget.fleetCardNo ?? '');
    }
  }

  void onRefreshPage() {
    switch (widget.fleetType) {
      case FleetType.CARD:
        checkStatusForFleetCard();
        break;
      case FleetType.OPERATION:
        BlocProvider.of<FleetCubit>(context)
            .fetchFleetOperationStation(fleetNo: widget.fleetNo);
        break;
    }
  }

  Future<void> onPressedConnector(
    String connectorCode,
    String chargerId,
    String connectorId,
    int connectorIndex,
    bool statusCharging,
    bool statusReceipt,
    String chargingType,
  ) async {
    if (widget.fleetType == FleetType.OPERATION) {
      if (statusCharging && !statusReceipt) {
        debugPrint('fleet no : ${widget.fleetNo}');
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return JupiterChargingPage(
                qrCodeData: connectorCode,
                fleetNo: widget.fleetNo,
                fleetType: widget.fleetType,
                fromFleet: true,
                chargingType: getTypeChargeFleet(chargingType),
              );
            },
          ),
        );
        BlocProvider.of<FleetCubit>(context)
            .fetchFleetOperationDetail(fleetNo: widget.fleetNo);
      } else if (statusCharging && statusReceipt) {
        var result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return JupiterChargingReceiptPage(
                qrCodeData: connectorCode,
                chargerRealtimeEntity: ChargerRealtimeEntity(
                  stationId: '',
                  stationName: '',
                  chargerName: '',
                  chargerSerialNo: '',
                  chargerBrand: '',
                  pricePerUnit: '',
                  totalConnector: 0,
                  chargerType: '',
                  connector: ConnectorInformationEntity(
                    stationId: '',
                    chargerId: chargerId,
                    owener: '',
                    connectorId: connectorId,
                    connectorIndex: connectorIndex,
                    connectorType: '',
                    connectorPosition: '',
                    connectorStatusActive: '',
                    premiumChargingStatus: null,
                  ),
                  chargingMode: null,
                  optionalCharging: null,
                  facilityName: null,
                  carSelect: null,
                  paymentType: null,
                  lowPriorityTariff: false,
                ),
                fleetNo: widget.fleetNo,
                fleetType: widget.fleetType,
                fromFleet: true,
              );
            },
          ),
        );
        if (result['forceRefresh'] == true) {
          BlocProvider.of<FleetCubit>(context)
              .fetchFleetOperationDetail(fleetNo: widget.fleetNo);
        }
      } else {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return JupiterChargingCheckInPage(
                qrCodeData: connectorCode,
                fleetType: widget.fleetType,
                fromFleet: true,
                fleetNo: widget.fleetNo,
              );
            },
          ),
        );
        BlocProvider.of<FleetCubit>(context)
            .fetchFleetOperationDetail(fleetNo: widget.fleetNo);
      }
    }
  }

  void onPressedWhenChargingFleetCard() async {
    if (statusCharger == false && statusReceipt == true) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return JupiterChargingReceiptPage(
          qrCodeData: responseData?.data?.chargerName ?? '',
          chargerRealtimeEntity: ChargerRealtimeEntity(
            stationId: '',
            stationName: '',
            chargerName: '',
            chargerSerialNo: '',
            chargerBrand: '',
            pricePerUnit: '',
            totalConnector: 0,
            chargerType: '',
            connector: responseData?.informationCharger?.connector,
            chargingMode: null,
            optionalCharging: null,
            facilityName: null,
            carSelect: null,
            paymentType: null,
            lowPriorityTariff: false,
          ),
          fleetNo: widget.fleetNo,
          fleetType: FleetType.CARD,
          fromFleet: true,
          refCode: widget.fleetCardNo ?? '',
          fleetCardNo: textDisplay,
        );
      }));
    } else {
      await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return JupiterChargingPage(
          qrCodeData: responseData?.data?.chargerName ?? '',
          refCode: widget.fleetCardNo ?? '',
          fleetNo: widget.fleetNo,
          fleetType: FleetType.CARD,
          fromFleet: true,
          chargingType: getTypeChargeFleet(widget.fleetCardType ?? ''),
          fleetCardNo: textDisplay,
        );
      }));

      checkStatusForFleetCard();
    }
  }

  Future<void> onPressScanQRCodeFleetCard() async {
    dynamic resultFromCheckIn = '';
    dynamic resultFromScanQr =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ScanQRCodePage(
        fromFleet: true,
        fleetNo: widget.fleetNo,
        fleetType: FleetType.CARD,
      );
    }));

    if (resultFromScanQr.toString() != '' && resultFromScanQr != null) {
      resultFromCheckIn =
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return JupiterChargingCheckInPage(
          qrCodeData: resultFromScanQr.toString(),
          fromFleet: true,
          fleetNo: widget.fleetNo,
          fleetType: FleetType.CARD,
        );
      }));
    }

    if (resultFromCheckIn['qrcode'] != '' &&
        resultFromCheckIn['qrcode'] != null) {
      await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return JupiterChargingPage(
          qrCodeData: resultFromCheckIn['qrcode'],
          refCode: widget.fleetCardNo ?? '',
          fleetNo: widget.fleetNo,
          fleetType: FleetType.CARD,
          fromFleet: true,
          chargingType: getTypeChargeFleet(widget.fleetCardType ?? ''),
          fleetCardNo: textDisplay,
          showModalWaitingCharger: resultFromCheckIn['isShow'] ?? false,
        );
      }));
      debugPrint('CALLBACK TO CHECKSTATUS AGAIN');
      checkStatusForFleetCard();
    }
  }

  void onChangeTab(int index) {
    if (index == 0) {
      switch (widget.fleetType) {
        case FleetType.CARD:
          BlocProvider.of<FleetCubit>(context)
              .fetchFleetCardStation(fleetNo: widget.fleetNo);
          break;
        case FleetType.OPERATION:
          BlocProvider.of<FleetCubit>(context)
              .fetchFleetOperationStation(fleetNo: widget.fleetNo);
          break;
      }
    }
    if (index == 1) {
      switch (widget.fleetType) {
        case FleetType.CARD:
          BlocProvider.of<FleetCubit>(context).fetchGetHistoryFleetCardList(
              fleetNo: widget.fleetNo, refCode: textDisplay);

          break;
        case FleetType.OPERATION:
          BlocProvider.of<FleetCubit>(context)
              .fetchGetHistoryFleetOperationList(fleetNo: widget.fleetNo);
          break;
      }
    }
  }

  void onPressedBackButton() {
    Navigator.of(context).pop();
  }

  void onPressedWidget() {
    switch (widget.fleetType) {
      case FleetType.CARD:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EvInformationAddPage(
              carEntity: CarEntity(
                brand: carFleetInfo?.brand ?? '',
                licensePlate: carFleetInfo?.licensePlate ?? '',
                model: carFleetInfo?.model ?? '',
                orgCode: carFleetInfo?.orgCode ?? '',
                username: '',
                defalut: false,
                province: carFleetInfo?.province ?? '',
                vehicleNo: carFleetInfo?.vehicleNo ?? -1,
                image: carFleetInfo?.image ?? '',
              ),
              fromFleet: true,
            ),
          ),
        );
        break;
      case FleetType.OPERATION:
        List<CarEntity> carList = List.empty(growable: true);
        int carFleetListLength = carFleetList?.length ?? 0;
        for (int i = 0; i < carFleetListLength; i++) {
          carList.add(CarEntity(
            brand: carFleetList?[i].brand ?? '',
            licensePlate: carFleetList?[i].licensePlate ?? '',
            model: carFleetList?[i].model ?? '',
            orgCode: carFleetList?[i].orgCode ?? '',
            username: '',
            defalut: false,
            province: carFleetList?[i].province ?? '',
            vehicleNo: carFleetList?[i].vehicleNo ?? -1,
            image: carFleetList?[i].image ?? '',
          ));
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EvInformationPage(
              listCarEntity: carList,
              fromFleet: true,
            ),
          ),
        );
        break;
      default:
        break;
    }
  }

  String getTitlePageFromFleetType() {
    switch (widget.fleetType) {
      case FleetType.CARD:
        if (widget.fleetCardType == FleetCardType.FLEET) {
          return translate('app_title.fleet_card');
        } else if (widget.fleetCardType == FleetCardType.RFID) {
          return translate('fleet_page.card.filter.rfid');
        } else if (widget.fleetCardType == FleetCardType.AUTOCHARGE) {
          return translate('fleet_page.card.filter.auto_charge');
        } else {
          return translate('app_title.fleet_card');
        }
      case FleetType.OPERATION:
        return translate('app_title.fleet_operation');
      default:
        return '';
    }
  }

  Color getBackgroundColorPageFromIndex() {
    switch (selectedTab) {
      case 0:
        return AppTheme.grayF1F5F9;
      case 1:
        return AppTheme.white;
      default:
        return AppTheme.white;
    }
  }

  void actionFleetLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingPage) {
        setState(() {
          loadingPage = true;
        });
      }
    });
  }

  void actionFleetCheckStatusLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingCheckStatus) {
        setState(() {
          loadingCheckStatus = true;
        });
      }
    });
  }

  void actionFleetCardDetailSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        FleetCardInfoEntity? data = state.fleetCardEntity ?? null;
        setState(() {
          loadingPage = false;
          image = data?.image ?? '';
          textDisplay = data?.fleetCardNo ?? '';
          textCar =
              '${data?.fleetCar.licensePlate ?? 'N/A'} ${data?.fleetCar.province ?? ''}';
          max = data?.creditMax ?? 100;
          usage = data?.creditUsage ?? 1;
          totalEnergy = data?.totalEnergyCharging ?? 1;
          billDate = data?.billDate ?? 'N/A';
          carFleetInfo = data?.fleetCar ?? null;
        });
        BlocProvider.of<FleetCubit>(context)
            .fetchFleetCardStation(fleetNo: widget.fleetNo);
      }
    });
  }

  void actionFleetCardDetailFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
        });
        BlocProvider.of<FleetCubit>(context).resetStateFleet();
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
  }

  void actionFleetOperationDetailSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        FleetOperationInfoEntity? data = state.fleetOperationEntity ?? null;
        setState(() {
          loadingPage = false;
          image = data?.image ?? '';
          textDisplay = data?.fleetName ?? '';
          textCar = '${data?.totalCarOperation ?? 'N/A'}';
          max = data?.creditMax ?? 100;
          usage = data?.creditUsage ?? 1;
          totalEnergy = data?.totalEnergyCharging ?? 1;
          billDate = data?.billDate ?? 'N/A';
          carFleetList = data?.fleetCar ?? null;
        });
        BlocProvider.of<FleetCubit>(context)
            .fetchFleetOperationStation(fleetNo: widget.fleetNo);
      }
    });
  }

  void actionFleetOperationDetailFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
        });
        BlocProvider.of<FleetCubit>(context).resetStateFleet();
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
  }

  void actionFleetTabLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingTab) {
        setState(() {
          loadingTab = true;
          closeExpandedStation = true;
        });
      }
    });
  }

  void actionFleetCardStationSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingTab) {
        setState(() {
          loadingTab = false;
          fleetCardStation = state.fleetCardStationEntity;
          closeExpandedStation = false;
        });
        BlocProvider.of<FleetCubit>(context).resetStateFleet();
      }
    });
  }

  void actionFleetCardStationFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingTab) {
        setState(() {
          loadingTab = false;
        });
        BlocProvider.of<FleetCubit>(context).resetStateFleet();
      }
    });
  }

  void actionFleetOperationStationSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingTab) {
        setState(() {
          loadingTab = false;
          fleetOperationStation = state.fleetOperationStationEntity;
          closeExpandedStation = false;
        });
        BlocProvider.of<FleetCubit>(context).resetStateFleet();
      }
    });
  }

  void actionFleetOperationStationFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingTab) {
        setState(() {
          loadingTab = false;
        });
      }
    });
  }

  void actionFleetCheckStatusSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingCheckStatus) {
        responseData = state.checkStatusEntity;
        setState(() {
          loadingCheckStatus = false;
          statusCharging = responseData?.chargingStatus ?? false;
          statusCharger = responseData?.data?.statusCharger ?? false;
          statusReceipt = responseData?.data?.statusReceipt ?? false;
        });
        BlocProvider.of<FleetCubit>(context).resetStateFleet();
        BlocProvider.of<FleetCubit>(context).fetchFleetCardDetail(
            fleetNo: widget.fleetNo, fleetCardNo: widget.fleetCardNo ?? '');
      }
    });
  }

  void actionFleetCheckStatusFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingCheckStatus) {
        setState(() {
          loadingCheckStatus = false;
        });
        BlocProvider.of<FleetCubit>(context).resetStateFleet();
        BlocProvider.of<FleetCubit>(context).fetchFleetCardDetail(
            fleetNo: widget.fleetNo, fleetCardNo: widget.fleetCardNo ?? '');
      }
    });
  }

  void actionDefault() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
        });
      }
      if (loadingTab) {
        setState(() {
          loadingTab = false;
        });
      }
      if (loadingCheckStatus) {
        setState(() {
          loadingCheckStatus = false;
        });
      }
    });
  }

  void actionFleetHistoryListSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingTab) {
        historyList = state.historyList;
        setState(() {
          loadingTab = false;
        });
        BlocProvider.of<FleetCubit>(context).resetStateFleet();
      }
    });
  }

  void actionFleetHistoryListFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingTab) {
        setState(() {
          loadingTab = false;
        });
        BlocProvider.of<FleetCubit>(context).resetStateFleet();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return RefreshIndicator(
      onRefresh: () async {
        onRefreshPage();
      },
      child: UnfocusArea(
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
              onPressed: onPressedBackButton,
            ),
            centerTitle: true,
            title: TextLabel(
              text: getTitlePageFromFleetType(),
              color: AppTheme.blueDark,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.title),
              fontWeight: FontWeight.w700,
            ),
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              BlocBuilder<FleetCubit, FleetState>(
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case FleetLoading:
                      actionFleetLoading();
                      break;
                    case FleetCheckStatusLoading:
                      actionFleetCheckStatusLoading();
                      break;
                    case FleetCardDetailSuccess:
                      actionFleetCardDetailSuccess(state);
                      break;
                    case FleetCardDetailFailure:
                      actionFleetCardDetailFailure(state);
                      break;
                    case FleetOperationDetailSuccess:
                      actionFleetOperationDetailSuccess(state);
                      break;
                    case FleetOperationDetailFailure:
                      actionFleetOperationDetailFailure(state);
                      break;
                    case FleetTabLoading:
                      actionFleetTabLoading();
                      break;
                    case FleetCardStationSuccess:
                      actionFleetCardStationSuccess(state);
                      break;
                    case FleetCardStationFailure:
                      actionFleetCardStationFailure(state);
                      break;
                    case FleetOperationStationSuccess:
                      actionFleetOperationStationSuccess(state);
                      break;
                    case FleetOperationStationFailure:
                      actionFleetOperationStationFailure(state);
                      break;
                    case FleetCheckStatusSuccess:
                      actionFleetCheckStatusSuccess(state);
                      break;
                    case FleetCheckStatusFailure:
                      actionFleetCheckStatusFailure(state);
                      break;
                    case FleetHistoryListSuccess:
                      actionFleetHistoryListSuccess(state);
                      break;
                    case FleetHistoryListFailure:
                      actionFleetHistoryListFailure(state);
                      break;
                    default:
                      actionDefault();
                      break;
                  }
                  return renderFleetDetailCardFromType();
                },
              ),
            ],
          ),
          floatingActionButton: renderFloatingButton(keyboardIsOpen),
        ),
      ),
    );
  }

  Widget renderFloatingButton(bool showKeyboard) {
    return Visibility(
      visible: !showKeyboard && widget.fleetType == FleetType.CARD,
      child: Container(
        width: 75,
        height: 75,
        margin: EdgeInsets.only(bottom: Platform.isIOS ? 0 : 12),
        child: statusCharging
            ? Visibility(
                visible: !loadingCheckStatus,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 15,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ButtonProgress(
                    visible: true,
                    finish: false,
                    borderWidth: 6,
                    width: 75.toPXLength,
                    height: 75.toPXLength,
                    gradient: const SweepGradient(startAngle: pi, colors: [
                      AppTheme.red,
                      AppTheme.red,
                    ]),
                    onTap: onPressedWhenChargingFleetCard,
                    child: SvgPicture.asset(
                      ImageAsset.ic_car_charging,
                      width: 48,
                      height: 48,
                      color: AppTheme.red,
                    ),
                  ),
                ),
              )
            : Visibility(
                visible: !loadingCheckStatus &&
                    (widget.fleetCardType == FleetCardType.FLEET),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 15,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: FloatingActionButton(
                    splashColor: AppTheme.lightBlue,
                    backgroundColor: loadingCheckStatus
                        ? AppTheme.gray9CA3AF
                        : AppTheme.white,
                    child: SvgPicture.asset(
                      ImageAsset.ic_qr_code,
                      color: loadingCheckStatus
                          ? AppTheme.white
                          : AppTheme.lightBlue,
                    ),
                    onPressed: onPressScanQRCodeFleetCard,
                  ),
                ),
              ),
      ),
    );
  }

  Widget renderFleetDetailCardFromType() {
    return Container(
      color: getBackgroundColorPageFromIndex(),
      width: double.infinity,
      height: MediaQuery.of(context).size.height - AppTheme.appBarHeight,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Column(
            children: [
              FleetDetailTop(
                fleetType: widget.fleetType,
                onPressedWidget: onPressedWidget,
                loading: loadingPage,
                image: image,
                textDisplay: textDisplay,
                textCar: textCar,
                max: max,
                usage: usage,
                totalEnergy: totalEnergy,
                billDate: billDate,
              ),
              FleetTab(
                fleetType: widget.fleetType,
                onPressedTab: onChangeTab,
                selectedTab: selectedTab,
                tabController: tabController,
              ),
              FleetTabDetail(
                  fleetType: widget.fleetType,
                  loading: loadingTab,
                  selectedTab: selectedTab,
                  fleetCardStation: fleetCardStation,
                  fleetOperationStation: fleetOperationStation,
                  fleetNo: widget.fleetNo,
                  onPressedConnector: onPressedConnector,
                  historyList: historyList,
                  closeExpandedStation: closeExpandedStation)
            ],
          ),
        ),
      ),
    );
  }
}
