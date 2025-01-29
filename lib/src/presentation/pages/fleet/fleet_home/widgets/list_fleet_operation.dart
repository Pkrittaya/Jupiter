import 'dart:math';
import 'package:animated_styled_widget/animated_styled_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/image_network_jupiter.dart';
import 'package:jupiter_api/domain/entities/fleet_operation_item_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/button_progress.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListFleetOperation extends StatefulWidget {
  const ListFleetOperation({
    Key? key,
    required this.listfleetOperation,
    required this.loading,
    required this.onTapFleetOperationItem,
  }) : super(key: key);

  final List<FleetOperationItemEntity> listfleetOperation;
  final bool loading;
  final Function(FleetOperationItemEntity) onTapFleetOperationItem;

  @override
  _ListFleetOperationState createState() => _ListFleetOperationState();
}

class _ListFleetOperationState extends State<ListFleetOperation> {
  double sizeImageFleet = 89;

  double getWidth(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.08;
    return width > 36 ? 36 : width;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.listfleetOperation.length > 0 && !widget.loading) {
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.white,
              AppTheme.blueLight,
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: ListView.separated(
                  physics: ClampingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  separatorBuilder: (context, index) {
                    return SizedBox();
                  },
                  shrinkWrap: true,
                  itemCount: widget.listfleetOperation.length,
                  itemBuilder: (context, index) {
                    FleetOperationItemEntity fleetOperationItem =
                        widget.listfleetOperation[index];
                    return Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 15,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: AppTheme.white,
                                borderRadius: BorderRadius.circular(12),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () {
                                    widget.onTapFleetOperationItem(
                                        fleetOperationItem);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        renderImage(fleetOperationItem.images),
                                        const SizedBox(width: 24),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: TextLabel(
                                                      text:
                                                          '${fleetOperationItem.fleetName}',
                                                      color: AppTheme.blueDark,
                                                      fontSize: Utilities
                                                          .sizeFontWithDesityForDisplay(
                                                              context,
                                                              AppFontSize
                                                                  .large),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  renderChipTotalCharging(
                                                    fleetOperationItem
                                                        .connectorAvailable,
                                                    fleetOperationItem
                                                        .connectorTotal,
                                                    '${fleetOperationItem.status.toLowerCase()}' ==
                                                        'disable',
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextLabel(
                                                    text: translate(
                                                        'fleet_page.operation.connector'),
                                                    color: AppTheme.gray9CA3AF,
                                                    fontSize: Utilities
                                                        .sizeFontWithDesityForDisplay(
                                                            context,
                                                            AppFontSize.normal),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 4),
                                                    child: TextLabel(
                                                      text:
                                                          '${fleetOperationItem.connectorTotal}',
                                                      color:
                                                          AppTheme.gray9CA3AF,
                                                      fontSize: Utilities
                                                          .sizeFontWithDesityForDisplay(
                                                              context,
                                                              AppFontSize
                                                                  .normal),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextLabel(
                                                    text: translate(
                                                        'fleet_page.operation.vehicle'),
                                                    color: AppTheme.gray9CA3AF,
                                                    fontSize: Utilities
                                                        .sizeFontWithDesityForDisplay(
                                                            context,
                                                            AppFontSize.normal),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 4),
                                                    child: TextLabel(
                                                      text:
                                                          '${fleetOperationItem.fleetVehicle}',
                                                      color:
                                                          AppTheme.gray9CA3AF,
                                                      fontSize: Utilities
                                                          .sizeFontWithDesityForDisplay(
                                                              context,
                                                              AppFontSize
                                                                  .normal),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                                height: widget.listfleetOperation.length - 1 ==
                                        index
                                    ? 16
                                    : 0),
                          ],
                        ),
                        Positioned(
                            top: 20,
                            left: sizeImageFleet + 12,
                            child: Container(
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
                              child: (fleetOperationItem.statusCharging ==
                                      FleetOperationStatus.CHARGING)
                                  ? ButtonProgress(
                                      visible: true,
                                      finish: false,
                                      borderWidth: 4,
                                      width: getWidth(context).toPXLength,
                                      height: getWidth(context).toPXLength,
                                      gradient: const SweepGradient(
                                          startAngle: pi,
                                          colors: [
                                            AppTheme.red,
                                            AppTheme.red,
                                          ]),
                                      onTap: () {},
                                      child: SvgPicture.asset(
                                        ImageAsset.ic_car_charging,
                                        color: AppTheme.red,
                                        width: getWidth(context) -
                                            (getWidth(context) / 2),
                                        height: getWidth(context) -
                                            (getWidth(context) / 2),
                                      ),
                                    )
                                  : Visibility(
                                      visible:
                                          (fleetOperationItem.statusCharging ==
                                              FleetOperationStatus.RECEIPT),
                                      child: ButtonProgress(
                                        visible: true,
                                        finish: true,
                                        borderWidth: 0,
                                        width: getWidth(context).toPXLength,
                                        height: getWidth(context).toPXLength,
                                        gradient: const SweepGradient(
                                            startAngle: pi,
                                            colors: [
                                              AppTheme.white,
                                              AppTheme.white,
                                            ]),
                                        onTap: () {},
                                        child: Image.asset(
                                          ImageAsset.ic_car_receipt,
                                          width: getWidth(context) -
                                              (getWidth(context) / 2),
                                          height: getWidth(context) -
                                              (getWidth(context) / 2),
                                        ),
                                      ),
                                    ),
                            )),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    } else if (widget.loading) {
      const int item = 3;
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.white,
              AppTheme.blueLight,
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox();
                  },
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: item,
                  itemBuilder: (context, index) {
                    return Skeletonizer(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppTheme.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 15,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Bone.square(
                                  size: 90,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Bone.text(
                                            words: 1,
                                            fontSize: Utilities
                                                .sizeFontWithDesityForDisplay(
                                                    context,
                                                    AppFontSize.normal),
                                          ),
                                          Bone.text(
                                            width: 40,
                                            fontSize: Utilities
                                                .sizeFontWithDesityForDisplay(
                                                    context, AppFontSize.large),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Bone.text(words: 1),
                                          Bone.text(width: 24),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Bone.text(words: 1),
                                          Bone.text(width: 24),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.white,
                  AppTheme.blueLight,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageAsset.img_default_empty,
                  width: 150,
                  height: 150,
                ),
                TextLabel(
                  text: translate('empty.history'),
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.superlarge),
                  color: AppTheme.black40,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget renderChipTotalCharging(int available, int total, bool isLocked) {
    if (!isLocked) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            color: AppTheme.grayD1D5DB),
        child: Row(children: [
          SvgPicture.asset(
            ImageAsset.ac_type2,
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 4),
          TextLabel(
            text: '${available}',
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.little),
            color: available > 0 ? AppTheme.green : AppTheme.black60,
          ),
          TextLabel(
            text: '/',
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.little),
            color: AppTheme.black60,
          ),
          TextLabel(
            text: '${total}',
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.little),
            color: AppTheme.black60,
          ),
        ]),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200), color: AppTheme.red),
        child: Icon(
          Icons.lock,
          color: AppTheme.white,
          size: 20,
        ),
      );
    }
  }

  Widget renderImage(String image) {
    return Container(
      width: sizeImageFleet,
      height: sizeImageFleet,
      padding: EdgeInsets.all(image != '' ? 0 : 8),
      decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: AppTheme.borderGray)),
      child: image != ''
          ? ClipRRect(
              borderRadius: BorderRadius.circular(20), // Image border
              child: SizedBox.fromSize(
                size: Size.fromRadius(48), // Image radius
                child: ImageNetworkJupiter(
                  url: image,
                ),
                // Image.network(
                //   image,
                // ),
              ),
            )
          : SvgPicture.asset(
              ImageAsset.logo_jupiter_color,
            ),
    );
  }
}
