import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/notification_data_news_entity.dart';
import 'package:jupiter_api/domain/entities/notification_entity.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class NotiItem extends StatelessWidget {
  const NotiItem({
    super.key,
    required this.data,
    required this.onSlideDelete,
    required this.onPressedNotificationDetail,
  });

  final NotiEntity data;
  final Function(int, String) onSlideDelete;
  final Function(
      {required int id,
      NotiEntity? data,
      NotificationNewsDataEntity? dataNews}) onPressedNotificationDetail;

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
    return Column(
      children: [
        Material(
          color: AppTheme.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              onPressedNotificationDetail(
                  id: data.notificationIndex, data: data);
            },
            child: Container(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: !(data.notification.readStatus ?? true)
                        ? AppTheme.orange20
                        : AppTheme.green20,
                    radius: 35,
                    child: Icon(
                      Icons.notifications,
                      color: !(data.notification.readStatus ?? true)
                          ? AppTheme.orange80
                          : AppTheme.green80,
                      size: 40,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.625,
                              child: TextLabel(
                                text: data.notification.title,
                                color: AppTheme.blueDark,
                                fontSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                        context, AppFontSize.big),
                                fontWeight: FontWeight.bold,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            !(data.notification.readStatus ?? true)
                                ? CircleAvatar(
                                    backgroundColor: AppTheme.red80,
                                    radius: 4,
                                  )
                                : const SizedBox()
                          ],
                        ),
                        TextLabel(
                          text: data.notification.body,
                          color: AppTheme.gray9CA3AF,
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.normal),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        TextLabel(
                          text: getDateFormat(
                              data.notification.messageCreate ?? ''),
                          color: AppTheme.gray9CA3AF,
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.small),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
