import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/duration_entity.dart';
import 'package:jupiter_api/domain/entities/station_details_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StationDetail extends StatefulWidget {
  const StationDetail({
    super.key,
    required StationDetailEntity? stationDetailEntity,
    required this.isPermissionLocation,
    required this.isLoading,
  }) : _stationDetailEntity = stationDetailEntity;

  final StationDetailEntity? _stationDetailEntity;
  final bool isPermissionLocation;
  final bool isLoading;

  @override
  State<StationDetail> createState() => _StationDetailState();
}

class _StationDetailState extends State<StationDetail> {
  bool isVisible = false;

  Map<int, String> days = {
    1: translate('station_details_page.week.mon'),
    2: translate('station_details_page.week.tue'),
    3: translate('station_details_page.week.wed'),
    4: translate('station_details_page.week.thu'),
    5: translate('station_details_page.week.fri'),
    6: translate('station_details_page.week.sat'),
    7: translate('station_details_page.week.sun'),
  };

  DateTime dateWeekNow = DateTime.now();
  /*DateTime.parse('2023-07-31T03:18:31.177769-04:00');*/

  List<DurationEntity> listduration = List.empty(growable: true);

  DurationEntity? chxDuration;

  String getDistanceAndEta() {
    if (widget._stationDetailEntity?.distance != null &&
        widget._stationDetailEntity?.eta != null) {
      return '${widget._stationDetailEntity?.distance} • ${widget._stationDetailEntity?.eta}';
    } else {
      return '';
    }
  }

  bool chxDurationForDay() {
    var status = false;
    var durationDay = chxDuration?.status ?? false;
    var durationTime = widget._stationDetailEntity?.statusOpening ?? false;
    if (durationDay && durationTime) {
      status = true;
    } else {
      status = false;
    }
    return status;
  }

  String chxDurationForTime() {
    var text = '';
    var durationDay = chxDuration?.status ?? false;
    var durationTime = widget._stationDetailEntity?.statusOpening ?? false;
    if (durationDay && durationTime) {
      text = 'Close ${chxDuration?.end ?? ''}';
    } else if (durationDay && !durationTime) {
      text = 'Close ${chxDuration?.end ?? ''}';
    } else if (!durationDay && durationTime) {
      text = 'Close';
    } else if (!durationDay && !durationTime) {
      text = 'Close';
    }
    return text;
  }

  checkDuration() {
    if (widget._stationDetailEntity?.openingHours != null) {
      listduration = widget._stationDetailEntity!.openingHours;
      int searchduration = listduration
          .indexWhere((item) => (item.index + 1) == dateWeekNow.weekday);
      if (searchduration >= 0) {
        chxDuration = listduration[searchduration];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading)
      return Skeletonizer(
        enabled: true,
        child: Column(
          children: [
            Row(
              children: [
                Bone.circle(size: 24),
                const SizedBox(width: 10),
                Bone.text(
                  words: 3,
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.supermini),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Bone.circle(size: 24),
                const SizedBox(width: 10),
                Bone.text(
                  words: 1,
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.supermini),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Bone.circle(size: 24),
                const SizedBox(width: 10),
                Bone.text(
                  words: 2,
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.supermini),
                ),
              ],
            ),
          ],
        ),
      );
    else {
      checkDuration();
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  ImageAsset.ic_marker,
                  width: 24,
                  height: 24,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextLabel(
                    text: widget._stationDetailEntity?.address ?? '',
                    color: AppTheme.black80,
                    fontSize: Utilities.sizeFontWithDesityForDisplay(
                        context, AppFontSize.large),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            widget.isPermissionLocation
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        ImageAsset.ic_route,
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextLabel(
                          text: getDistanceAndEta(),
                          color: AppTheme.black80,
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.large),
                        ),
                      ),
                    ],
                  )
                : SizedBox.shrink(),
            widget.isPermissionLocation
                ? const SizedBox(height: 12)
                : SizedBox.shrink(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  ImageAsset.ic_clock,
                  width: 24,
                  height: 24,
                ),
                SizedBox(width: 10),
                chxDuration != null ? renderDuration() : SizedBox.shrink()
              ],
            ),
            renderDurationItem(),
            SizedBox(
                height: widget._stationDetailEntity?.lowPriorityTariff == true
                    ? 12
                    : 0),
            Visibility(
              visible: widget._stationDetailEntity?.lowPriorityTariff == true,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                          color: AppTheme.red,
                          borderRadius: BorderRadius.circular(200)),
                      padding: const EdgeInsets.all(4),
                      child: Center(
                        child: SvgPicture.asset(
                          ImageAsset.ic_lightning,
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(
                            AppTheme.white,
                            BlendMode.srcIn,
                          ),
                          matchTextDirection: true,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextLabel(
                      text: translate('station_details_page.low_priority'),
                      color: AppTheme.black80,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.large),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget renderDuration() {
    return InkWell(
      onTap: () {
        setState(() {
          isVisible = !isVisible;
        });
      },
      child: Row(
        children: [
          Row(
            children: [
              (chxDurationForDay())
                  ? TextLabel(
                      color: AppTheme.green,
                      text: 'Open',
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.large),
                    )
                  : SizedBox.shrink(),
              (chxDurationForDay())
                  ? TextLabel(
                      color: AppTheme.black40,
                      text: ' • ',
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.large),
                    )
                  : SizedBox.shrink(),
              TextLabel(
                color: AppTheme.black40,
                text: chxDurationForTime(),
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.large),
              ),
            ],
          ),
          const Icon(Icons.arrow_drop_down, color: AppTheme.blueDark),
        ],
      ),
    );
  }

  Widget renderDurationItem() {
    return Visibility(
      visible: isVisible,
      child: Container(
        margin: const EdgeInsets.only(left: 30),
        // color: Colors.amber,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: listduration.map((date) {
            DurationEntity duration = date;
            int dayWeek = duration.index + 1;
            return Row(
              children: [
                SizedBox(
                  width: 42,
                  child: TextLabel(
                    text: '${days[dayWeek]}',
                    color: dateWeekNow.weekday == dayWeek
                        ? AppTheme.black
                        : AppTheme.black40,
                    fontSize: Utilities.sizeFontWithDesityForDisplay(
                        context, AppFontSize.large),
                  ),
                ),
                TextLabel(
                  text: duration.status
                      ? '${duration.start} - ${duration.end}'
                      : 'Close',
                  color: dateWeekNow.weekday == dayWeek
                      ? AppTheme.black
                      : AppTheme.black40,
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.large),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
