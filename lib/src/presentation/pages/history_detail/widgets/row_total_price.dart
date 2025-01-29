import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class RowTotalPrice extends StatefulWidget {
  const RowTotalPrice({
    super.key,
    required this.hasBgImage,
    required this.total,
    this.isBooking,
  });

  final bool hasBgImage;
  final String total;
  final bool? isBooking;

  @override
  State<RowTotalPrice> createState() => _RowTotalPriceState();
}

class _RowTotalPriceState extends State<RowTotalPrice> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            constraints: BoxConstraints(
                maxWidth: Utilities.sizeFontWithDesityForDisplay(
              context,
              140,
            )),
            child: Align(
              alignment: widget.isBooking != true
                  ? Alignment.centerLeft
                  : Alignment.center,
              child: SvgPicture.asset(
                widget.isBooking != true
                    ? ImageAsset.car_charging_station
                    : ImageAsset.ic_receipt_booking_jupiter,
                height: Utilities.sizeFontWithDesityForDisplay(context, 82),
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextLabel(
                text: translate("charging_page.summary_step.total"),
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context,
                  20,
                ),
                fontWeight: FontWeight.w400,
                color: widget.hasBgImage ? AppTheme.white : AppTheme.black60,
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: TextLabel(
                  text: widget.total,
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context,
                    32,
                  ),
                  fontWeight: FontWeight.w700,
                  color:
                      widget.hasBgImage ? AppTheme.white : AppTheme.lightBlue,
                ),
              ),
              // TextLabel(
              //   text: "",
              //   fontSize: Utilities.sizeFontWithDesityForDisplay(
              //     context,
              //     20,
              //   ),
              //   fontWeight: FontWeight.w400,
              //   color: widget.hasBgImage ? AppTheme.white : AppTheme.black60,
              // ),
            ],
          ),
        )
      ],
    );
  }
}
