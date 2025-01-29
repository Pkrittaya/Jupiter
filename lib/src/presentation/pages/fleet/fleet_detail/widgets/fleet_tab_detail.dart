import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/pages/fleet/cubit/fleet_cubit.dart';
import 'package:jupiter/src/presentation/widgets/text_input_form.dart';
import 'package:jupiter_api/domain/entities/fleet_card_station_item_entity.dart';
import 'package:jupiter_api/domain/entities/fleet_operation_station_item_entity.dart';
import 'package:jupiter_api/domain/entities/history_fleet_entity.dart';
import 'package:jupiter_api/domain/entities/llst_station_fleet_card_entity.dart';
import 'package:jupiter_api/domain/entities/llst_station_fleet_operation_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/fleet/fleet_detail/widgets/fleet_history_item.dart';
import 'package:jupiter/src/presentation/pages/fleet/fleet_detail/widgets/fleet_station_item.dart';
import 'package:jupiter/src/presentation/widgets/modal_select_list.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FleetTabDetail extends StatefulWidget {
  const FleetTabDetail({
    Key? key,
    required this.fleetType,
    required this.loading,
    required this.selectedTab,
    required this.fleetCardStation,
    required this.fleetOperationStation,
    required this.fleetNo,
    required this.onPressedConnector,
    required this.historyList,
    required this.closeExpandedStation,
  }) : super(key: key);

  final String fleetType;
  final bool loading;
  final int selectedTab;
  final ListStationFleetCardEntity? fleetCardStation;
  final ListStationFleetOperationEntity? fleetOperationStation;
  final int fleetNo;
  final Function(String, String, String, int, bool, bool, String)
      onPressedConnector;
  final List<HistoryFleetDataEntity>? historyList;
  final bool closeExpandedStation;
  @override
  _FleetTabDetailState createState() => _FleetTabDetailState();
}

class _FleetTabDetailState extends State<FleetTabDetail> {
  static const String FILTERALL = 'All';
  static const String FILTERCHARGING = 'Charging';
  static const String FILTERAVAILABLE = 'Available';

  int indexMonth = 0;
  String beforeMonth = '';
  int beforeIndexMonth = 0;

  TextEditingController controllerMonth = TextEditingController();

  List<dynamic> monthList = List.empty(growable: true);
  List<HistoryFleetDataEntity> historyList = List.empty(growable: true);
  List<HistoryFleetDataEntity> historyAllList = List.empty(growable: true);

  // filter & search station
  FocusNode focusSearchStation = FocusNode();
  TextEditingController searchControl = TextEditingController();
  String selectFilter = FILTERALL;
  List<FleetCardStationItemEntity>? fleetCardStationList =
      List.empty(growable: true);
  List<FleetOperationStationItemEntity>? fleetOperationStationList =
      List.empty(growable: true);
  GlobalKey<State<StatefulWidget>> keySearchStation =
      GlobalKey<State<StatefulWidget>>();
  String isExpandedStation = '';

  String getTextMonthFromTextController() {
    if (controllerMonth.text == monthList[0]['value']) {
      return monthList[0]['text'];
    } else {
      return monthList[indexMonth]['text'];
    }
  }

  String getTextButtonForFiltter({required int index, bool typeText = true}) {
    String text = '';
    String value = '';
    if (widget.fleetType == FleetType.CARD) {
      switch (index) {
        case 0:
          text = translate('fleet_page.detail.filter.all');
          value = FILTERALL;
          break;
        case 1:
          text = translate('fleet_page.detail.filter.available');
          value = FILTERAVAILABLE;
          break;
        default:
          break;
      }
    } else if (widget.fleetType == FleetType.OPERATION) {
      switch (index) {
        case 0:
          text = translate('fleet_page.detail.filter.all');
          value = FILTERALL;
          break;
        case 1:
          text = translate('fleet_page.detail.filter.charging');
          value = FILTERCHARGING;
          break;
        case 2:
          text = translate('fleet_page.detail.filter.available');
          value = FILTERAVAILABLE;
          break;
        default:
          break;
      }
    }
    if (typeText) {
      return text;
    } else {
      return value;
    }
  }

  void getHistoryForMonthToList() {
    String textFilterMonth = '';
    if (controllerMonth.text == '') {
      textFilterMonth = monthList[0]['value'];
    } else {
      textFilterMonth = controllerMonth.text;
    }
    /** Filter History **/
    historyList = historyAllList
        .where((item) =>
            ('${DateFormat.MMM().format(DateTime.parse(item.timeStamp).toLocal())} ${DateTime.parse(item.timeStamp).toLocal().year}' ==
                textFilterMonth) &&
            (item.timeStamp != ''))
        .toList();
    /** Filter History **/
  }

