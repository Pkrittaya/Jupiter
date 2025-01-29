import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/history_booking_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/history_detail/history_booking_detail_page.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';

class HistoryBookingListItem extends StatelessWidget {
  const HistoryBookingListItem({
    super.key,
    required this.data,
  });

  final HistoryBookingEntity data;

  String getDateFormat() {
    try {
      DateTime dateTime = DateTime.parse(data.timeStamp.toString()).toLocal();
      return DateFormat('dd MMM yyyy').format(dateTime);
    } catch (e) {
      return 'N/A';
    }
  }

  String getDateTimeFormat() {
    try {
      DateTime dateTime = DateTime.parse(data.timeStamp.toString()).toLocal();
      return DateFormat('HH:mm').format(dateTime);
    } catch (e) {
      return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: AppTheme.transparent,
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HistoryBookingDetailPage(
              reserveOn: data.reserveOn.toInt(),
            ),
          ),
        );
      },
      child: Ink(
        decoration: BoxDecoration(
          color: AppTheme.white,
        ),
        child: Container(
          decoration: BoxDecoration(),
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: SvgPicture.asset(
                  ImageAsset.ic_history_list_item,
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextLabel(
                      text: data.stationName,
                      color: AppTheme.blueDark,
                      fontWeight: FontWeight.bold,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.big),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        TextLabel(
                          text: getDateFormat() + ' • ' + getDateTimeFormat(),
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.little),
                          color: AppTheme.gray9CA3AF,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextLabel(
                    text:
                        "${Utilities.formatMoney('${data.totalPrice}', 2)} ${data.totalPriceUnit}",
                    color: AppTheme.blueD,
                    fontWeight: FontWeight.bold,
                    fontSize: Utilities.sizeFontWithDesityForDisplay(
                        context, AppFontSize.big),
                  ),
                  const TextLabel(
                    text: "",
                    color: AppTheme.darkBlue,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
