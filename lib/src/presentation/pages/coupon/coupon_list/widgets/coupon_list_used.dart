import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/pages/coupon/coupon_list/widgets/coupon_loading_item.dart';
import 'package:jupiter_api/domain/entities/coupon_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/coupon_detail/coupon_detail_page.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
class CouponListUsed extends StatefulWidget {
  CouponListUsed({
    Key? key,
    required this.usedCoupon,
    required this.getDateFormat,
    required this.loading,
  }) : super(key: key);

  final List<CouponItemEntity>? usedCoupon;
  final Function(DateTime) getDateFormat;
  final bool loading;
  @override
  _CouponListUsedState createState() => _CouponListUsedState();
}

class _CouponListUsedState extends State<CouponListUsed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
      ),
      child: Column(
        children: [renderUsedAll(widget.usedCoupon)],
      ),
    );
  }

  Widget renderUsedAll(List<CouponItemEntity>? listData) {
    List<Widget> items = [];
    for (int i = 0; i < listData!.length; i++) {
      items.add(renderUsedItem(data: listData[i]));
    }
    if (items.length > 0 && !widget.loading) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: SingleChildScrollView(
            child: Column(
          children: items,
        )),
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
        height: MediaQuery.of(context).size.height * 0.8,
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

  Widget renderUsedItem({required CouponItemEntity data}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Material(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(5),
            child: InkWell(
              highlightColor: AppTheme.black5,
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CouponDetailPage(
                      couponID: data.couponCode,
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(
                    top: 16, left: 12, right: 12, bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    renderImageItem(data.couponImage, 'Used'),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextLabel(
                            text: data.couponName,
                            color: AppTheme.black,
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, AppFontSize.big),
                            fontWeight: FontWeight.bold,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
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
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            height: 1,
            color: AppTheme.borderGray,
          )
        ],
      ),
    );
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
