import 'dart:math';
import 'package:animated_styled_widget/animated_styled_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/navigation_service.dart';
import 'package:jupiter/src/presentation/pages/home/home_page.dart';
import 'package:jupiter/src/presentation/widgets/button_progress.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:skeletonizer/skeletonizer.dart';

class IconMenuItem extends StatelessWidget {
  IconMenuItem({
    super.key,
    required this.menuItemData,
    required this.isLoading,
    required this.onTap,
  });

  final MoreMenuItemDataForFleet menuItemData;
  final bool isLoading;
  final Function() onTap;
  final NavigationService navigationService = getIt<NavigationService>();

  double getWidth(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.08;
    return width > 30 ? 30 : width;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(200),
        onTap: isLoading ? () {} : onTap,
        child: Stack(
          children: [
            Container(
              width: (MediaQuery.of(context).size.width / 4) - 5,
              margin: const EdgeInsets.only(top: 5),
              child: Column(
                children: [
                  isLoading
                      ? Skeletonizer(
                          enabled: isLoading,
                          child: Container(
                            width: 60,
                            height: 60,
                            child: Skeleton.leaf(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.black20.withOpacity(0.5),
                                spreadRadius: 0.5,
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          width: 55,
                          height: 55,
                          child: SvgPicture.asset(
                            menuItemData.leadingIconAsset,
                          ),
                        ),
                  const SizedBox(height: 4),
                  Skeletonizer(
                    enabled: isLoading,
                    child: Container(
                      width: double.infinity,
                      child: isLoading
                          ? Bone.text(
                              words: 1,
                              textAlign: TextAlign.center,
                            )
                          : TextLabel(
                              text: menuItemData.name,
                              textAlign: TextAlign.center,
                              color: AppTheme.blueDark,
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.normal),
                              maxLines: 2,
                              textStyleHeight: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: (MediaQuery.of(context).size.width / 4) -
                  (MediaQuery.of(context).size.width * 0.1),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ButtonProgress(
                  visible: menuItemData.isCharging,
                  finish: false,
                  borderWidth: 4,
                  width: getWidth(context).toPXLength,
                  height: getWidth(context).toPXLength,
                  gradient: const SweepGradient(startAngle: pi, colors: [
                    AppTheme.red,
                    AppTheme.red,
                  ]),
                  onTap: () {},
                  child: SvgPicture.asset(
                    ImageAsset.ic_car_charging,
                    color: AppTheme.red,
                    width: getWidth(context) - (getWidth(context) / 2),
                    height: getWidth(context) - (getWidth(context) / 2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
