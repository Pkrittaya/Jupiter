import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/domain/entities/notification_entity.dart';

class SystemDetail extends StatefulWidget {
  const SystemDetail({
    super.key,
    required this.data,
  });

  final NotiEntity? data;

  @override
  State<SystemDetail> createState() => _SystemDetailState();
}

class _SystemDetailState extends State<SystemDetail> {
  String getDateFormat(String dateFromApi) {
    try {
      if (dateFromApi != '') {
        // DateFormat inputFormat = DateFormat('yyyy/MM/dd HH:mm:ss');
        DateTime dateTime = DateTime.parse(dateFromApi);
        DateFormat outputFormat = DateFormat('dd MMM yyyy HH:mm');
        String outputDate = outputFormat.format(dateTime.toLocal());
        return outputDate; // Output: 20 Jun 2023
      }
      return dateFromApi;
    } catch (e) {
      return dateFromApi;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextLabel(
                  text: widget.data?.notification.title ?? '',
                  color: AppTheme.blueDark,
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.title),
                  fontWeight: FontWeight.w700,
                  // maxLines: 1,
                  // overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 10,
                ),
                TextLabel(
                  text: getDateFormat(
                      widget.data?.notification.messageCreate ?? ''),
                  color: AppTheme.gray9CA3AF,
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.normal),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 10,
                ),
                TextLabel(
                  text: widget.data?.notification.body ?? '',
                  color: AppTheme.gray9CA3AF,
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.big),
                  // maxLines: 1,
                  // overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )),
      ),
    );
  }
}
