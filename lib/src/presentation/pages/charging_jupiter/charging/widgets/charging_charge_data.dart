import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter/src/presentation/widgets/gif_image_stop_frame.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:super_tooltip/super_tooltip.dart';

class ChargingChargeData extends StatefulWidget {
  const ChargingChargeData(
      {super.key,
      required this.image,
      required this.carName,
      required this.batteryRealtime,
      required this.chargingTime,
      required this.distance,
      required this.powerCharging,
      required this.powerRealtime,
      required this.distanceValue,
      // BATTERY
      // required this.controller,
      // required this.onCloseModal,
      // required this.onDoneModal,
      required this.onShowModal,
      required this.isLoadingUpdateBattery,
      this.fleetType,
      this.fromFleet,
      this.fleetNo,
      this.chargingType,
      required this.qrCodeData,
      required this.onNavigateSelectVehicle});

  final String image;
  final String carName;
  final String batteryRealtime;
  final String chargingTime;
  final String distance;
  final String powerCharging;
  final double powerRealtime;
  final double distanceValue;
  // BATTERY
  // final TextEditingController controller;
  // final Function() onCloseModal;
  // final Function() onDoneModal;
  final Function() onShowModal;
  final bool isLoadingUpdateBattery;
  final String? fleetType;
  final bool? fromFleet;
  final int? fleetNo;
  final String? chargingType;
  final String qrCodeData;
  final Function() onNavigateSelectVehicle;

  @override
  State<ChargingChargeData> createState() => _ChargingChargeDataState();
}

class _ChargingChargeDataState extends State<ChargingChargeData> {
  Stream<DateTime> dateTimeStream =
      Stream<DateTime>.periodic(Duration(seconds: 1), (i) => DateTime.now());

  final tootipController = SuperTooltipController();
  bool? tooltipDistance = false;

  void isTooltipDistance() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // final prefs = await SharedPreferences.getInstance();
      JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
      tooltipDistance = jupiterPrefsAndAppData.tooltipDistance;

