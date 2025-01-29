import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/presentation/pages/splash_screen/check_status_charging.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class TypeCustomButtonCharging {
  static const String CHARGING = 'CHARGING';
  static const String RECEIPT = 'RECEIPT';
  static const String ERROR = 'ERROR';
}

class CustomButtonCharging extends StatefulWidget {
  CustomButtonCharging({
    super.key,
    required this.onPressedButton,
    required this.isPause,
  });

  final Function() onPressedButton;
  final bool isPause;

  @override
  State<CustomButtonCharging> createState() => _CustomButtonChargingState();
}

class _CustomButtonChargingState extends State<CustomButtonCharging> {
  Stream<DateTime> dateTimeStream =
      Stream<DateTime>.periodic(Duration(seconds: 1), (i) => DateTime.now());
  CheckStatusChargingData? chargingData;
  bool switchWidget = false;
  bool processing = false;

  @override
  void initState() {
    getCheckStatusChargingFromGetIt();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getCheckStatusChargingFromGetIt() {
    chargingData = getIt();
  }

  String showValue() {
    try {
      if ((chargingData?.checkStatusEntity != null) &&
          (chargingData?.checkStatusEntity?.chargingStatus ?? false) &&
          (chargingData?.checkStatusEntity?.data?.statusCharger == true) &&
          (chargingData?.checkStatusEntity?.data?.statusReceipt == false)) {
        return TypeCustomButtonCharging.CHARGING;
      } else if ((chargingData?.checkStatusEntity != null) &&
          (chargingData?.checkStatusEntity?.chargingStatus ?? false) &&
          (chargingData?.checkStatusEntity?.data?.statusCharger == false) &&
          (chargingData?.checkStatusEntity?.data?.statusReceipt == true)) {
        return TypeCustomButtonCharging.RECEIPT;
      }
      return TypeCustomButtonCharging.ERROR;
    } catch (e) {
      return TypeCustomButtonCharging.ERROR;
    }
  }

  String getPowerOrBatteryValue() {
    try {
      String battery =
          '${chargingData?.checkStatusEntity?.data?.data?.percent?.value}';
      String batteryUnit =
          '${chargingData?.checkStatusEntity?.data?.data?.percent?.unit}';
      if (chargingData?.checkStatusEntity == null)
        return '';
      else if (battery != '' &&
          battery != 'null' &&
          batteryUnit != 'N/A' &&
          batteryUnit != '')
        return '${chargingData?.checkStatusEntity?.data?.data?.percent?.value} %';
      else
        return '${chargingData?.checkStatusEntity?.data?.data?.powerRealtime?.value.toStringAsFixed(1)}\n${chargingData?.checkStatusEntity?.data?.data?.powerRealtime?.unit}';
    } catch (e) {
      return '0\nkWh';
    }
  }

  String getTimerValue(DateTime currentTime) {
    try {
      String chargingTime =
          '${chargingData?.checkStatusEntity?.data?.data?.startTimeCharging}';
      DateTime currentDateTime = DateTime.parse(chargingTime).toLocal();
      DateTime endDate = currentTime;
      Duration difference = endDate.difference(currentDateTime);
      int hours = difference.inHours % 24;
      int minutes = difference.inMinutes % 60;
      int seconds = difference.inSeconds % 60;
      String formattedDifference = DateFormat('HH:mm:ss')
          .format(DateTime.utc(0, 0, 0, hours, minutes, seconds));
      formattedDifference = '$formattedDifference\nhr';
      // CHECK GET NEW VALUE
      if ((seconds == 0 || seconds == 30) && !widget.isPause) {
        getCheckStatusChargingFromGetIt();
        if (chargingData?.checkStatusEntity?.chargingStatus ?? false) {
          refreshCheckStatus();
        }
      }
      if (difference.inHours >= 24)
        return '23:59:59\nhr';
      else
        return '${formattedDifference}';
    } catch (e) {
      return '00:00:00\nhr';
    }
  }

  void getSwitchValue(DateTime currentTime) {
    try {
      if (currentTime.second % 5 == 0) switchWidget = !switchWidget;
    } catch (e) {}
  }

  void refreshCheckStatus() {
    if (!processing) {
      processing = true;
      Utilities.getCheckStatusCharging(context);
      Future.delayed(const Duration(seconds: 3), () {
        processing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (showValue() == TypeCustomButtonCharging.CHARGING)
      return StreamBuilder<DateTime>(
        stream: dateTimeStream,
        builder: (context, snapshot) {
          getSwitchValue(snapshot.data ?? DateTime.now());
          return InkWell(
            onTap: widget.onPressedButton,
            child: Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(200),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.black.withOpacity(0.35),
                    spreadRadius: 1,
                    blurRadius: 15,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    ImageAsset.ic_car_charging,
                    width: 48,
                    height: 48,
                    color: AppTheme.borderGray.withOpacity(0.75),
                  ),
                  AnimatedOpacity(
                    opacity: switchWidget ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: TextLabel(
                      text: getTimerValue(DateTime.now()),
                      color: AppTheme.blueDark,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.normal),
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: switchWidget ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 500),
                    child: TextLabel(
                      text: getPowerOrBatteryValue(),
                      color: AppTheme.blueDark,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.normal),
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 68,
                    height: 68,
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                      color: AppTheme.blueD,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    else if (showValue() == TypeCustomButtonCharging.RECEIPT)
      return InkWell(
        onTap: widget.onPressedButton,
        child: Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(200),
            boxShadow: [
              BoxShadow(
                color: AppTheme.black.withOpacity(0.35),
                spreadRadius: 1,
                blurRadius: 15,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                ImageAsset.ic_button_receipt,
                width: 36,
                height: 36,
              ),
              Container(
                width: 68,
                height: 68,
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                  color: AppTheme.blueD,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  strokeCap: StrokeCap.round,
                ),
              ),
            ],
          ),
        ),
      );
    else
      return InkWell(
        onTap: widget.onPressedButton,
        child: Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(200),
            boxShadow: [
              BoxShadow(
                color: AppTheme.black.withOpacity(0.35),
                spreadRadius: 1,
                blurRadius: 15,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                ImageAsset.ic_car_charging,
                width: 48,
                height: 48,
              ),
              Container(
                width: 68,
                height: 68,
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                  color: AppTheme.blueD,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  strokeCap: StrokeCap.round,
                ),
              ),
            ],
          ),
        ),
      );
  }
}
