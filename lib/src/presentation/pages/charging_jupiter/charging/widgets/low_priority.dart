import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:super_tooltip/super_tooltip.dart';

class LowPriority extends StatefulWidget {
  const LowPriority({Key? key}) : super(key: key);

  @override
  _LowPriorityState createState() => _LowPriorityState();
}

class _LowPriorityState extends State<LowPriority> {
  final tootipController = SuperTooltipController();
  bool tooltipDistance = false;

  @override
  void initState() {
    super.initState();
  }

  void onPressedTooltip() {
    if (!tooltipDistance) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await tootipController.showTooltip();
        setState(() {
          tooltipDistance = true;
        });
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await tootipController.hideTooltip();
        setState(() {
          tooltipDistance = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                  color: AppTheme.red,
                  borderRadius: BorderRadius.circular(200)),
              padding: const EdgeInsets.all(4),
              child: Center(
                child: SvgPicture.asset(
                  ImageAsset.ic_lightning,
                  width: 16,
                  height: 16,
                  colorFilter: ColorFilter.mode(
                    AppTheme.white,
                    BlendMode.srcIn,
                  ),
                  matchTextDirection: true,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              children: [
                TextLabel(
                  text: translate('check_in_page.low_priority'),
                  color: AppTheme.red,
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.normal),
                ),
                renderToolTip(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget renderToolTip() {
    return GestureDetector(
      onTap: () async {
        await tootipController.hideTooltip();
      },
      child: SuperTooltip(
        left: (MediaQuery.of(context).size.width) * 0.2,
        fadeInDuration: const Duration(milliseconds: 1000),
        showBarrier: true,
        controller: tootipController,
        popupDirection: TooltipDirection.up,
        backgroundColor: AppTheme.black80.withOpacity(0.9),
        arrowTipDistance: 15.0,
        touchThroughAreaCornerRadius: 30,
        barrierColor: AppTheme.transparent,
        shadowColor: AppTheme.transparent,
        content: Container(
          height: 125,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        color: AppTheme.red,
                        borderRadius: BorderRadius.circular(200)),
                    padding: const EdgeInsets.all(4),
                    child: Center(
                      child: SvgPicture.asset(
                        ImageAsset.ic_lightning,
                        width: 18,
                        height: 18,
                        colorFilter: ColorFilter.mode(
                          AppTheme.white,
                          BlendMode.srcIn,
                        ),
                        matchTextDirection: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  TextLabel(
                      text: translate('check_in_page.low_priority'),
                      color: AppTheme.white,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.normal),
                      fontWeight: FontWeight.w700),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () async {
                          await tootipController.hideTooltip();
                        },
                        child: Icon(
                          Icons.close,
                          color: AppTheme.white,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              TextLabel(
                  text: translate('station_details_page.low_priority'),
                  textAlign: TextAlign.left,
                  color: AppTheme.white,
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.normal),
                  fontWeight: FontWeight.w400),
            ],
          ),
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 4),
              width: 13.0,
              height: 13.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.red,
              ),
              child: Icon(
                Icons.question_mark,
                color: AppTheme.white,
                size: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
