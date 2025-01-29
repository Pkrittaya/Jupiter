import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter_api/domain/entities/finding_station_entity.dart';
import 'package:jupiter_api/domain/entities/search_station_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/custom_app_bar_with_search/cubit/custom_app_bar_with_search_cubit.dart';
import 'package:jupiter/src/presentation/widgets/text_input_form.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import '../../../apptheme.dart';
import '../../../injection.dart';
import '../../../utilities.dart';
import 'widgets/station_search_item.dart';

class CustomAppBarwithSearchWrapperProvider extends StatelessWidget {
  const CustomAppBarwithSearchWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CustomAppBarWithSearchCubit>(),
      child: CustomAppBarWithSearch(
        appBarHeight: 56,
        title: '',
      ),
    );
  }
}

class CustomAppBarWithSearch extends StatefulWidget {
  const CustomAppBarWithSearch(
      {super.key,
      required this.appBarHeight,
      required this.title,
      this.enableSearch = false,
      this.listSearchHeight = 0.0});
  final double appBarHeight;
  final String title;
  final bool enableSearch;
  final double listSearchHeight;

  @override
  State<StatefulWidget> createState() => _CustomAppBarWithSearchState();
}

class _CustomAppBarWithSearchState extends State<CustomAppBarWithSearch> {
  final searchController = TextEditingController();
  final FocusNode _focus = FocusNode();
  bool _listViewVisible = false;
  late double _useSize;
  late Position _currentLocation;
  FindingStationEntity? findingStationEntity;
  bool loadingVisible = false;
  EdgeInsets? viewInsets;
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  @override
  void initState() {
    super.initState();
    _useSize = widget.appBarHeight;
    _focus.addListener(_onFocusChange);
    debugPrint("heightTest ${widget.appBarHeight}");
    debugPrint("heightTest ${widget.listSearchHeight}");
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
    ));
  }

  List<SearchStationEntity>? _stationList = List.empty(growable: true);
  List<SearchStationEntity>? _stationListFull = List.empty(growable: true);

  String? _searchText = '';

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void findStationAll() async {
    _currentLocation = await Utilities.getUserCurrentLocation();
    BlocProvider.of<CustomAppBarWithSearchCubit>(context)
        .findStation(_currentLocation.latitude, _currentLocation.longitude);
  }

  void filterListStation(String? searchText) async {
    List<String> selectedFilter =
        (jupiterPrefsAndAppData.filterMapList) ?? List.empty(growable: true);
    debugPrint("FilterListLoad $selectedFilter");
    selectedFilter = selectedFilter.map((item) => item.toLowerCase()).toList();
    selectedFilter.remove("SEARCH_AVALIABLE_ON".toLowerCase());
  }

  void actionCustomAppBarWithSearchLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingVisible) {
        setState(() {
          loadingVisible = true;
        });
      }
    });
  }

  void actionFindingStationSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      findingStationEntity = state.findingStationEntity;
      // if (_searchText == '') {
      // Utilities.getFilterMapList().then((list) {
      //   List<String> selectedFilter =
      //       list?.map((item) => item.toLowerCase()).toList() ??
      //           List.empty(growable: true);
      //   selectedFilter.remove("SEARCH_AVALIABLE_ON".toLowerCase());
      //   final filtered = findingStationEntity?.stationList
      //       .where((element) => selectedFilter.isNotEmpty
      //           ? element.connectorType.any((type) =>
      //               selectedFilter.contains(type.toLowerCase()))
      //           : true)
      //       .toList();
      //   setState(() {
      //     _stationList = filtered;
      //     _stationListFull = filtered;
      //     loadingVisible = false;
      //   });
      // });
      // }
    });
  }

  void actionFindingStationFailure() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingVisible) {
        setState(() {
          loadingVisible = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("heightTest useSize ${_useSize}");
    var sizeMedia = MediaQuery.of(context).size;
    viewInsets = EdgeInsets.fromWindowPadding(
        WidgetsBinding.instance.window.viewInsets,
        WidgetsBinding.instance.window.devicePixelRatio);
    debugPrint("ViewInsetCustomAppbar  ${viewInsets?.bottom}");
    return BlocListener<CustomAppBarWithSearchCubit,
        CustomAppBarWithSearchState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case CustomAppBarWithSearchLoading:
            actionCustomAppBarWithSearchLoading();
            break;
          case FindingStationSuccess:
            actionFindingStationSuccess(state);
            break;
          case FindingStationFailure:
            actionFindingStationFailure();
            break;
          default:
            actionFindingStationFailure();
            break;
        }
      },
      child: Container(
        color: AppTheme.transparent,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 56, 16, 16),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(25),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppTheme.darkBlue,
                        AppTheme.lightBlue,
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: TextLabel(
                          color: AppTheme.white,
                          text: widget.title,
                          fontWeight: FontWeight.bold,
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, 24),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(children: [
                        Expanded(
                          flex: 85,
                          child: TextInputForm(
                            style: const TextStyle(color: AppTheme.black60),
                            icon: const Icon(
                              Icons.search,
                              color: AppTheme.lightBlue,
                            ),
                            fillColor: AppTheme.white,
                            controller: searchController,
                            hintText: translate("appbar.search"),
                            hintStyle: TextStyle(
                              color: AppTheme.black60,
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, 18),
                            ),
                            obscureText: false,
                            suffixIcon: _focus.hasFocus
                                ? TextButton(
                                    onPressed: () {
                                      _focus.unfocus();
                                      searchController.text = '';
                                      _stationList = _stationListFull;
                                    },
                                    child: TextLabel(
                                      text: translate("appbar.suffix_cancel"),
                                      fontSize: Utilities
                                          .sizeFontWithDesityForDisplay(
                                              context, 18),
                                      color: AppTheme.black,
                                    ),
                                  )
                                : const SizedBox(),
                            onSaved: (text) {},
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              debugPrint("OnChange SearchStation $value");
                              _searchText = value;
                              filterListStation(value);
                            },
                            focusNode: _focus,
                            validator: (text) {
                              if (text == null || text == "") {
                                return "required field!";
                              } else {
                                return '';
                              }
                            },
                          ),
                        ),
                        Expanded(
                            flex: 15,
                            child: IconButton(
                              splashColor: AppTheme.white,
                              splashRadius: 3,
                              color: AppTheme.white,
                              icon: SvgPicture.asset(
                                ImageAsset.filter,
                              ),
                              iconSize: 32,
                              onPressed: () {
                                debugPrint("filter press");
                                Scaffold.of(context).openEndDrawer();
                              },
                            ))
                      ]),
                    ],
                  ),
                ),
                Visibility(
                  visible: _listViewVisible,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: double.infinity,
                        color: AppTheme.white,
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: TextLabel(
                          text: "All Station",
                          color: AppTheme.darkBlue,
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, 20),
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
                _listViewVisible
                    ? Container(
                        padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                        height: widget.listSearchHeight -
                            (widget.appBarHeight + 53 + 53 + 282),
                        color: AppTheme.white,
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Divider(
                                color: AppTheme.black20,
                              ),
                            ),
                            itemBuilder:
                                (BuildContext context, int indexListView) {
                              SearchStationEntity? searchStationEntity =
                                  _stationList?[indexListView];

                              return StationSearchItem(
                                searchStationEntity: searchStationEntity,
                              );
                            },
                            itemCount: _stationList?.length ?? 0,
                          ),
                        ),
                      )
                    : Container(
                        color: AppTheme.lightBlue,
                      )
              ],
            ),
            Positioned(
              top: sizeMedia.height / 3,
              left: sizeMedia.width / 2,
              child: Visibility(
                visible: loadingVisible,
                child: const CircularProgressIndicator(
                  color: AppTheme.lightBlue,
                  strokeCap: StrokeCap.round,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onFocusChange() {
    if (_focus.hasFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _listViewVisible = _focus.hasFocus;
          _useSize = widget.listSearchHeight - (viewInsets?.bottom ?? 0);
        });
      });
      findStationAll();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _listViewVisible = _focus.hasFocus;
          _useSize = widget.appBarHeight;
        });
      });
    }
  }
}