  void getListMonth() {
    /** Make Month **/
    for (var i = 0; i < 12; i++) {
      var monthNumber = (DateTime.now().month - i);
      var monthDate = DateFormat.M().parse(
          (monthNumber < 1 ? 12 - (-monthNumber) : monthNumber).toString());
      var year = DateTime.now().month - i < 1
          ? DateTime.now().year - 1
          : DateTime.now().year;
      var month = DateFormat.MMM().format(monthDate);
      monthList.add({
        'value': '$month $year',
        'text': '$month $year',
      });
    }
    /** Make Month **/
  }

  void initialMonth() {
    FocusScope.of(context).unfocus();
    if (controllerMonth.text == '') {
      beforeMonth = monthList[0]['value'];
      indexMonth = 0;
    } else {
      beforeMonth = controllerMonth.text;
      indexMonth = indexMonth;
    }
  }

  void onChangeMonth(int index) {
    beforeMonth = monthList[index]['value'];
    beforeIndexMonth = index;
  }

  void onDoneModalMonth() {
    controllerMonth.text = beforeMonth;
    indexMonth = beforeIndexMonth;
    if (controllerMonth.text == '') {
      beforeMonth = monthList[0]['value'];
      controllerMonth.text = beforeMonth;
      indexMonth = 0;
    }
    getHistoryForMonthToList();
    setState(() {});
    Navigator.of(context).pop();
  }

  void onFilterStation(List<FleetCardStationItemEntity>? fleetCard,
      List<FleetOperationStationItemEntity>? fleetOperation) {
    switch (selectFilter) {
      case FILTERALL:
        if (widget.fleetType == FleetType.CARD) {
          fleetCardStationList = fleetCard;
        }
        if (widget.fleetType == FleetType.OPERATION) {
          fleetOperationStationList = fleetOperation;
        }
        break;
      case FILTERCHARGING:
        if (widget.fleetType == FleetType.CARD) {
          fleetCardStationList = fleetCard;
        }
        if (widget.fleetType == FleetType.OPERATION) {
          try {
            fleetOperationStationList = fleetOperation!.where((element) {
              return element.statusCharging == FleetOperationStatus.CHARGING;
            }).toList();
          } catch (e) {
            fleetOperationStationList = [];
          }
        }
        break;
      case FILTERAVAILABLE:
        if (widget.fleetType == FleetType.CARD) {
          try {
            fleetCardStationList = fleetCardStationList!.where((element) {
              return element.connectorAvailable > 0;
            }).toList();
          } catch (e) {
            fleetCardStationList = [];
          }
        }
        if (widget.fleetType == FleetType.OPERATION) {
          try {
            fleetOperationStationList = fleetOperation!.where((element) {
              return element.connectorAvailable > 0;
            }).toList();
          } catch (e) {
            fleetOperationStationList = [];
          }
        }
        break;
      default:
        break;
    }
    onSearchStation(searchControl.text, 'search');
  }

  void onSearchStation(String text, String type) {
    /****************** CARD *******************/
    if (widget.fleetType == FleetType.CARD) {
      if (text == '') {
        fleetCardStationList = fleetCardStationList;
        searchControl.text = '';
        if (type == 'clear') {
          focusSearchStation.unfocus();
        }
      } else {
        try {
          fleetCardStationList = fleetCardStationList!.where((element) {
            return element.stationName
                .toLowerCase()
                .contains(text.toLowerCase());
          }).toList();
        } catch (e) {
          fleetCardStationList = [];
        }
      }
    }
    /****************** OPERATION *******************/
    if (widget.fleetType == FleetType.OPERATION) {
      if (text == '') {
        fleetOperationStationList = fleetOperationStationList;
        searchControl.text = '';
        if (type == 'clear') {
          focusSearchStation.unfocus();
        }
      } else {
        try {
          fleetOperationStationList =
              fleetOperationStationList!.where((element) {
            return element.stationName
                .toLowerCase()
                .contains(text.toLowerCase());
          }).toList();
        } catch (e) {
          fleetOperationStationList = [];
        }
      }
    }
    /****************** END *******************/
    setState(() {});
  }

  void isExpanded(String id, bool expand) {
    if (expand) {
      isExpandedStation = '';
      setState(() {});
    } else {
      isExpandedStation = id;
      if (widget.fleetType == FleetType.CARD) {
        BlocProvider.of<FleetCubit>(context)
            .fetchFleetCardCharger(fleetNo: widget.fleetNo, stationId: id);
      }
      if (widget.fleetType == FleetType.OPERATION) {
        BlocProvider.of<FleetCubit>(context)
            .fetchFleetOperationCharger(fleetNo: widget.fleetNo, stationId: id);
      }
    }
  }

