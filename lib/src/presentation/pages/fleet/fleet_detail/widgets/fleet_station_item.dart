import 'dart:math';
import 'package:animated_styled_widget/animated_styled_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/pages/fleet/cubit/fleet_cubit.dart';
import 'package:jupiter_api/domain/entities/fleet_card_connector_item_entity.dart';
import 'package:jupiter_api/domain/entities/fleet_operation_connector_item_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/button_progress.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/domain/entities/llst_charger_fleet_card_entity.dart';
import 'package:jupiter_api/domain/entities/llst_charger_fleet_operation_entity.dart';
import 'package:shimmer/shimmer.dart';

class FleetStationItem extends StatefulWidget {
  const FleetStationItem(
      {Key? key,
      required this.isFirstItem,
      required this.fleetType,
      required this.fleetNo,
      required this.data,
      required this.onPressedConnector,
      required this.isExpanded,
      required this.funcExpanded})
      : super(key: key);

  final bool isFirstItem;
  final String fleetType;
  final int fleetNo;
  final dynamic data;
  final Function(String, String, String, int, bool, bool, String)
      onPressedConnector;
  final bool isExpanded;
  final Function(String, bool) funcExpanded;

  @override
  _FleetStationItemState createState() => _FleetStationItemState();
}

class _FleetStationItemState extends State<FleetStationItem> {
  double sizeImageFleet = 74;
  double horizontal = 24;
  double paddingConnector = 12;
  bool loadingCharger = false;
  bool isExpanded = false;
  String isExpandedStation = '';
  double paddingStation = 12;

  ListChargerFleetCardEntity? fleetCardCharger;
  ListChargerFleetOperationEntity? fleetOperationCharger;

  // @override
  // void initState() {
  //   debugPrint('${widget.data}');
  //   super.initState();
  // }

  double widthConnector() {
    return (MediaQuery.of(context).size.width - (horizontal * 2) - (32) - (2)) /
        3;
  }

  double getWidth(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.08;
    return width > 34 ? 34 : width;
  }

  Color checkStatusColorBorder(String checkStatus) {
    switch (checkStatus) {
      // case 'occupied':
      //   return AppTheme.red.withOpacity(0.5);
      // case 'preparing':
      //   return AppTheme.red.withOpacity(0.5);
      // case 'available':
      //   return AppTheme.green.withOpacity(0.5);
      default:
        return AppTheme.borderGray;
    }
  }

  String checkTypeConnector(connectPower, connectType) {
    switch (connectPower) {
      case 'AC':
        if (connectType == 'CS1') {
          return ImageAsset.ic_ac_cs1;
        } else if (connectType == 'CS2') {
          return ImageAsset.ic_ac_cs2;
        } else {
          return ImageAsset.ic_ac_chadeMO;
        }
      case 'DC':
        if (connectType == 'CS1') {
          return ImageAsset.ic_dc_cs1;
        } else if (connectType == 'CS2') {
          return ImageAsset.ic_dc_cs2;
        } else {
          return ImageAsset.ic_dc_chadeMO;
        }
      default:
        return ImageAsset.ic_ac_chadeMO;
    }
  }

  String checkPositionConnector(position) {
    switch (position) {
      case 'L':
        return translate('check_in_page.charger_data.left');
      case 'R':
        return translate('check_in_page.charger_data.right');
      default:
        return translate('check_in_page.charger_data.middle');
    }
  }

  String charger = '';
  List<String> isMaxLine = [];

  void onClickMoreTextConnecter(String chargerId) {
    charger = chargerId;
    int search = isMaxLine.indexWhere((item) => item == chargerId);
    if (search >= 0) {
      isMaxLine.removeWhere((item) => item == chargerId);
    } else {
      isMaxLine.add(chargerId);
    }

    setState(() {});
  }

