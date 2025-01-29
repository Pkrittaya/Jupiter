import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter/src/presentation/pages/map/cubit/map_cubit.dart';

import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/domain/entities/connector_type_entity.dart';

class FilterMapStation extends StatefulWidget {
  const FilterMapStation({super.key});

  @override
  State<FilterMapStation> createState() => _FilterMapStationState();
}

class _FilterMapStationState extends State<FilterMapStation> {
  // bool _switchSearchAvaliable = false;
  List<ConnectorTypeEntity>? filterMapType = List.empty(growable: true);
  List<String>? selectedFilter = List.empty(growable: true);
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  @override
  void initState() {
    super.initState();
    initValue();
    BlocProvider.of<MapCubit>(context).loadFilterMap();
  }

  initValue() async {
    final _selectedFilter = jupiterPrefsAndAppData.filterMapList;
    if (_selectedFilter != null) {
      selectedFilter =
          _selectedFilter.map((item) => item.toLowerCase()).toList();
    }
    debugPrint("InitFilterValue $selectedFilter");
  }

  @override
  Widget build(BuildContext context) {
    var sizeMedia = MediaQuery.of(context).size;
    for (var a in selectedFilter!) {
      debugPrint("IndexSelected  $a");
    }

    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        debugPrint("FilterMap : ${state.runtimeType}");
        switch (state.runtimeType) {
          case FilterLoading:
            break;
          case FilterLoadFailure:
            filterMapType = List.empty(growable: true);
            break;
          case FilterLoadSuccess:
            filterMapType = state.filterMapType;
            break;
          default:
            filterMapType = List.empty(growable: true);

            break;
        }
        debugPrint("FilterMap : ${filterMapType?.length}");
        return Container(
          padding: const EdgeInsets.all(16),
          width: sizeMedia.width - 100,
          height: sizeMedia.height,
          color: AppTheme.black5,
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                      child: TextButton(
                    onPressed: () {
                      Utilities.popNavigator(context);
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextLabel(
                        // text: "กลับ",
                        text: translate('map_page.map_filter.button.back'),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkBlue,
                      ),
                    ),
                  )),
                  Expanded(
                    child: Center(
                      child: TextLabel(
                        // text: "ตั้งค่า",
                        text: translate('map_page.map_filter.setting'),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkBlue,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              TextLabel(
                // text: "ค้นหาตามประเภทหัวชาร์จ",
                text: translate('map_page.map_filter.search_by_charger'),
              ),
              const SizedBox(
                height: 8,
              ),
              GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: (sizeMedia.width - 48) / 2,
                      childAspectRatio: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  itemCount: filterMapType?.length,
                  itemBuilder: (BuildContext ctx, indexGridView) {
                    ConnectorTypeEntity? connectorTypeEntity =
                        filterMapType?[indexGridView];

                    return FilterConnectorTypeItem(
                      filterType: connectorTypeEntity?.connectorType ?? '',
                      isSelected: selectedFilter?.contains(connectorTypeEntity
                                  ?.connectorType
                                  .toLowerCase() ??
                              '') ??
                          false,
                      isSelectedChange: (value) {
                        debugPrint(
                            "FilterSelected ${connectorTypeEntity?.connectorType ?? ''}");
                        if (value) {
                          selectedFilter?.add(connectorTypeEntity?.connectorType
                                  .toLowerCase() ??
                              '');
                        } else {
                          selectedFilter?.remove(connectorTypeEntity
                                  ?.connectorType
                                  .toLowerCase() ??
                              '');
                        }
                        setState(() {
                          selectedFilter = selectedFilter;
                        });
                      },
                    );
                  }),
              Row(
                children: [
                  Expanded(
                    child: TextLabel(
                      // text: "ค้นหาเฉพาะหัวชาร์จที่ว่าง",
                      text:
                          translate('map_page.map_filter.search_empty_charger'),
                    ),
                  ),
                  Switch(
                    value: selectedFilter
                            ?.contains("SEARCH_AVALIABLE_ON".toLowerCase()) ??
                        false, // _switchSearchAvaliable
                    onChanged: (value) {
                      if (value) {
                        selectedFilter
                            ?.remove("SEARCH_AVALIABLE_OFF".toLowerCase());
                        selectedFilter
                            ?.add("SEARCH_AVALIABLE_ON".toLowerCase());
                      } else {
                        selectedFilter
                            ?.remove("SEARCH_AVALIABLE_ON".toLowerCase());
                        // selectedFilter?.add("SEARCH_AVALIABLE_OFF");
                      }
                      setState(() {
                        // _switchSearchAvaliable = value;
                        selectedFilter = selectedFilter;
                      });
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                width: sizeMedia.width,
                height: 48,
                child: ElevatedButton(
                  style: AppTheme.darkBlueButtonStyle,
                  onPressed: () {
                    debugPrint("selectedFilter $selectedFilter");
                    jupiterPrefsAndAppData
                        .saveFilterMapList(selectedFilter ?? List.empty());
                    Utilities.popNavigator(context);
                  },
                  child: TextLabel(
                    // text: "บันทึก",
                    text: translate('map_page.map_filter.button.save'),
                    color: AppTheme.white,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class FilterConnectorTypeItem extends StatefulWidget {
  FilterConnectorTypeItem(
      {super.key,
      required this.isSelectedChange,
      this.isSelected = false,
      required this.filterType});
  final ValueChanged<bool> isSelectedChange;
  final bool isSelected;
  final String filterType;
  @override
  State<FilterConnectorTypeItem> createState() =>
      _FilterConnectorTypeItemState();
}

class _FilterConnectorTypeItemState extends State<FilterConnectorTypeItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      child: InkWell(
        onTap: () {
          debugPrint("Tap Filter ");
          widget.isSelectedChange(!widget.isSelected);
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color:
                      widget.isSelected ? AppTheme.lightBlue : AppTheme.white)),
          child: Center(
            child: TextLabel(
              text: widget.filterType,
            ),
          ),
        ),
      ),
    );
  }
}
