import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/pages/coupon/coupon_list/widgets/coupon_loading_item.dart';
import 'package:jupiter_api/domain/entities/coupon_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
class CouponListActive extends StatefulWidget {
  CouponListActive({
    Key? key,
    required this.myCoupon,
    required this.onPressedCouponSearch,
    required this.onTapCouponDetail,
    required this.getDateFormat,
    required this.loading,
  }) : super(key: key);

  final List<CouponItemEntity>? myCoupon;
  final Function(BuildContext) onPressedCouponSearch;
  final Function(BuildContext, CouponItemEntity) onTapCouponDetail;
  final Function(DateTime) getDateFormat;
  final bool loading;
  @override
  _CouponListActiveState createState() => _CouponListActiveState();
}

class _CouponListActiveState extends State<CouponListActive> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(height: 48),
              child: OutlinedButton(
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: AppTheme.gray9CA3AF,
                    ),
                    SizedBox(width: 10),
                    TextLabel(
                      text: translate('coupon.coupon_list.search_coupon'),
                      color: AppTheme.gray9CA3AF,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.large),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200),
                    ),
                    side: const BorderSide(
                      color: AppTheme.grayD4A50,
                    )),
                onPressed: () {
                  widget.onPressedCouponSearch(context);
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(color: AppTheme.grayF1F5F9, height: 12),
          renderActiveAll(widget.myCoupon),
        ],
      ),
    );
  }

  Widget renderActiveItem({required CouponItemEntity data}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      // color: AppTheme.gray9CA3AF,
      child: Column(
        children: [
          Material(
            color: AppTheme.white,
            child: InkWell(
              highlightColor: AppTheme.black5,
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                widget.onTapCouponDetail(context, data);
              },
              child: Container(
                padding: const EdgeInsets.only(
                    top: 16, left: 12, right: 12, bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    renderImageItem(data.couponImage, 'Active'),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextLabel(
                            text: data.couponName,
                            color: AppTheme.blueDark,
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, AppFontSize.big),
                            fontWeight: FontWeight.bold,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.date_range,
                                color: AppTheme.gray9CA3AF,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: TextLabel(
                                    text:
                                        '${widget.getDateFormat(data.dateEnd)}',
                                    color: AppTheme.gray9CA3AF,
                                    fontSize:
                                        Utilities.sizeFontWithDesityForDisplay(
                                      context,
                                      AppFontSize.little,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(height: 1, color: AppTheme.borderGray)
        ],
      ),
    );
  }

  Widget renderActiveAll(List<CouponItemEntity>? listData) {
    List<Widget> items = [];
    for (int i = 0; i < listData!.length; i++) {
      items.add(renderActiveItem(data: listData[i]));
    }
    if (items.length > 0 && !widget.loading) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.65,
        child: SingleChildScrollView(
          child: Column(
            children: items,
          ),
        ),
      );
    } else if (widget.loading) {
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.65,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CouponLoadingItem(),
              CouponLoadingItem(),
              CouponLoadingItem(),
              CouponLoadingItem(isLast: true),
            ],
          ),
        ),
      );
    } else {
      return Container(
        height: MediaQuery.of(context).size.height * 0.65,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageAsset.img_coupon_empty,
              width: 130,
              height: 130,
            ),
            SizedBox(height: 8),
            TextLabel(
              text: translate('empty.coupon'),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.superlarge),
              color: AppTheme.black40,
            )
          ],
        ),
      );
    }
  }

  renderImageItem(String imageUrl, String tap) {
    if (imageUrl == '') {
      return Container(
        width: 70,
        height: 70,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(3),
        ),
        child: SvgPicture.asset(
          (tap == 'Active')
              ? ImageAsset.ic_coupons
              : ImageAsset.ic_coupons_disable,
        ),
      );
    } else {
      return Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(3),
          image: DecorationImage(
            fit: BoxFit.fill,
            colorFilter: new ColorFilter.mode(
                AppTheme.black.withOpacity((tap == 'Active') ? 0 : 1),
                BlendMode.color),
            image: NetworkImage(imageUrl),
          ),
        ),
      );
    }
  }
}
