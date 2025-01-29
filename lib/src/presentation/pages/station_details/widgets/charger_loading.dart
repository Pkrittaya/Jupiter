import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ChargerLoading extends StatefulWidget {
  const ChargerLoading({super.key});

  @override
  State<ChargerLoading> createState() => _ChargerLoadingState();
}

class _ChargerLoadingState extends State<ChargerLoading> {
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.borderGray)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 12, bottom: 4),
                  child: Row(
                    children: [
                      Bone.circle(size: 40),
                      const SizedBox(width: 16),
                      Bone.text(
                        words: 2,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.supermini),
                      ),
                    ],
                  ),
                ),
                renderDivider(4, 4),
                Container(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 8, bottom: 16),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Column(
                          children: [
                            Bone.circle(size: 30),
                            const SizedBox(height: 8),
                            Bone.text(
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, 6),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Bone.text(
                            words: 2,
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, 8),
                          ),
                          const SizedBox(height: 8),
                          Bone.text(
                            words: 3,
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, 8),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget renderDivider(double top, double bottom) {
    return Container(
      height: 1,
      margin: EdgeInsets.only(top: top, bottom: bottom),
      color: AppTheme.borderGray,
    );
  }
}
