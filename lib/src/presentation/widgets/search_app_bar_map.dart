import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter_api/domain/entities/finding_station_entity.dart';

import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/map/widgets/modal_filter.dart';
import 'package:jupiter/src/presentation/widgets/custom_station_search/custom_station_search.dart';
import 'package:jupiter/src/presentation/widgets/text_input_form.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class SearchAppBarMap extends StatefulWidget {
  SearchAppBarMap(
      {super.key,
      required this.isButton,
      required this.search,
      required this.focus,
      this.stationText,
      this.onChanged,
      this.onPressed,
      this.searchController,
      this.onChangedApply,
      this.onchangeReset,
      this.onchangeAC,
      this.onchangeDC,
      this.onchangeOpenServiceMap,
      this.isCheckedDistance,
      this.isCheckedOpenService,
      this.isCheckedChargerAvailable,
      this.isCheckedACCS1,
      this.isCheckedACCS2,
      this.isCheckedACCHAdeMO,
      this.isCheckedDCCS1,
      this.isCheckedDCCS2,
      this.isCheckedDCCHAdeMO,
      this.filterConnectorAC,
      this.filterConnectorDC,
      this.pageFilter = false,
      required this.isPermissionLocation,
      this.navigateSearchStation});

  final bool isButton;
  final bool search;
  final FocusNode focus;
  final Function(String?)? onChanged;
  final Function()? onPressed;
  final String? stationText;
  final TextEditingController? searchController;
  final Function(
      bool? openService,
      bool? chargerAvailble,
      bool? distance,
      bool? accs1,
      bool? accs2,
      bool? ACCHAdeMO,
      bool? dccs1,
      bool? dccs2,
      bool? dcCHAdeMO)? onChangedApply;
  final Function()? onchangeReset;
  final Function(bool?)? onchangeAC;
  final Function(bool?)? onchangeDC;
  final Function(bool?)? onchangeOpenServiceMap;
  final bool? isCheckedDistance;
  final bool? isCheckedOpenService;
  final bool? isCheckedChargerAvailable;
  final bool? isCheckedACCS1;
  final bool? isCheckedACCS2;
  final bool? isCheckedACCHAdeMO;
  final bool? isCheckedDCCS1;
  final bool? isCheckedDCCS2;
  final bool? isCheckedDCCHAdeMO;

  final List<String?>? filterConnectorAC;
  final List<String?>? filterConnectorDC;
  final bool? pageFilter;
  final bool isPermissionLocation;
  final Function(BuildContext)? navigateSearchStation;

  @override
  State<StatefulWidget> createState() => _SearchAppBarMapState();
}

class _SearchAppBarMapState extends State<SearchAppBarMap> {
  // final searchController = TextEditingController();

  // List<SearchStationEntity>? _stationList = List.empty(growable: true);
  // List<SearchStationEntity>? _stationListFull = List.empty(growable: true);
  FindingStationEntity? findingStationEntity;

  // String? _searchText = '';

  List<filterStation> filterFindStation = [
    filterStation(
        filterName: '', filterImg: ImageAsset.filter, filterSelect: false),
    filterStation(
        filterName: 'AC', filterImg: ImageAsset.ic_ac, filterSelect: false),
    filterStation(
        filterName: 'DC', filterImg: ImageAsset.ic_dc, filterSelect: false),
    filterStation(
        filterName: 'Open for service',
        filterImg: ImageAsset.ic_open_service,
        filterSelect: false),
  ];

  EdgeInsets paddingButton = EdgeInsets.fromLTRB(16, 0, 16, 0);
  EdgeInsets paddingIsNotButton = EdgeInsets.fromLTRB(16, 40, 16, 0);

  EdgeInsets marginButton = EdgeInsets.only(top: Platform.isIOS ? 55 : 45);
  EdgeInsets marginIsNotButton = EdgeInsets.all(0);
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();

