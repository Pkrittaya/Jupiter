import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/history_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/history/widgets/history_header.dart';
import 'package:jupiter/src/presentation/pages/history/widgets/history_list_item.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HistoryListCharging extends StatefulWidget {
  HistoryListCharging({
    Key? key,
    required this.historyEntity,
    required this.loading,
  }) : super(key: key);

  final HistoryEntity? historyEntity;
  final bool loading;
  @override
  _HistoryListChargingState createState() => _HistoryListChargingState();
}

class _HistoryListChargingState extends State<HistoryListCharging> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          HistoryHeader(
            loading: widget.loading,
            total_charging: (widget.historyEntity?.totalCharging != null)
                ? Utilities.formatMoney(
                    '${widget.historyEntity?.totalCharging}', 3)
                : "-",
            instead_of_trees: (widget.historyEntity?.insteadOfTrees != null)
                ? Utilities.formatMoney(
                    '${widget.historyEntity?.insteadOfTrees}', 0)
                : "-",
          ),
          const SizedBox(height: 8),
          Expanded(child: renderListHistory()),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget renderListHistory() {
    if (widget.historyEntity != null &&
        widget.historyEntity!.data.length > 0 &&
        !widget.loading) {
      return NotificationListener<OverscrollIndicatorNotification>(
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
          itemCount: widget.historyEntity?.data.length ?? 0,
          itemBuilder: (context, index) {
            final item = widget.historyEntity!.data[index];
            return HistoryListItem(data: item);
          },
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
        itemCount: 8,
        itemBuilder: (context, index) {
          return Skeletonizer(
            enabled: true,
            child: Container(
              padding: EdgeInsets.fromLTRB(8, 4, 8, 8),
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