  void whenComplete() {
    setState(() {});
  }

  @override
  void initState() {
    getListMonth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fleetType == FleetType.CARD) {
      if (widget.selectedTab == 0) {
        return renderFleetCardChargingStation();
      } else if (widget.selectedTab == 1) {
        return renderFleetCardHistory();
      } else
        return SizedBox();
    } else if (widget.fleetType == FleetType.OPERATION) {
      if (widget.selectedTab == 0) {
        return renderFleetOperationChargingStation();
      } else if (widget.selectedTab == 1) {
        return renderFleetOperationHistory();
      } else
        return SizedBox();
    } else
      return SizedBox();
  }

  Widget renderFleetCardChargingStation() {
    return Column(
      children: [
        renderSearchStation(),
        renderListStation(),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget renderFleetCardHistory() {
    return Column(
      children: [
        renderWhiteSpace(),
        renderTitleChargingStation(),
        renderListHistory(),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget renderFleetOperationChargingStation() {
    return Column(
      children: [
        renderSearchStation(),
        renderListStation(),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget renderFleetOperationHistory() {
    return Column(
      children: [
        renderWhiteSpace(),
        renderTitleChargingStation(),
        renderListHistory(),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget renderWhiteSpace() {
    return Container(
      width: double.infinity,
      height: 12,
      color: AppTheme.grayF1F5F9,
    );
  }

  Widget renderTitleChargingStation() {
    return Container(
      color: AppTheme.white,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextLabel(
            text: translate('fleet_page.tab.transaction_of'),
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.big),
            color: AppTheme.gray9CA3AF,
            fontWeight: FontWeight.bold,
          ),
          Material(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(200),
            child: InkWell(
              borderRadius: BorderRadius.circular(200),
              onTap: () {
                if (!widget.loading) {
                  initialMonth();
                  showModalBottomSheet(
                    context: context,
                    // enableDrag: false,
                    // isDismissible: false,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12))),
                    builder: (BuildContext context) {
                      return ModalSelectList(
                        type: 'MONTH',
                        listItem: monthList,
                        initialIndex: indexMonth,
                        onChange: onChangeMonth,
                        onDoneModal: onDoneModalMonth,
                      );
                    },
                  ).whenComplete(whenComplete);
                }
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 4, 4, 4),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppTheme.borderGray),
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Row(
                  children: [
                    TextLabel(
                      text: controllerMonth.text != ''
                          ? getTextMonthFromTextController()
                          : monthList[0]['text'],
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.big),
                      color: AppTheme.gray9CA3AF,
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.keyboard_arrow_down, color: AppTheme.gray9CA3AF),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget renderListHistory() {
    List<Widget> items = [];
    historyAllList = widget.historyList ?? [];
    historyAllList.sort((a, b) => b.transactionId.compareTo(a.transactionId));
    historyAllList =
        historyAllList.where((item) => (item.timeStamp != '')).toList();
    getHistoryForMonthToList();
    if (widget.loading) {
      return Container(
        color: AppTheme.white,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                height: 0,
                color: AppTheme.black5,
              ),
            );
          },
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Skeletonizer(
              enabled: true,
              child: Container(
                padding: EdgeInsets.fromLTRB(4, 8, 4, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Bone.circle(size: 36),
                    const SizedBox(width: 10, height: 44),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Bone.text(
                          words: 2,
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context,
                            AppFontSize.mini,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Bone.text(
                          words: 1,
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context,
                            8,
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: const SizedBox()),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Bone.text(words: 1),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    } else {
      if (historyList.length > 0) {
        for (int i = 0; i < historyList.length; i++) {
          final item = historyList[i];
          items.add(FleetHistoryItem(
            fleetType: widget.fleetType,
            data: item,
          ));
        }
        return Container(
          color: AppTheme.white,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Column(
            children: items,
          ),
        );
      } else {
        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageAsset.img_default_empty,
                width: 100,
                height: 100,
              ),
              TextLabel(
                text: translate('empty.history'),
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.superlarge),
                color: AppTheme.black40,
              ),
            ],
          ),
        );
      }
    }
  }

  Widget renderListStation() {
    List<FleetStationItem> stationWidget = [];
    if (widget.closeExpandedStation) {
      isExpandedStation = '';
      selectFilter = 'All';
      searchControl.text = '';
    }
    if (widget.fleetType == FleetType.CARD) {
      onFilterStation(widget.fleetCardStation?.station, null);
      for (int i = 0; i < (fleetCardStationList?.length ?? 0); i++) {
        stationWidget.add(FleetStationItem(
          isFirstItem: i == 0,
          fleetType: widget.fleetType,
          data: fleetCardStationList?[i] ?? null,
          fleetNo: widget.fleetNo,
          onPressedConnector: (
            String connectorCode,
            String chargerId,
            String connectorId,
            int connectorIndex,
            bool statusCharging,
            bool statusReceipt,
            String chargingType,
          ) {},
          isExpanded: (isExpandedStation == fleetCardStationList?[i].stationId)
              ? true
              : false,
          funcExpanded: isExpanded,
        ));
      }
    }
    if (widget.fleetType == FleetType.OPERATION) {
      onFilterStation(null, widget.fleetOperationStation?.station);
      for (int i = 0; i < (fleetOperationStationList?.length ?? 0); i++) {
        stationWidget.add(FleetStationItem(
          isFirstItem: i == 0,
          fleetType: widget.fleetType,
          data: fleetOperationStationList?[i] ?? null,
          fleetNo: widget.fleetNo,
          onPressedConnector: widget.onPressedConnector,
          isExpanded:
              (isExpandedStation == fleetOperationStationList?[i].stationId)
                  ? true
                  : false,
          funcExpanded: isExpanded,
        ));
      }
    }

    return widget.loading
        ? Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
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
            child: Skeletonizer(
              child: Container(
                padding: EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Bone.square(
                      size: 80,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    const SizedBox(width: 28),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Bone.text(words: 2),
                        const SizedBox(height: 8),
                        Container(
                          width: 60,
                          height: 24,
                          child: Bone.square(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: stationWidget.length > 0
                  ? stationWidget
                  : [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              ImageAsset.img_map_empty,
                              width: 50,
                              height: 50,
                            ),
                            const SizedBox(height: 8),
                            TextLabel(
                              text: translate('empty.history'),
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.big),
                              color: AppTheme.black40,
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      )
                    ],
            ),
          );
  }

  Widget renderSearchStation() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(children: [
        // Search station
        Container(
          height: 48,
          child: TextInputForm(
            key: keySearchStation,
            contentPadding: const EdgeInsets.all(0),
            borderRadius: 200,
            style: const TextStyle(color: AppTheme.black60),
            icon: Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              child: SvgPicture.asset(
                ImageAsset.ic_charger_station,
                height: 30,
                width: 30,
                colorFilter: ColorFilter.mode(AppTheme.blueD, BlendMode.srcIn),
              ),
            ),
            fillColor: AppTheme.white,
            controller: searchControl,
            hintText: translate("appbar.search"),
            hintStyle: TextStyle(
              color: AppTheme.black60,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.large),
            ),
            obscureText: false,
            suffixIcon: focusSearchStation.hasFocus
                ? IconButton(
                    splashColor: AppTheme.transparent,
                    icon: Icon(Icons.close),
                    color: AppTheme.gray9CA3AF,
                    onPressed: () => onSearchStation('', 'clear'),
                  )
                : const SizedBox(),
            keyboardType: TextInputType.text,
            onChanged: (text) => onSearchStation(text ?? '', 'search'),
            focusNode: focusSearchStation,
            onFieldSubmitted: (text) => onSearchStation(text ?? '', 'search'),
            onTap: () {
              Utilities.ensureVisibleOnTextInput(
                  textfieldKey: keySearchStation);
            },
          ),
        ),
        // Filter station
        Container(
          height: 60,
          alignment: Alignment.centerLeft,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: (widget.fleetType == FleetType.CARD) ? 2 : 3,
            separatorBuilder: (context, index) => const SizedBox(width: 7),
            itemBuilder: (BuildContext context, int index) {
              String text =
                  getTextButtonForFiltter(index: index, typeText: true);
              String value =
                  getTextButtonForFiltter(index: index, typeText: false);
              return InkWell(
                focusColor: AppTheme.transparent,
                highlightColor: AppTheme.transparent,
                hoverColor: AppTheme.transparent,
                splashColor: AppTheme.transparent,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                      color: (selectFilter == value)
                          ? AppTheme.blueD
                          : AppTheme.white,
                      border: Border.all(
                          color: (selectFilter == value)
                              ? AppTheme.blueD
                              : AppTheme.grayF1F5F9,
                          width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(200)),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.gray9CA3AF,
                          blurRadius: 0,
                          offset: Offset(0, 0),
                        )
                      ],
                    ),
                    child: TextLabel(
                      text: text,
                      color: (selectFilter == value)
                          ? AppTheme.white
                          : AppTheme.gray9CA3AF,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                        context,
                        AppFontSize.normal,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: () {
                  if (!widget.loading) {
                    setState(() {
                      selectFilter = value;
                      isExpandedStation = '';
                    });
                  }
                },
              );
            },
          ),
        ),
      ]),
    );
  }
}