  Future<void> _navigateCustomStationSearch(context) async {
    widget.focus.hasFocus;
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CustomStationSearch(title: translate('map_page.title'));
    }));
    if (jupiterPrefsAndAppData.navigateRoutePlanner) {
      (widget.navigateSearchStation ?? () {})(context);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: widget.isButton ? marginButton : marginIsNotButton,
      padding: widget.isButton ? paddingButton : paddingIsNotButton,
      // height: _useSize,
      child: Column(children: [
        widget.search
            ? Expanded(
                child: TextInputForm(
                  autofocus: true,
                  contentPadding: const EdgeInsets.only(top: 8),
                  borderRadius: 200,
                  style: const TextStyle(color: AppTheme.black60),
                  icon: IconButton(
                    splashColor: AppTheme.transparent,
                    icon: Icon(Icons.arrow_back),
                    color: AppTheme.gray9CA3AF,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  fillColor: AppTheme.white,
                  controller: widget.searchController,
                  hintText: translate("appbar.search"),
                  hintStyle: TextStyle(
                    color: AppTheme.black60,
                    fontSize: Utilities.sizeFontWithDesityForDisplay(
                        context, AppFontSize.large),
                  ),
                  obscureText: false,
                  // suffixText: translate("appbar.suffix_cancel"),
                  suffixIcon: widget.focus.hasFocus
                      ? IconButton(
                          splashColor: AppTheme.transparent,
                          icon: Icon(Icons.close),
                          color: AppTheme.gray9CA3AF,
                          onPressed: widget.onPressed,
                          // onPressed: () {
                          //   widget.focus.unfocus();

                          //   searchController.text = '';
                          //   _stationList = _stationListFull;
                          // },
                        )
                      : const SizedBox(),
                  onSaved: (text) {},
                  keyboardType: TextInputType.text,
                  onChanged: widget.onChanged,
                  focusNode: widget.focus,
                  onFieldSubmitted: widget.onChanged,
                  validator: (text) {
                    if (text == null || text == "") {
                      return "required field!";
                    } else {
                      return '';
                    }
                  },
                ),
              )
            : Container(
                height: 48,
                child: ElevatedButton(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        ImageAsset.ic_charger_station,
                        width: 36,
                        height: 36,
                        colorFilter:
                            ColorFilter.mode(AppTheme.blueD, BlendMode.srcIn),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextLabel(
                        text: translate("appbar.search"),
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.large),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200),
                    ),
                  ),
                  onPressed: () {
                    _navigateCustomStationSearch(context);
                  },
                ),
              ),
        Container(
          // padding: EdgeInsets.only(top: 12, bottom: 2),
          height: 60,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: filterFindStation.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (BuildContext context, int index) {
              filterStation? findStation = filterFindStation[index];
              _onCheckBoxFilter(findStation);

              return InkWell(
                focusColor: AppTheme.transparent,
                highlightColor: AppTheme.transparent,
                hoverColor: AppTheme.transparent,
                splashColor: AppTheme.transparent,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: (findStation.filterSelect)
                          ? AppTheme.blueD
                          : AppTheme.white,
                      border: Border.all(
                          color: (findStation.filterSelect)
                              ? AppTheme.blueD
                              : AppTheme.grayF1F5F9,
                          width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(200)),
                      boxShadow: [
                        widget.search
                            ? BoxShadow(
                                color: AppTheme.gray9CA3AF,
                                blurRadius: 0,
                                offset: Offset(0, 0),
                              )
                            : BoxShadow(
                                color: AppTheme.gray9CA3AF,
                                blurRadius: 1,
                                offset: Offset(1, 2),
                              ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          findStation.filterImg,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                              (findStation.filterSelect)
                                  ? AppTheme.white
                                  : AppTheme.gray9CA3AF,
                              BlendMode.srcIn),
                        ),
                        findStation.filterName != ''
                            ? Row(
                                children: [
                                  const SizedBox(width: 10),
                                  TextLabel(
                                    text: findStation.filterName,
                                    color: (findStation.filterSelect)
                                        ? AppTheme.white
                                        : AppTheme.gray9CA3AF,
                                    fontSize:
                                        Utilities.sizeFontWithDesityForDisplay(
                                            context, AppFontSize.normal),
                                  ),
                                ],
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  _onFilter(findStation);
                },
              );
            },
          ),
        ),
      ]

          // shape: const RoundedRectangleBorder(
          //   borderRadius: BorderRadius.vertical(
          //     bottom: Radius.circular(25),
          //   ),
          // ),
          // centerTitle: true,
          ),
    );
  }

  _onFilter(filterStation? findStation) {
    widget.focus.unfocus();
    switch (findStation!.filterName) {
      case 'Open for service':
        if (findStation.filterSelect) {
          findStation.filterSelect = false;
        } else {
          findStation.filterSelect = true;
        }
        return widget.onchangeOpenServiceMap!(findStation.filterSelect);
      case 'AC':
        if (findStation.filterSelect) {
          findStation.filterSelect = false;
        } else {
          findStation.filterSelect = true;
          var foundName = filterFindStation
              .indexWhere((element) => element.filterName == 'DC');
          if (foundName >= 0) {
            filterFindStation[foundName].filterSelect = false;
          }
        }
        return widget.onchangeAC!(findStation.filterSelect);
      case 'DC':
        if (findStation.filterSelect) {
          findStation.filterSelect = false;
        } else {
          findStation.filterSelect = true;
          var foundName = filterFindStation
              .indexWhere((element) => element.filterName == 'AC');
          if (foundName >= 0) {
            filterFindStation[foundName].filterSelect = false;
          }
        }

        return widget.onchangeDC!(findStation.filterSelect);
      default:
        return showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
          builder: (BuildContext context) {
            return ModalFilter(
              onChangedApply: widget.onChangedApply,
              onchangeReset: widget.onchangeReset,
              isCheckedDistance: widget.isCheckedDistance,
              isCheckedOpenService: widget.isCheckedOpenService,
              isCheckedChargerAvailable: widget.isCheckedChargerAvailable,
              isCheckedACCS1: widget.isCheckedACCS1,
              isCheckedACCS2: widget.isCheckedACCS2,
              isCheckedACCHAdeMO: widget.isCheckedACCHAdeMO,
              isCheckedDCCS1: widget.isCheckedDCCS1,
              isCheckedDCCS2: widget.isCheckedDCCS2,
              isCheckedDCCHAdeMO: widget.isCheckedDCCHAdeMO,
              isPermissionLocation: widget.isPermissionLocation,
            );
          },
        );
    }
  }

  _onCheckBoxFilter(filterStation findStation) {
    switch (findStation.filterName) {
      case 'Open for service':
        if (widget.isCheckedOpenService == true) {
          findStation.filterSelect = true;
        } else {
          findStation.filterSelect = false;
        }
        break;
      case 'AC':
        if (widget.isCheckedACCS1 == true ||
            widget.isCheckedACCS2 == true ||
            widget.isCheckedACCHAdeMO == true) {
          if (widget.isCheckedDCCS1 == true ||
              widget.isCheckedDCCS2 == true ||
              widget.isCheckedDCCHAdeMO == true) {
            findStation.filterSelect = false;
            filterFindStation[2].filterSelect = false;
          } else {
            findStation.filterSelect = true;
          }
        } else {
          findStation.filterSelect = false;
        }
        break;
      case 'DC':
        if (widget.isCheckedDCCS1 == true ||
            widget.isCheckedDCCS2 == true ||
            widget.isCheckedDCCHAdeMO == true) {
          findStation.filterSelect = true;
          if (widget.isCheckedACCS1 == true ||
              widget.isCheckedACCS2 == true ||
              widget.isCheckedACCHAdeMO == true) {
            findStation.filterSelect = false;
            filterFindStation[1].filterSelect = false;
          } else {
            findStation.filterSelect = true;
          }
        } else {
          findStation.filterSelect = false;
        }
        break;
      case '':
        if (widget.isCheckedDistance == true ||
            widget.isCheckedChargerAvailable == true ||
            ((widget.isCheckedACCS1 == true ||
                        widget.isCheckedACCS2 == true ||
                        widget.isCheckedACCHAdeMO == true) ==
                    true &&
                (widget.isCheckedDCCS1 == true ||
                        widget.isCheckedDCCS2 == true ||
                        widget.isCheckedDCCHAdeMO == true) ==
                    true)) {
          findStation.filterSelect = true;
        } else {
          findStation.filterSelect = false;
        }
        break;
      default:
        break;
    }
  }
}

class filterStation {
  String filterName;
  String filterImg;
  bool filterSelect;

  filterStation(
      {required this.filterName,
      required this.filterImg,
      required this.filterSelect});
}
