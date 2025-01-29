import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';

class NotificationTab extends StatefulWidget {
  const NotificationTab({
    Key? key,
    required this.title,
    required this.selectedTab,
    required this.index,
    required this.countRead,
  }) : super(key: key);

  final String title;
  final int selectedTab;
  final int index;
  final int countRead;

  @override
  State<NotificationTab> createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: SizedBox.expand(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                  (widget.index == 0)
                      ? ImageAsset.ic_noti_news_promotion
                      : ImageAsset.ic_noti_system,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                      (widget.selectedTab == widget.index
                          ? AppTheme.blueDark
                          : AppTheme.gray9CA3AF),
                      BlendMode.srcIn)),
              const SizedBox(width: 8),
              TextLabel(
                text: widget.title,
                color: (widget.selectedTab == widget.index
                    ? AppTheme.blueDark
                    : AppTheme.gray9CA3AF),
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.large),
                fontWeight: FontWeight.bold,
              ),
              Visibility(
                  visible: (widget.countRead > 0), child: SizedBox(width: 8)),
              Visibility(
                visible: (widget.countRead > 0),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: CircleAvatar(
                    backgroundColor: AppTheme.red80,
                    radius: 4,
                  ),
                ),
              )
            ],
          ),
          decoration: BoxDecoration(color: AppTheme.white),
        ),
      ),
    );
  }
}
