import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter/src/presentation/widgets/image_network_jupiter.dart';
import 'package:jupiter_api/domain/entities/connect_type_power_entity.dart';
import 'package:jupiter_api/domain/entities/recommended_station_entity.dart';
import 'package:jupiter_api/domain/entities/station_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/home/cubit/recommended_station_cubit.dart';
import 'package:jupiter/src/presentation/pages/station_details/station_details_page.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RecommendedStation extends StatefulWidget {
  const RecommendedStation({
    Key? key,
    required this.listStation,
    this.loading = false,
    required this.latitude,
    required this.longitude,
    required this.refreshRecommend,
    required this.onTapIndex,
    required this.onCheckClick,
  }) : super(key: key);

  final List<RecommendedStationEntity> listStation;
  final bool loading;
  final double latitude;
  final double longitude;
  final bool refreshRecommend;
  final Function(int) onTapIndex;
  final bool Function({bool check, bool click}) onCheckClick;

  @override
  State<RecommendedStation> createState() => _RecommendedStationState();
}

class _RecommendedStationState extends State<RecommendedStation> {
  bool stationNearMe = true;
  bool stationQuickCharge = false;
  ScrollController controller = ScrollController();
  StationEntity? stationItem;
  String imageConnector = '';

  bool openService = true;
  bool chargerAvailble = false;
  bool distance = false;
  List<String?> connectorAC = [];
  List<String?> connectorDC = [];
  String recommended = '';
  bool blankPage = true;

