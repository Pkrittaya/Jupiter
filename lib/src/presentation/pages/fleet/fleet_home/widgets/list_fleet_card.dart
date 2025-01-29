import 'dart:math';
import 'package:animated_styled_widget/animated_styled_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/pages/fleet/fleet_home/widgets/filter_list_fleet.dart';
import 'package:jupiter/src/presentation/widgets/image_network_jupiter.dart';
import 'package:jupiter_api/domain/entities/fleet_card_item_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/button_progress.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListFleetCard extends StatefulWidget {
  const ListFleetCard(
      {Key? key,
      required this.listfleetCard,
      required this.loading,
      required this.onTapFleetCardItem,
      required this.onTapFilter,
      required this.selectFilter})
      : super(key: key);

  final List<FleetCardItemEntity> listfleetCard;
  final bool loading;
  final Function(FleetCardItemEntity) onTapFleetCardItem;
  final Function(String) onTapFilter;
  final String selectFilter;

  @override
  _ListFleetCardState createState() => _ListFleetCardState();
}

class _ListFleetCardState extends State<ListFleetCard> {
  double sizeImageFleet = 120;

  String formatCreditCardDisplay(String display) {
    return display.substring(display.length - 4);
  }

  String getExpiredDate(String date) {
    try {
      final inputDate = DateTime.parse(date).toLocal();
      return DateFormat('MM/yyyy').format(inputDate);
    } catch (e) {
      return 'N/A';
    }
  }

  double getWidth(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.08;
    return width > 36 ? 36 : width;
  }

  String getIconTypeFleet(String type) {
    switch (type) {
      case FleetCardType.FLEET:
        return ImageAsset.ic_card;
      case FleetCardType.RFID:
        return ImageAsset.ic_rfid;
      case FleetCardType.AUTOCHARGE:
        return ImageAsset.ic_car_charging;
      default:
        return ImageAsset.ic_card;
    }
  }

