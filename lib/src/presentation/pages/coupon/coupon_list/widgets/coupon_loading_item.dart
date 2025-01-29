import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CouponLoadingItem extends StatefulWidget {
  CouponLoadingItem({Key? key, this.isLast}) : super(key: key);

  final bool? isLast;
  @override
  _CouponLoadingItemState createState() => _CouponLoadingItemState();
}

class _CouponLoadingItemState extends State<CouponLoadingItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      width: double.infinity,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: AppTheme.grayF1F5F9,
                  highlightColor: AppTheme.borderGray,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppTheme.black5,
                      image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: AssetImage(ImageAsset.img_station_search_png),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Skeletonizer(
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Bone.text(words: 2),
                          const SizedBox(height: 8),
                          Bone.text(
                            words: 1,
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, AppFontSize.supermini),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            height: widget.isLast == true ? 0 : 1,
            width: MediaQuery.of(context).size.width,
            color: AppTheme.borderGray,
          ),
        ],
      ),
    );
  }
}