  void chooseFilterStation(String filter) {
    try {
      switch (filter) {
        case 'nearme':
          stationNearMe = true;
          distance = true;
          connectorDC = [];
          stationQuickCharge = false;
        case 'quickcharge':
          stationQuickCharge = true;
          distance = false;
          connectorDC = ["CS1", "CS2", "CHaDEMO"];
          stationNearMe = false;
        default:
          break;
      }

      SchedulerBinding.instance.addPostFrameCallback((_) async {
        widget.onCheckClick(check: false, click: false);
      });

      BlocProvider.of<RecommendedStationCubit>(context)
          .loadingRecommendedStation(openService, distance, connectorDC,
              widget.latitude, widget.longitude);
    } catch (e) {
      debugPrint('error: $e');
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        widget.onCheckClick(check: false, click: false);
      });
    }
  }

  _checkTypeConnector(connectPower, connectType) {
    switch (connectPower) {
      case 'AC':
        if (connectType == 'CS1') {
          imageConnector = ImageAsset.ic_ac_cs1;
        } else if (connectType == 'CS2') {
          imageConnector = ImageAsset.ic_ac_cs2;
        } else {
          imageConnector = ImageAsset.ic_ac_chadeMO;
        }
        break;
      case 'DC':
        if (connectType == 'CS1') {
          imageConnector = ImageAsset.ic_dc_cs1;
        } else if (connectType == 'CS2') {
          imageConnector = ImageAsset.ic_dc_cs2;
        } else {
          imageConnector = ImageAsset.ic_dc_chadeMO;
        }
        break;
      default:
        imageConnector = ImageAsset.ic_ac_chadeMO;
        break;
    }
    return imageConnector;
  }

  void _navigateMapPage(BuildContext context) async {
    if (stationNearMe) {
      recommended = 'nearMe';
    }
    if (stationQuickCharge) {
      recommended = 'quickCharge';
    }
    JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
    jupiterPrefsAndAppData.setFilterRecommendedToMap(recommended);

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      widget.onCheckClick(check: false, click: false);
    });

    try {
      widget.onTapIndex(1);
    } catch (e) {}
  }

  _onTapStationDetail(
      BuildContext context, RecommendedStationEntity StationEntity) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StationDetailPage(
          stationId: StationEntity.stationId,
        ),
      ),
    );
  }

  checkTabQuickCharge() {
    return stationQuickCharge ||
        (widget.latitude == 0 && widget.longitude == 0);
  }

  checkRefreshPage() {
    if (widget.loading) {
      blankPage = false;
      if (widget.latitude != 0 && widget.longitude != 0) {
        // reset refresh page
        if (widget.refreshRecommend) {
          stationNearMe = true;
          stationQuickCharge = false;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkRefreshPage();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: TextLabel(
              text: translate('home_page.recommended_station.title'),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.superlarge),
              color: AppTheme.blueDark,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          !blankPage ? objectInRecommended(context) : SizedBox.square()
        ],
      ),
    );
  }

  Widget objectInRecommended(BuildContext context) {
    return !widget.loading
        ? Column(
            children: [
              /** Tab Filtter Station **/
              Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: tabFiltterStation(context)),
              const SizedBox(height: 10),
              /** List Station **/
              widget.listStation.length > 0
                  ? Container(
                      height: 120,
                      child: ListView.builder(
                          controller: controller,
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.listStation.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                index < widget.listStation.length
                                    ? renderStationItem(
                                        context,
                                        widget.listStation[index],
                                        widget.latitude,
                                        widget.longitude,
                                        index == 0,
                                      )
                                    : renderNavigateMap(context),
                              ],
                            );
                          }),
                    )
                  : Container(
                      height: 100,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        border: Border.all(color: AppTheme.borderGray),
                      ),
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
                                context, AppFontSize.normal),
                            color: AppTheme.black40,
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    )
            ],
          )
        : Skeletonizer.zone(
            child: Container(
              margin: const EdgeInsets.fromLTRB(12, 0, 12, 20),
              height: 105,
              width: MediaQuery.of(context).size.width,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 12),
                    Bone.square(
                      size: 70,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Bone.text(words: 2), Bone.text(words: 1)],
                    )
                  ],
                ),
              ),
            ),
          );
  }

  Widget tabFiltterStation(BuildContext context) {
    return Row(
      children: [
        (widget.latitude != 0 && widget.longitude != 0)
            ? InkWell(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color:
                          stationNearMe ? AppTheme.blueLight : AppTheme.white,
                      border: Border.all(
                          color: stationNearMe
                              ? AppTheme.blueDark
                              : AppTheme.grayF1F5F9,
                          width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(200)),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.gray9CA3AF,
                          // blurRadius: 0,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: TextLabel(
                      text: translate('home_page.recommended_station.near_me'),
                      color: stationNearMe
                          ? AppTheme.blueDark
                          : AppTheme.gray9CA3AF,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.normal),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                onTap: () {
                  if (!(widget.onCheckClick())) {
                    widget.onCheckClick(check: false, click: true);
                    chooseFilterStation('nearme');
                  }
                },
              )
            : SizedBox.square(),
        const SizedBox(width: 8),
        InkWell(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color:
                    checkTabQuickCharge() ? AppTheme.blueLight : AppTheme.white,
                border: Border.all(
                    color: checkTabQuickCharge()
                        ? AppTheme.blueDark
                        : AppTheme.grayF1F5F9,
                    width: 1),
                borderRadius: BorderRadius.all(Radius.circular(200)),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.gray9CA3AF,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: TextLabel(
                text: translate('home_page.recommended_station.quick_charge'),
                color: checkTabQuickCharge()
                    ? AppTheme.blueDark
                    : AppTheme.gray9CA3AF,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.normal),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          onTap: () {
            if (!(widget.onCheckClick())) {
              widget.onCheckClick(check: false, click: true);
              chooseFilterStation('quickcharge');
            }
          },
        )
      ],
    );
  }

  Widget renderStationItem(
    BuildContext context,
    RecommendedStationEntity stationItem,
    double latitude,
    double longitude,
    bool isFirst,
  ) {
    List<ConnectorTypeAndPowerEntity> listConnector = [];
    if (stationQuickCharge) {
      listConnector = stationItem.connectorType
          .where((item) => (item.connectorPowerType == 'DC'))
          .toList();
    } else {
      listConnector = stationItem.connectorType;
    }
    return Container(
      margin: EdgeInsets.only(left: isFirst ? 16 : 0),
      padding: const EdgeInsets.only(right: 16),
      child: Material(
        color: AppTheme.white,
        shadowColor: AppTheme.gray9CA3AF.withOpacity(0.3),
        elevation: 5,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            if (!(widget.onCheckClick())) {
              _onTapStationDetail(context, stationItem);
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppTheme.borderGray),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox.fromSize(
                        child: stationItem.images == ''
                            ? Image.asset(
                                ImageAsset.img_station_search_png,
                                width: 110,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : ImageNetworkJupiter(
                                url: stationItem.images,
                                width: 110,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                        // Image.network(
                        //     stationItem.images,
                        //     width: 110,
                        //     height: double.infinity,
                        //     fit: BoxFit.cover,
                        //   ),
                      )),
                ),
                const SizedBox(width: 16),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.425,
                        child: TextLabel(
                          text: stationItem.stationName,
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.large),
                          color: AppTheme.blueDark,
                          fontWeight: FontWeight.w700,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      TextLabel(
                        text: (widget.latitude == 0 && widget.longitude == 0)
                            ? ''
                            : '',
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.normal),
                        color: AppTheme.black40,
                        fontWeight: FontWeight.w400,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: (MediaQuery.of(context).size.width * 0.425),
                        height: 25,
                        child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: listConnector.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  width: 10,
                                ),
                            itemBuilder: (context, index) {
                              ConnectorTypeAndPowerEntity connectorType =
                                  listConnector[index];
                              return renderConnecterItem(
                                  context, connectorType);
                            }),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget renderNavigateMap(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 45,
            height: 45,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.3,
                  blurRadius: 5,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Material(
              borderRadius: BorderRadius.circular(200),
              color: AppTheme.white,
              child: InkWell(
                borderRadius: BorderRadius.circular(200),
                onTap: () {
                  if (!(widget.onCheckClick())) {
                    widget.onCheckClick(check: false, click: true);
                    _navigateMapPage(context);
                  }
                },
                child: Icon(
                  Icons.arrow_forward,
                  size: 25,
                  color: AppTheme.pttBlue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderConnecterItem(
      BuildContext context, ConnectorTypeAndPowerEntity connectorEntity) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppTheme.black5,
      ),
      // width: 100,
      child: Row(
        children: [
          SvgPicture.asset(
            _checkTypeConnector(connectorEntity.connectorPowerType,
                connectorEntity.connectorType),
            width: 24,
          ),
          TextLabel(
            maxLines: 1,
            text: Utilities.nameConnecterType(
                connectorEntity.connectorPowerType,
                connectorEntity.connectorType),
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.small),
            fontWeight: FontWeight.w400,
            color: AppTheme.pttBlue,
          )
        ],
      ),
    );
  }
}
