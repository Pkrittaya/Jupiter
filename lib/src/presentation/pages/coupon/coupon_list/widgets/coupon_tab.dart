import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class CouponTab extends StatefulWidget {
  CouponTab({
    Key? key,
    required this.title,
    required this.selectedTab,
    required this.index,
  }) : super(key: key);

  final String title;
  final int selectedTab;
  final int index;
  @override
  _CouponTabState createState() => _CouponTabState();
}

class _CouponTabState extends State<CouponTab> {
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: SizedBox.expand(
        child: Container(
          child: Center(
            child: TextLabel(
              text: widget.title,
              color: (widget.selectedTab == widget.index
                  ? AppTheme.blueDark
                  : AppTheme.gray9CA3AF),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.large),
              fontWeight: FontWeight.bold,
            ),
          ),
          decoration: BoxDecoration(color: AppTheme.white),
        ),
      ),
    );
  }
}
