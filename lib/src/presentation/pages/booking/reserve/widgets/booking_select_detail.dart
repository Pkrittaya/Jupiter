import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class BookingSelectDetail extends StatefulWidget {
  const BookingSelectDetail({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.totalTime,
    required this.startDate,
    required this.endDate,
  });

  final String endDate;
  final String endTime;
  final String startDate;
  final String startTime;
  final String totalTime;

  @override
  State<BookingSelectDetail> createState() => _BookingSelectDetailState();
}

class _BookingSelectDetailState extends State<BookingSelectDetail> {
  Widget renderStartTimeEndTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextLabel(
              text: translate('booking_page.detail.start_time'),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.little),
            ),
            TextLabel(
              text: '${widget.startTime}',
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.xxl),
              fontWeight: FontWeight.bold,
              color: AppTheme.black,
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 12),
            SvgPicture.asset(
              ImageAsset.ic_booking,
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextLabel(
              text: translate('booking_page.detail.end_time'),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.little),
            ),
            TextLabel(
              text: '${widget.endTime}',
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.xxl),
              fontWeight: FontWeight.bold,
              color: AppTheme.red,
            ),
          ],
        ),
      ],
    );
  }

  Widget renderTotalTime() {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          renderDashline(),
          TextLabel(
            text: '${widget.totalTime}',
            color: AppTheme.black,
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.big),
            fontWeight: FontWeight.bold,
          ),
          renderDashline(),
        ],
      ),
    );
  }

  Widget renderStartDateEndDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextLabel(
              text: translate('booking_page.detail.start_date'),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.little),
            ),
            TextLabel(
              text: '${widget.startDate}',
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.large),
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B7280).withOpacity(0.8),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextLabel(
              text: translate('booking_page.detail.end_date'),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.little),
            ),
            TextLabel(
              text: '${widget.endDate}',
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.large),
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B7280).withOpacity(0.8),
            ),
          ],
        ),
      ],
    );
  }

  Widget renderBottomDescription() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Center(
        child: TextLabel(
          text: translate('booking_page.detail.description'),
          fontSize: Utilities.sizeFontWithDesityForDisplay(
              context, AppFontSize.small),
        ),
      ),
    );
  }

  Widget renderDashline() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.325,
      child: Flex(
        direction: Axis.vertical,
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final boxWidth = constraints.constrainWidth();
              final double dashHeight = 1;
              final dashCount = (boxWidth / (2 * 5)).floor();
              return Flex(
                children: List.generate(dashCount, (_) {
                  return SizedBox(
                    width: 5,
                    height: dashHeight,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: AppTheme.black20),
                    ),
                  );
                }),
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
              );
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: AppTheme.borderGray,
        ),
      ),
      child: Column(
        children: [
          renderStartTimeEndTime(),
          renderTotalTime(),
          renderStartDateEndDate(),
          renderBottomDescription(),
        ],
      ),
    );
  }
}
