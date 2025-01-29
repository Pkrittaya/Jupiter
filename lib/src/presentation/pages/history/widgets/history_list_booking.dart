import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/history_booking_list_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/history/widgets/history_booking_list_item.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HistoryListBooking extends StatefulWidget {
  HistoryListBooking({
    Key? key,
    required this.historyBookingEntity,
    required this.loading,
  }) : super(key: key);

  final HistoryBookingListEntity? historyBookingEntity;
  final bool loading;
  @override
  _HistoryListBookingState createState() => _HistoryListBookingState();
}

class _HistoryListBookingState extends State<HistoryListBooking> {
  @override
  Widget build(BuildContext context) {
    if (widget.historyBookingEntity != null &&
        (widget.historyBookingEntity?.data.length ?? 0) > 0 &&
        !widget.loading) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  height: 0,
                  color: AppTheme.black5,
                ),
              );
            },
            shrinkWrap: true,
            itemCount: widget.historyBookingEntity?.data.length ?? 0,
            itemBuilder: (context, index) {
              final item = widget.historyBookingEntity!.data[index];
              return HistoryBookingListItem(data: item);
            },
          ),
        ),
      );
    } else if (widget.loading) {
      return ListView.separated(
        separatorBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              height: 0,
              color: AppTheme.black5,
            ),
          );
        },
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Skeletonizer(
            enabled: true,
            child: Container(
              margin: EdgeInsets.only(top: index == 0 ? 16 : 0),
              padding: EdgeInsets.fromLTRB(24, 4, 24, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Bone.circle(size: 36),
                  const SizedBox(width: 16, height: 44),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Bone.text(
                        words: 2,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context,
                          AppFontSize.mini,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Bone.text(
                        words: 1,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context,
                          8,
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: const SizedBox()),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Bone.text(words: 1),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            SizedBox(height: 80),
          ],
        ),
      );
    }
  }
}