  Color getColorTypeFleet(String type) {
    switch (type) {
      case FleetCardType.FLEET:
        return AppTheme.blueLight;
      case FleetCardType.RFID:
        return AppTheme.orange20;
      case FleetCardType.AUTOCHARGE:
        return AppTheme.green20;
      default:
        return AppTheme.blueLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.listfleetCard.length > 0 && !widget.loading) {
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
            FilterListFleet(
              onTapFilter: widget.onTapFilter,
              selectFilter: widget.selectFilter,
            ),
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
                  itemCount: widget.listfleetCard.length,
                  itemBuilder: (context, index) {
                    FleetCardItemEntity fleetCardItem =
                        widget.listfleetCard[index];
                    return Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
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
                                borderRadius: BorderRadius.circular(12),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        AppTheme.white,
                                        getColorTypeFleet(
                                            fleetCardItem.fleetCardType),
                                      ],
                                    ),
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () {
                                      widget.onTapFleetCardItem(fleetCardItem);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              renderImage(fleetCardItem.image,
                                                  fleetCardItem.status),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SvgPicture.asset(
                                                          getIconTypeFleet(
                                                              fleetCardItem
                                                                  .fleetCardType),
                                                          width: 16,
                                                          height: 16,
                                                          colorFilter:
                                                              ColorFilter.mode(
                                                                  AppTheme
                                                                      .gray9CA3AF,
                                                                  BlendMode
                                                                      .srcIn),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        TextLabel(
                                                          text:
                                                              '✱✱✱✱ ✱✱✱✱ ✱✱✱✱',
                                                          color:
                                                              AppTheme.blueDark,
                                                          fontSize: Utilities
                                                              .sizeFontWithDesityForDisplay(
                                                                  context,
                                                                  AppFontSize
                                                                      .supermini),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        TextLabel(
                                                          text:
                                                              ' ${formatCreditCardDisplay(fleetCardItem.fleetCardNo)}',
                                                          color:
                                                              AppTheme.blueDark,
                                                          fontSize: Utilities
                                                              .sizeFontWithDesityForDisplay(
                                                                  context,
                                                                  AppFontSize
                                                                      .large),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Expanded(
                                                          child: Visibility(
                                                            visible:
                                                                '${fleetCardItem.status.toLowerCase()}' ==
                                                                    'disable',
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                const SizedBox(),
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          4,
                                                                      vertical:
                                                                          4),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              200),
                                                                      color: AppTheme
                                                                          .red),
                                                                  child: Icon(
                                                                    Icons.lock,
                                                                    color: AppTheme
                                                                        .white,
                                                                    size: 20,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        TextLabel(
                                                          text: translate(
                                                              'fleet_page.card.expired'),
                                                          color: AppTheme
                                                              .gray9CA3AF,
                                                          fontSize: Utilities
                                                              .sizeFontWithDesityForDisplay(
                                                                  context,
                                                                  AppFontSize
                                                                      .large),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 4),
                                                          child: TextLabel(
                                                            text:
                                                                '${getExpiredDate(fleetCardItem.expired)}',
                                                            color: AppTheme
                                                                .gray9CA3AF,
                                                            fontSize: Utilities
                                                                .sizeFontWithDesityForDisplay(
                                                                    context,
                                                                    AppFontSize
                                                                        .large),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextLabel(
                                                text: translate(
                                                    'fleet_page.card.fleet_credit'),
                                                color: AppTheme.gray9CA3AF,
                                                fontSize: Utilities
                                                    .sizeFontWithDesityForDisplay(
                                                        context,
                                                        AppFontSize.large),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4),
                                                  child: TextLabel(
                                                    text: Utilities.formatMoney(
                                                        '${fleetCardItem.credit}',
                                                        2),
                                                    color: AppTheme.gray9CA3AF,
                                                    fontSize: Utilities
                                                        .sizeFontWithDesityForDisplay(
                                                            context,
                                                            AppFontSize.large),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextLabel(
                                                text: translate(
                                                    'fleet_page.card.available'),
                                                color: AppTheme.gray9CA3AF,
                                                fontSize: Utilities
                                                    .sizeFontWithDesityForDisplay(
                                                        context,
                                                        AppFontSize.large),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4),
                                                  child: TextLabel(
                                                    text: Utilities.formatMoney(
                                                        '${fleetCardItem.available}',
                                                        2),
                                                    color: AppTheme.gray9CA3AF,
                                                    fontSize: Utilities
                                                        .sizeFontWithDesityForDisplay(
                                                            context,
                                                            AppFontSize.large),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(
                            //     height: widget.listfleetCard.length - 1 == index
                            //         ? 16
                            //         : 0),
                          ],
                        ),
                        Positioned(
                          top: 10,
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
                            child: ButtonProgress(
                              visible: fleetCardItem.statusCharging,
                              finish: false,
                              borderWidth: 4,
                              width: getWidth(context).toPXLength,
                              height: getWidth(context).toPXLength,
                              gradient:
                                  const SweepGradient(startAngle: pi, colors: [
                                AppTheme.red,
                                AppTheme.red,
                              ]),
                              onTap: () {},
                              child: SvgPicture.asset(
                                ImageAsset.ic_car_charging,
                                color: AppTheme.red,
                                width:
                                    getWidth(context) - (getWidth(context) / 2),
                                height:
                                    getWidth(context) - (getWidth(context) / 2),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Container(height: MediaQuery.of(context).size.height * 0.11)
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: sizeImageFleet,
                                      height: sizeImageFleet / 2,
                                      child: Bone.square(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Bone.text(words: 2),
                                          const SizedBox(height: 8),
                                          Bone.text(words: 1),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Bone.text(width: 50),
                                    Bone.text(words: 1),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Bone.text(width: 70),
                                    Bone.text(words: 1),
                                  ],
                                ),
                                const SizedBox(height: 4),
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
      var height = MediaQuery.of(context).size.height;
      return Container(
        height: height * 0.91,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilterListFleet(
                  onTapFilter: widget.onTapFilter,
                  selectFilter: widget.selectFilter,
                ),
                Column(
                  children: [
                    SizedBox(height: height * 0.25),
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
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget renderImage(String image, String status) {
    if (image != '') {
      return Container(
          width: sizeImageFleet,
          height: sizeImageFleet / 2,
          decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 1, color: AppTheme.borderGray)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12), // Image border
            child: SizedBox.fromSize(
              size: Size.fromRadius(48), // Image radius
              child: ImageNetworkJupiter(
                url: image,
                fit: BoxFit.cover,
              ),
              // Image.network(
              //   image,
              //   fit: BoxFit.cover,
              // ),
            ),
          ));
    } else {
      return Container(
        width: sizeImageFleet,
        height: sizeImageFleet / 2,
        padding: const EdgeInsets.only(left: 8, right: 8),
        decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1, color: AppTheme.borderGray)),
        child: SvgPicture.asset(
          ImageAsset.logo_jupiter_color,
        ),
      );
    }
  }
}