      if (tooltipDistance ?? false) {
      } else {
        tooltipDistance = true;
        jupiterPrefsAndAppData.setToolTipDistance(tooltipDistance!);
        await tootipController.showTooltip();
        setState(() {});
      }
    });
  }

  void initState() {
    super.initState();
    isTooltipDistance();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.31,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          renderImageBatteryGif(),
          const SizedBox(width: 16),
          Expanded(
            child: renderCheckSelectCar(),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget renderImageBatteryGif() {
    if (widget.isLoadingUpdateBattery) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            ImageAsset.battery_gif,
            height: MediaQuery.of(context).size.height * 0.30,
          ),
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: AppTheme.white,
              strokeCap: StrokeCap.round,
            ),
          )
        ],
      );
    } else {
      return GestureDetector(
        onTap: widget.onShowModal,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Image.asset(
            //   ImageAsset.battery_gif,
            //   height: MediaQuery.of(context).size.height * 0.30,
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              child: GifImageStopFrame(
                image: AssetImage(ImageAsset.battery_gif),
                frameLength: 60,
                frameStop: 60,
                isLoop: widget.batteryRealtime != '100 %' ? true : false,
                height: MediaQuery.of(context).size.height * 0.30,
              ),
            ),
            widget.batteryRealtime != ''
                ? Container(
                    width: MediaQuery.of(context).size.height * 0.12,
                    height: MediaQuery.of(context).size.height * 0.06,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(4),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: TextLabel(
                        text: widget.batteryRealtime,
                        color: AppTheme.white,
                        fontWeight: FontWeight.w700,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.normal),
                      ),
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.height * 0.12,
                    height: MediaQuery.of(context).size.height * 0.06,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppTheme.black.withOpacity(0.2)),
                    child: TextLabel(
                      text: translate('charging_page.add_current_battery'),
                      color: AppTheme.white,
                      fontWeight: FontWeight.w700,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.small),
                      textAlign: TextAlign.center,
                    ),
                  ),
          ],
        ),
      );
    }
  }

  Widget renderImageUrl(String imageUrl) {
    if (imageUrl.isNotEmpty) {
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.14,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return Center(
        child: SvgPicture.asset(
          ImageAsset.car_default,
          height: MediaQuery.of(context).size.height * 0.14,
        ),
      );
    }
  }

  Widget renderDetailOfCharging() {
    return StreamBuilder<DateTime>(
      stream: dateTimeStream,
      builder: (context, snapshot) {
        String formattedDifference = 'N/A';
        if (widget.chargingTime.isNotEmpty && widget.chargingTime != '') {
          DateTime currentDateTime =
              DateTime.parse(widget.chargingTime).toLocal();
          DateTime endDate = snapshot.data ?? DateTime.now();
          Duration difference = endDate.difference(currentDateTime);
          int hours = difference.inHours % 24;
          int minutes = difference.inMinutes % 60;
          int seconds = difference.inSeconds % 60;
          formattedDifference = DateFormat('HH:mm:ss')
              .format(DateTime.utc(0, 0, 0, hours, minutes, seconds));
          if (difference.inHours >= 24) {
            formattedDifference = '23:59:59 hr';
          } else {
            formattedDifference = '$formattedDifference hr';
          }
          if ((endDate.millisecondsSinceEpoch -
                  currentDateTime.millisecondsSinceEpoch >
              0)) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.275,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    border: Border.all(
                      width: 1,
                      color: AppTheme.borderGray,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.watch_later,
                        color: AppTheme.blueDark,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      TextLabel(
                        text: formattedDifference,
                        color: AppTheme.blueDark,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.large),
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      TextLabel(
                        text: translate(
                            'charging_page.charging_change.charging_time'),
                        color: AppTheme.black40,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.little),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.275,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    border: Border.all(
                      width: 1,
                      color: AppTheme.borderGray,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.bolt,
                        color: AppTheme.blueDark,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      TextLabel(
                        text: widget.powerCharging,
                        color: AppTheme.blueDark,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.large),
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      TextLabel(
                        text: translate(
                            'charging_page.charging_change.power_charging'),
                        color: AppTheme.black40,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.little),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                // ColWith2Text(
                //   icon: const Icon(
                //     Icons.watch_later,
                //     color: AppTheme.blueDark,
                //     size: 24,
                //   ),
                //   text1: formattedDifference,
                //   text2:
                //       translate('charging_page.charging_change.charging_time'),
                //   text1Size: Utilities.sizeFontWithDesityForDisplay(
                //       context, AppFontSize.big),
                //   text2Size: Utilities.sizeFontWithDesityForDisplay(
                //       context, AppFontSize.small),
                //   text1Weight: FontWeight.w900,
                //   text2Weight: FontWeight.w400,
                //   text1Color: AppTheme.blueDark,
                //   text2Color: AppTheme.black40,
                // ),
                // distanceDetail(
                //     text1:
                //         '${Utilities.formatMoney('${widget.distanceValue}', 1)} ${widget.distance}',
                //     text2: translate(
                //         translate('charging_page.charging_change.distance'))),
                // ColWith2Text(
                //   icon: const Icon(
                //     Icons.bolt,
                //     color: AppTheme.blueDark,
                //     size: 24,
                //   ),
                //   text1: widget.powerCharging,
                //   text2: translate(translate(
                //       'charging_page.charging_change.power_charging')),
                //   text1Size: Utilities.sizeFontWithDesityForDisplay(
                //       context, AppFontSize.big),
                //   text2Size: Utilities.sizeFontWithDesityForDisplay(
                //       context, AppFontSize.small),
                //   text1Weight: FontWeight.w900,
                //   text2Weight: FontWeight.w400,
                //   text1Color: AppTheme.blueDark,
                //   text2Color: AppTheme.black40,
                // ),
              ],
            );
          } else {
            return defaultDetailOfCharging();
          }
        } else {
          return defaultDetailOfCharging();
        }
      },
    );
  }

  Widget defaultDetailOfCharging() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.275,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.white,
            border: Border.all(
              width: 1,
              color: AppTheme.borderGray,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(
                Icons.watch_later,
                color: AppTheme.blueDark,
                size: 24,
              ),
              const SizedBox(height: 4),
              TextLabel(
                text: '00:00:00 hr',
                color: AppTheme.blueDark,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.large),
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              TextLabel(
                text: translate('charging_page.charging_change.charging_time'),
                color: AppTheme.black40,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.little),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.275,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.white,
            border: Border.all(
              width: 1,
              color: AppTheme.borderGray,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(
                Icons.bolt,
                color: AppTheme.blueDark,
                size: 24,
              ),
              const SizedBox(height: 4),
              TextLabel(
                text: '0.0 kW',
                color: AppTheme.blueDark,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.large),
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              TextLabel(
                text: translate('charging_page.charging_change.power_charging'),
                color: AppTheme.black40,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.little),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
        // ColWith2Text(
        //   icon: const Icon(
        //     Icons.watch_later,
        //     color: AppTheme.blueDark,
        //     size: 24,
        //   ),
        //   text1: '00:00:00 hr',
        //   text2: translate('charging_page.charging_change.charging_time'),
        //   text1Size:
        //       Utilities.sizeFontWithDesityForDisplay(context, AppFontSize.big),
        //   text2Size: Utilities.sizeFontWithDesityForDisplay(
        //       context, AppFontSize.small),
        //   text1Weight: FontWeight.w900,
        //   text2Weight: FontWeight.w400,
        //   text1Color: AppTheme.blueDark,
        //   text2Color: AppTheme.black40,
        // ),
        // distanceDetail(
        //     text1: '0.0 km',
        //     text2:
        //         translate(translate('charging_page.charging_change.distance'))),
        // ColWith2Text(
        //   icon: const Icon(
        //     Icons.bolt,
        //     color: AppTheme.blueDark,
        //     size: 24,
        //   ),
        //   text1: '0.0 kW',
        //   text2: translate(
        //       translate('charging_page.charging_change.power_charging')),
        //   text1Size:
        //       Utilities.sizeFontWithDesityForDisplay(context, AppFontSize.big),
        //   text2Size: Utilities.sizeFontWithDesityForDisplay(
        //       context, AppFontSize.small),
        //   text1Weight: FontWeight.w900,
        //   text2Weight: FontWeight.w400,
        //   text1Color: AppTheme.blueDark,
        //   text2Color: AppTheme.black40,
        // ),
      ],
    );
  }

  Widget distanceDetail({String text1 = '', String text2 = ''}) {
    return Container(
      // color: AppTheme.green,
      child: Column(
        children: [
          const Icon(
            Icons.cable,
            color: AppTheme.blueDark,
            size: 24,
          ),
          const SizedBox(
            height: 10,
          ),
          TextLabel(
            maxLines: 1,
            text:
                '${Utilities.formatMoney('${widget.distanceValue}', 1)} ${widget.distance}',
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.big),
            fontWeight: FontWeight.w900,
            color: AppTheme.blueDark,
          ),
          toolTipDistance(),
        ],
      ),
    );
  }

  Widget toolTipDistance() {
    return GestureDetector(
      onTap: () async {
        await tootipController.showTooltip();
      },
      child: SuperTooltip(
        left: (MediaQuery.of(context).size.width) * 0.3,
        fadeInDuration: const Duration(milliseconds: 1000),
        showBarrier: true,
        controller: tootipController,
        popupDirection: TooltipDirection.down,
        backgroundColor: AppTheme.black80.withOpacity(0.9),
        arrowTipDistance: 15.0,
        touchThroughAreaCornerRadius: 30,
        barrierColor: AppTheme.transparent,
        shadowColor: AppTheme.transparent,
        content: Container(
          height: (((MediaQuery.of(context).size.height) * 0.15) < 130
              ? 130
              : (MediaQuery.of(context).size.height) * 0.15),
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.blueD,
                    ),
                    child: Icon(
                      Icons.question_mark,
                      color: AppTheme.white,
                      size: 15,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextLabel(
                      text: translate(
                          'charging_page.tooltip.tootip_distancce_title'),
                      color: AppTheme.white,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.normal),
                      fontWeight: FontWeight.w700),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () async {
                          await tootipController.hideTooltip();
                        },
                        child: Icon(
                          Icons.close,
                          color: AppTheme.white,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextLabel(
                  text:
                      translate('charging_page.tooltip.tootip_distancce_body'),
                  textAlign: TextAlign.left,
                  color: AppTheme.white,
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.normal),
                  fontWeight: FontWeight.w400),
            ],
          ),
        ),
        child: Row(
          children: [
            TextLabel(
              // maxLines: 1,
              text: translate(
                  translate('charging_page.charging_change.distance')),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.small),
              fontWeight: FontWeight.w400,
              color: AppTheme.black40,
              textAlign: TextAlign.center,
              // overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              width: 14.0,
              height: 14.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.blueD,
              ),
              child: Icon(
                Icons.question_mark,
                color: AppTheme.white,
                size: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderCheckSelectCar() {
    if (((widget.fromFleet ?? false) &&
            (widget.fleetType == FleetType.OPERATION)) &&
        (widget.chargingType == FleetOperationStatus.CHARGING_RFID)) {
      if (widget.carName != '' && widget.carName != 'null null') {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                // onNavigateSelectVehicle();
                widget.onNavigateSelectVehicle();
              },
              child: Row(
                children: [
                  TextLabel(
                    text: widget.carName,
                    // text: 'TOYOTA Pruis1',
                    fontSize: Utilities.sizeFontWithDesityForDisplay(
                        context, AppFontSize.large),
                    fontWeight: FontWeight.w700,
                    color: AppTheme.blueDark,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.create_rounded,
                    size: 18,
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            InkWell(
              onTap: () {
                // onNavigateSelectVehicle();
                widget.onNavigateSelectVehicle();
              },
              child: renderImageUrl(widget.image),
            ),
            const Expanded(child: SizedBox()),
            renderDetailOfCharging(),
          ],
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextLabel(
              text: widget.carName,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.large),
              fontWeight: FontWeight.w700,
              color: AppTheme.blueDark,
            ),
            const Expanded(child: SizedBox()),
            Stack(
              alignment: Alignment.center,
              children: [
                renderImageUrl(widget.image),
                InkWell(
                  onTap: () {
                    // onNavigateSelectVehicle();
                    widget.onNavigateSelectVehicle();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(12),
                      strokeWidth: 1,
                      color: AppTheme.blueDark,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppTheme.white.withOpacity(0.85),
                        ),
                        child: TextLabel(
                          text: translate(
                              'charging_page.select_vehicle.add_select_vehicle'),
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.normal),
                          fontWeight: FontWeight.w700,
                          color: AppTheme.blueDark,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const Expanded(child: SizedBox()),
            renderDetailOfCharging(),
          ],
        );
      }
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextLabel(
            text: widget.carName,
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.large),
            fontWeight: FontWeight.w700,
            color: AppTheme.blueDark,
          ),
          const Expanded(child: SizedBox()),
          renderImageUrl(widget.image),
          const Expanded(child: SizedBox()),
          renderDetailOfCharging(),
        ],
      );
    }
  }
}
