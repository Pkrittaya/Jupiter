import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';

class InformationType extends StatefulWidget {
  const InformationType({
    super.key,
    required this.isEdit,
    required this.indexType,
    required this.tabController,
    required this.onPressedChangeType,
  });
  final bool isEdit;
  final int indexType;
  final TabController tabController;
  final Function(int index) onPressedChangeType;
  @override
  _InformationTypeState createState() => _InformationTypeState();
}

class _InformationTypeState extends State<InformationType> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextLabel(
            text: translate('tax_invoice_page.title.info'),
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.big),
            color: AppTheme.blueDark,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 12),
          renderTabFromIsEdit(),
          // Container(
          //   decoration: BoxDecoration(
          //     color: AppTheme.white,
          //     borderRadius: BorderRadius.circular(14),
          //     border: Border.all(
          //       width: 1,
          //       color: AppTheme.blueD,
          //     ),
          //   ),
          //   child: TabBar(
          //     controller: widget.tabController,
          //     onTap: widget.onPressedChangeType,
          //     indicator: BoxDecoration(
          //       borderRadius: BorderRadius.circular(12),
          //       color: AppTheme.blueD,
          //     ),
          //     tabs: [
          //       Tab(
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             TextLabel(
          //               text: translate('tax_invoice_page.type.personal'),
          //               fontSize: Utilities.sizeFontWithDesityForDisplay(
          //                   context, AppFontSize.big),
          //               color: widget.indexType == 0
          //                   ? AppTheme.white
          //                   : AppTheme.gray9CA3AF,
          //               fontWeight: FontWeight.bold,
          //             )
          //           ],
          //         ),
          //       ),
          //       Tab(
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             TextLabel(
          //               text: translate('tax_invoice_page.type.corporate'),
          //               fontSize: Utilities.sizeFontWithDesityForDisplay(
          //                   context, AppFontSize.big),
          //               color: widget.indexType == 1
          //                   ? AppTheme.white
          //                   : AppTheme.gray9CA3AF,
          //               fontWeight: FontWeight.bold,
          //             )
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget renderTabFromIsEdit() {
    if (widget.isEdit) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.borderGray,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 48,
              width: MediaQuery.of(context).size.width * 0.455,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: widget.indexType == 0
                      ? AppTheme.blueD
                      : AppTheme.borderGray),
              child: Center(
                child: TextLabel(
                  text: translate('tax_invoice_page.type.personal'),
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.big),
                  color: widget.indexType == 0
                      ? AppTheme.white
                      : AppTheme.gray9CA3AF,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 48,
              width: MediaQuery.of(context).size.width * 0.455,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: widget.indexType == 1
                      ? AppTheme.blueD
                      : AppTheme.borderGray),
              child: Center(
                child: TextLabel(
                  text: translate('tax_invoice_page.type.corporate'),
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.big),
                  color: widget.indexType == 1
                      ? AppTheme.white
                      : AppTheme.gray9CA3AF,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1,
            color: AppTheme.blueD,
          ),
        ),
        child: TabBar(
          controller: widget.tabController,
          onTap: widget.onPressedChangeType,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppTheme.blueD,
          ),
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextLabel(
                    text: translate('tax_invoice_page.type.personal'),
                    fontSize: Utilities.sizeFontWithDesityForDisplay(
                        context, AppFontSize.big),
                    color: widget.indexType == 0
                        ? AppTheme.white
                        : AppTheme.gray9CA3AF,
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextLabel(
                    text: translate('tax_invoice_page.type.corporate'),
                    fontSize: Utilities.sizeFontWithDesityForDisplay(
                        context, AppFontSize.big),
                    color: widget.indexType == 1
                        ? AppTheme.white
                        : AppTheme.gray9CA3AF,
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
