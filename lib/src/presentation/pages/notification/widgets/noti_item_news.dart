import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter_api/domain/entities/notification_data_news_entity.dart';
import 'package:jupiter_api/domain/entities/notification_entity.dart';
import 'package:jupiter/src/presentation/widgets/slidable_in_listview.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:shimmer/shimmer.dart';

class NotiItemNews extends StatelessWidget {
  const NotiItemNews({
    super.key,
    required this.data,
    required this.onSlideDelete,
    required this.onPressedNotificationDetail,
  });

  final NotificationNewsDataEntity data;
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
        Slidable(
          key: ValueKey(data.notificationIndex),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 70 * 100 / MediaQuery.of(context).size.width / 100,
            children: [
              SlidableInListView(
                key: ValueKey(data.notificationIndex),
                onPressed: (BuildContext context) {
                  onSlideDelete(data.notificationIndex, data.messageType);
                },
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                // backgroundColor: AppTheme.red,
                foregroundColor: AppTheme.black,
                icon: Icons.delete,
                iconsize: 40,
                // label: 'Delete',
              ),
              ElevatedButton(
                onPressed: () {
                  onSlideDelete(data.notificationIndex, data.messageType);
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.all(10),
                ),
                child: const Icon(
                  Icons.delete,
                  color: AppTheme.white,
                  size: 25,
                ),
              ),
            ],
          ),
          child: Material(
            color: AppTheme.white,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                onPressedNotificationDetail(
                    id: data.notificationIndex, dataNews: data);
              },
              child: Container(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    Container(
                      height: 74,
                      width: 74,
                      child: renderImage(data.image),
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
                                width:
                                    MediaQuery.of(context).size.width * 0.625,
                                child: TextLabel(
                                  text: data.messageTitle,
                                  color: AppTheme.blueDark,
                                  fontSize:
                                      Utilities.sizeFontWithDesityForDisplay(
                                          context, AppFontSize.big),
                                  fontWeight: FontWeight.bold,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              !(data.statusRead)
                                  ? CircleAvatar(
                                      backgroundColor: AppTheme.red80,
                                      radius: 4,
                                    )
                                  : const SizedBox()
                            ],
                          ),
                          TextLabel(
                            text: data.messageBody,
                            color: AppTheme.gray9CA3AF,
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, AppFontSize.normal),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          TextLabel(
                            text: getDateFormat(data.messageCreate),
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
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget renderImage(String image) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 74,
            height: 74,
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 1,
                color: AppTheme.borderGray,
              ),
            ),
            child: image != ''
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(11), // Image border
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(48), // Image radius
                      child: Image.network(
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Shimmer.fromColors(
                            baseColor: AppTheme.grayF1F5F9,
                            highlightColor: AppTheme.borderGray,
                            child: Container(
                              height: 20,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        },
                        image,
                      ),
                    ),
                  )
                : SvgPicture.asset(
                    ImageAsset.logo_station,
                  ),
          ),
        ],
      ),
    );
  }
}