  bool showStatusCharging({String checktype = ''}) {
    try {
      if (widget.fleetType == FleetType.OPERATION) {
        bool showStatus = false;
        switch (checktype) {
          case FleetOperationStatus.CHARGING:
            showStatus = checkTypeCharging(widget.data?.statusCharging ?? '');
            break;
          case FleetOperationStatus.RECEIPT:
            showStatus = ((widget.data?.statusCharging ?? '') ==
                FleetOperationStatus.RECEIPT);
            break;
          default:
            showStatus = false;
            break;
        }
        return showStatus;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  bool showStatusChargingConnecter(
      {String status = '', String checktype = ''}) {
    try {
      if (widget.fleetType == FleetType.OPERATION) {
        bool showStatus = false;
        switch (checktype) {
          case FleetOperationStatus.CHARGING:
            showStatus = checkTypeCharging(status);
            break;
          case FleetOperationStatus.RECEIPT:
            showStatus = (status == FleetOperationStatus.RECEIPT);
            break;
          default:
            showStatus = false;
            break;
        }
        return showStatus;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  String getIconTypeChargingFleet(String type) {
    switch (type) {
      case FleetOperationStatus.CHARGING_RFID:
        return ImageAsset.ic_rfid;
      case FleetOperationStatus.CHARGING_AUTOCHARGE:
        return ImageAsset.ic_car_charging;
      default:
        return ImageAsset.ic_mobile;
    }
  }

  bool checkTypeCharging(String type) {
    return ((type == FleetOperationStatus.CHARGING) ||
        (type == FleetOperationStatus.CHARGING_RFID) ||
        (type == FleetOperationStatus.CHARGING_AUTOCHARGE));
  }

  void actionFleetChargerLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingCharger) {
        setState(() {
          loadingCharger = true;
        });
      }
    });
    // loadingCharger = true;
  }

  void actionFleetCardCharSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingCharger) {
        setState(() {
          loadingCharger = false;
          fleetCardCharger = state.fleetCardChargerEntity;
        });
        // BlocProvider.of<FleetCubit>(context).resetStateFleet();
      }
    });
  }

  void actionFleetCardCharFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingCharger) {
        setState(() {
          loadingCharger = false;
        });
        BlocProvider.of<FleetCubit>(context).resetStateFleet();
      }
    });
  }

  void actionFleetOperationCharSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingCharger) {
        setState(() {
          loadingCharger = false;
          fleetOperationCharger = state.fleetOperationChargerEntity;
        });
        // BlocProvider.of<FleetCubit>(context).resetStateFleet();
      }
    });
  }

  void actionFleetOperationCharFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingCharger) {
        setState(() {
          loadingCharger = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      margin: EdgeInsets.only(top: widget.isFirstItem ? 0 : 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 15,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: BlocBuilder<FleetCubit, FleetState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case FleetChargerLoading:
              actionFleetChargerLoading();
              break;
            case FleetCardChargerSuccess:
              actionFleetCardCharSuccess(state);
              break;
            case FleetCardChargerFailure:
              actionFleetCardCharFailure(state);
              break;
            case FleetOperationChargerSuccess:
              actionFleetOperationCharSuccess(state);
            case FleetOperationChargerFailure:
              actionFleetOperationCharFailure(state);
              break;
            default:
              break;
          }
          return renderFleetCharger();
        },
      ),
    );
  }

  Widget renderFleetCharger() {
    return Column(
      children: [
        InkWell(
          onTap: () => widget.funcExpanded(
              widget.data?.stationId ?? '', widget.isExpanded),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: horizontal),
            child: Row(
              children: [
                Container(
                  height: 96,
                  width: 96,
                  child: renderImage(widget.data?.image != null
                      ? widget.data?.image.length > 0
                          ? widget.data?.image[0]
                          : ''
                      : ''),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextLabel(
                          text: '${widget.data?.stationName ?? ''}',
                          color: AppTheme.blueDark,
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.superlarge),
                          fontWeight: FontWeight.bold,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            width: 70,
                            child: renderChipTotalCharging(
                                widget.data?.connectorAvailable ?? 0,
                                widget.data?.connectorTotal ?? 0)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  widget.isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 30,
                  color: AppTheme.blueDark,
                )
              ],
            ),
          ),
        ),
        AnimatedSize(
          key: Key('${widget.data?.stationId}'),
          curve: Curves.fastOutSlowIn,
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          child: Visibility(
            visible: widget.isExpanded,
            child: Column(
              children: [
                renderDivider(16, 0),
                renderListCharger(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget renderListCharger() {
    List<Widget> listCharger = [];
    if (widget.fleetType == FleetType.CARD) {
      int chargerLength = fleetCardCharger?.charger.length ?? 0;
      for (int i = 0; i < chargerLength; i++) {
        listCharger.add(
          renderChargerItem(
            chargerId: fleetCardCharger?.charger[i].chargerId ?? '',
            chargerName: fleetCardCharger?.charger[i].chargerName ?? '',
            totalConnector: fleetCardCharger?.charger[i].connectorTotal ?? 0,
            totalConnectorAvailable:
                fleetCardCharger?.charger[i].connectorAvailable ?? 0,
            connector: fleetCardCharger?.charger[i].connector,
          ),
        );
      }
    }
    if (widget.fleetType == FleetType.OPERATION) {
      int chargerLength = fleetOperationCharger?.charger.length ?? 0;
      for (int i = 0; i < chargerLength; i++) {
        listCharger.add(
          renderChargerItem(
            chargerId: fleetOperationCharger?.charger[i].chargerId ?? '',
            chargerName: fleetOperationCharger?.charger[i].chargerName ?? '',
            totalConnector:
                fleetOperationCharger?.charger[i].connectorTotal ?? 0,
            totalConnectorAvailable:
                fleetOperationCharger?.charger[i].connectorAvailable ?? 0,
            connector: fleetOperationCharger?.charger[i].connector,
          ),
        );
      }
    }
    return loadingCharger
        ? Container(
            alignment: Alignment.center,
            height: 100,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: AppTheme.blueD,
                strokeCap: StrokeCap.round,
              ),
            ),
          )
        : Column(
            children: listCharger,
          );
  }

  Widget renderChargerItem({
    required String chargerId,
    required String chargerName,
    required int totalConnector,
    required int totalConnectorAvailable,
    required dynamic connector,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(horizontal, 16, horizontal, 0),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: AppTheme.borderGray,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      ImageAsset.ic_history_list_item,
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        onClickMoreTextConnecter(chargerId);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextLabel(
                          text: '${chargerName}',
                          color: AppTheme.blueDark,
                          fontWeight: FontWeight.bold,
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.big),
                          maxLines: charger == chargerId
                              ? ((isMaxLine.indexWhere(
                                          (item) => item == charger)) >=
                                      0)
                                  ? 10
                                  : 1
                              : 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                renderChipTotalCharging(totalConnectorAvailable, totalConnector)
              ],
            ),
          ),
          renderDivider(16, 0),
          GridView(
            padding: EdgeInsets.only(bottom: paddingConnector),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 140,
            ),
            children: renderListConnector(connector, chargerId),
          ),
        ],
      ),
    );
  }

  List<Widget> renderListConnector(dynamic connector, String chargerId) {
    List<Widget> listConnector = [];
    if (widget.fleetType == FleetType.CARD) {
      int connectorLength = connector.length ?? 0;
      for (int i = 0; i < connectorLength; i++) {
        FleetCardConnectorItemEntity item = FleetCardConnectorItemEntity(
          connectorType: connector[i].connectorType ?? '',
          connectorPowerType: connector[i].connectorPowerType ?? '',
          connectorPosition: connector[i].connectorPosition ?? '',
          connectorStatus: connector[i].connectorStatus ?? '',
          connectorCode: connector[i].connectorCode ?? '',
        );
        listConnector.add(
          renderConnector(
            connectorPower: item.connectorPowerType,
            connectorType: item.connectorType,
            connectorPosition: item.connectorPosition,
            connectorStatus: item.connectorStatus,
            connectorCode: item.connectorCode,
            chargerId: chargerId,
            connectorId: '',
            connectorIndex: -1,
            statusCharging: false,
            statusReceipt: false,
          ),
        );
      }
    }
    if (widget.fleetType == FleetType.OPERATION) {
      int connectorLength = connector.length ?? 0;
      for (int i = 0; i < connectorLength; i++) {
        FleetOperationConnectorItemEntity item =
            FleetOperationConnectorItemEntity(
          connectorType: connector[i].connectorType ?? '',
          connectorPowerType: connector[i].connectorPowerType ?? '',
          connectorPosition: connector[i].connectorPosition ?? '',
          connectorStatus: connector[i].connectorStatus ?? '',
          connectorCode: connector[i].connectorCode ?? '',
          connectorId: connector[i].connectorId ?? '',
          connectorIndex: connector[i].connectorIndex ?? -1,
          statusCharging: connector[i].statusCharging ?? '',
          statusReceipt: connector[i].statusReceipt ?? false,
        );
        listConnector.add(
          renderConnector(
              connectorPower: item.connectorPowerType,
              connectorType: item.connectorType,
              connectorPosition: item.connectorPosition,
              connectorStatus: item.connectorStatus,
              connectorCode: item.connectorCode,
              chargerId: chargerId,
              connectorId: item.connectorId,
              connectorIndex: item.connectorIndex,
              statusCharging: (item.statusCharging ==
                      FleetOperationStatus.CHARGING ||
                  item.statusCharging == FleetOperationStatus.CHARGING_RFID ||
                  item.statusCharging ==
                      FleetOperationStatus.CHARGING_AUTOCHARGE ||
                  item.statusCharging == FleetOperationStatus.RECEIPT),
              statusReceipt: item.statusReceipt,
              showStatusCharging: item.statusCharging),
        );
      }
    }
    return listConnector;
  }

  Widget renderConnector({
    required String connectorPower,
    required String connectorType,
    required String connectorPosition,
    required String connectorStatus,
    required String connectorCode,
    required String chargerId,
    required String connectorId,
    required int connectorIndex,
    required bool statusCharging,
    required bool statusReceipt,
    String showStatusCharging = '',
  }) {
    return Container(
      width: widthConnector(),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(
                paddingConnector, paddingConnector, paddingConnector, 0),
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 1,
                color: checkStatusColorBorder(connectorStatus),
              ),
            ),
            child: Material(
              borderRadius: BorderRadius.circular(12),
              color: AppTheme.white,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  widget.onPressedConnector(
                    connectorCode,
                    chargerId,
                    connectorId,
                    connectorIndex,
                    statusCharging,
                    statusReceipt,
                    showStatusCharging,
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextLabel(
                      text:
                          '${connectorPower} ${Utilities.nameConnecterType(connectorPower, connectorType)}',
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.normal),
                      color: Utilities.getColorStatus(connectorStatus),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Container(
                      width: 36,
                      height: 36,
                      child: SvgPicture.asset(
                        checkTypeConnector(connectorPower, connectorType),
                        color: Utilities.getColorStatus(connectorStatus),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Utilities.getColorStatus(connectorStatus),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: TextLabel(
                        text: checkPositionConnector(connectorPosition),
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.small),
                        color: AppTheme.white,
                      ),
                    ),
                    TextLabel(
                      text: Utilities.getWordStatus(connectorStatus),
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.normal),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      color: Utilities.getColorStatus(connectorStatus),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: 4,
              left: widthConnector() - (paddingConnector * 3),
              child: showStatusChargingConnecter(
                      status: showStatusCharging,
                      checktype: FleetOperationStatus.CHARGING)
                  ? renderStatusCharging(
                      connector: true, typeCharge: showStatusCharging)
                  : renderStatusReceiptAndReady(showStatusChargingConnecter(
                      status: showStatusCharging,
                      checktype: FleetOperationStatus.RECEIPT))),
        ],
      ),
    );
  }

  Widget renderChipTotalCharging(int totalCharging, int connector) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200), color: AppTheme.grayD1D5DB),
      child: Row(children: [
        SvgPicture.asset(
          ImageAsset.ac_type2,
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 4),
        TextLabel(
          text: '${totalCharging}',
          fontSize: Utilities.sizeFontWithDesityForDisplay(
              context, AppFontSize.little),
          color: totalCharging > 0 ? AppTheme.green : AppTheme.black60,
        ),
        TextLabel(
          text: '/',
          fontSize: Utilities.sizeFontWithDesityForDisplay(
              context, AppFontSize.little),
          color: AppTheme.black60,
        ),
        TextLabel(
          text: '${connector}',
          fontSize: Utilities.sizeFontWithDesityForDisplay(
              context, AppFontSize.little),
          color: AppTheme.black60,
        ),
      ]),
    );
  }

  Widget renderImage(String image) {
    return Container(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: sizeImageFleet,
                height: sizeImageFleet,
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: 1,
                    color: AppTheme.borderGray,
                  ),
                ),
                child: image != ''
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(11), // Image border
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(48), // Image radius
                          child: Image.network(
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Shimmer.fromColors(
                                baseColor: AppTheme.grayF1F5F9,
                                highlightColor: AppTheme.borderGray,
                                child: Container(
                                  height: 20,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                            },
                            image,
                          ),
                        ),
                      )
                    : SvgPicture.asset(
                        ImageAsset.logo_station,
                      ),
              ),
            ],
          ),
          Positioned(
            top: 4,
            left: 52,
            child:
                (showStatusCharging(checktype: FleetOperationStatus.CHARGING))
                    ? renderStatusCharging(connector: false, typeCharge: '')
                    : renderStatusReceiptAndReady(showStatusCharging(
                        checktype: FleetOperationStatus.RECEIPT)),
          ),
        ],
      ),
    );
  }

  Widget renderDivider(double top, double bottom) {
    return Container(
      width: double.infinity,
      height: 1,
      margin: EdgeInsets.only(top: top, bottom: bottom),
      color: AppTheme.borderGray,
    );
  }

  Widget renderStatusCharging(
      {bool connector = false, String typeCharge = ''}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        border: Border.all(width: 1, color: AppTheme.borderGray),
      ),
      child: ButtonProgress(
        visible: true,
        finish: false,
        borderWidth: 4,
        width: getWidth(context).toPXLength,
        height: getWidth(context).toPXLength,
        gradient: const SweepGradient(startAngle: pi, colors: [
          AppTheme.red,
          AppTheme.red,
        ]),
        onTap: () {},
        child: SvgPicture.asset(
          connector
              ? getIconTypeChargingFleet(typeCharge)
              : ImageAsset.ic_car_charging,
          color: AppTheme.red,
          width: getWidth(context) - (getWidth(context) / 2),
          height: getWidth(context) - (getWidth(context) / 2),
        ),
      ),
    );
  }

  Widget renderStatusReceiptAndReady(bool checkStatus) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Visibility(
            visible: checkStatus,
            child: ButtonProgress(
              visible: true,
              finish: true,
              borderWidth: 0,
              width: getWidth(context).toPXLength,
              height: getWidth(context).toPXLength,
              gradient: const SweepGradient(startAngle: pi, colors: [
                AppTheme.white,
                AppTheme.white,
              ]),
              onTap: () {},
              child: Image.asset(
                ImageAsset.ic_car_receipt,
                width: getWidth(context) - (getWidth(context) / 2),
                height: getWidth(context) - (getWidth(context) / 2),
              ),
            )));
  }
}
