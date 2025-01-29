import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HistoryHeader extends StatelessWidget {
  const HistoryHeader({
    super.key,
    required this.loading,
    this.total_charging = '-',
    this.instead_of_trees = '-',
  });

  final bool loading;
  final String total_charging;
  final String instead_of_trees;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppTheme.white,
        border: Border.all(
          color: AppTheme.grayD1D5DB,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            const SizedBox(width: 24),
            SvgPicture.asset(
              ImageAsset.ic_history_total_charging,
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: !loading
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextLabel(
                          text:
                              '${total_charging} ${total_charging != '-' ? 'kWh' : ''}',
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.big),
                          fontWeight: FontWeight.bold,
                          color: AppTheme.blueD,
                        ),
                        const SizedBox(width: 8),
                        TextLabel(
                          text: translate('history_page.total_charging'),
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.small),
                          fontWeight: FontWeight.normal,
                          color: AppTheme.gray9CA3AF,
                        )
                      ],
                    )
                  : Skeletonizer(
                      enabled: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Bone.text(
                            words: 1,
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context,
                              AppFontSize.mini,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Bone.text(
                            words: 1,
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context,
                              8,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            Container(
              height: 30,
              width: 1,
              color: AppTheme.lightBlue40,
            ),
            const SizedBox(width: 24),
            SvgPicture.asset(
              ImageAsset.ic_history_total_tree,
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: !loading
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextLabel(
                          text:
                              '${instead_of_trees} ${instead_of_trees != '-' ? translate('history_page.unit') : ''}',
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.big),
                          fontWeight: FontWeight.bold,
                          color: AppTheme.green,
                        ),
                        const SizedBox(width: 8),
                        TextLabel(
                          text: translate('history_page.instead_trees'),
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.small),
                          fontWeight: FontWeight.normal,
                          color: AppTheme.gray9CA3AF,
                        )
                      ],
                    )
                  : Skeletonizer(
                      enabled: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Bone.text(
                            words: 1,
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context,
                              AppFontSize.mini,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Bone.text(
                            words: 1,
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context,
                              8,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
