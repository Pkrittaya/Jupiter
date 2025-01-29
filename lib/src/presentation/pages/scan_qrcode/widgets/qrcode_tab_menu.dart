import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class QrCodeTabMenu extends StatefulWidget {
  const QrCodeTabMenu({
    super.key,
    required this.fromFleet,
    required this.fleetType,
    required this.tabController,
    required this.indexTab,
    required this.onTapTabMenu,
  });
  final bool? fromFleet;
  final String? fleetType;
  final TabController tabController;
  final int indexTab;
  final Function(int) onTapTabMenu;
  @override
  _QrCodeTabMenuState createState() => _QrCodeTabMenuState();
}

class _QrCodeTabMenuState extends State<QrCodeTabMenu> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: width,
        height: 62,
        margin: const EdgeInsets.only(bottom: 24),
        child: Center(
          child: Container(
            width: width * 0.8,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppTheme.grayD1D5DB,
              borderRadius: BorderRadius.circular(12),
            ),
            child: widget.fromFleet == true &&
                    widget.fleetType == FleetType.CARD
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppTheme.blueD,
                          ),
                          child: TextLabel(
                            text: translate('qrcode_page.button.scan_qr'),
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, AppFontSize.title),
                            color: AppTheme.white,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextLabel(
                            text: translate('qrcode_page.button.enter_code'),
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, AppFontSize.title),
                            color: AppTheme.black80,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                : TabBar(
                    labelPadding: const EdgeInsets.all(8),
                    controller: widget.tabController,
                    onTap: widget.onTapTabMenu,
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
                              text: translate('qrcode_page.button.scan_qr'),
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.title),
                              color: widget.indexTab == 0
                                  ? AppTheme.white
                                  : AppTheme.black80,
                            )
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextLabel(
                              text: translate('qrcode_page.button.enter_code'),
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.title),
                              color: widget.indexTab == 1
                                  ? AppTheme.white
                                  : AppTheme.black80,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
