import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/search_coupon_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class CouponItem extends StatefulWidget {
  CouponItem({
    Key? key,
    required this.data,
    required this.isCollect,
    required this.onTapCouponItem,
    required this.onTapIsCollect,
  }) : super(key: key);
  final SearchCouponItemEntity? data;
  final bool isCollect;
  final Function(BuildContext, SearchCouponItemEntity?) onTapCouponItem;
  final Function(SearchCouponItemEntity?) onTapIsCollect;

  @override
  _CouponItemState createState() => _CouponItemState();
}

class _CouponItemState extends State<CouponItem> {
  getDateFormat(SearchCouponItemEntity? data) {
    try {
      if (data != null) {
        String day = '';
        String yMMM = '';
        if (data.dateEnd != "") {
          DateTime date = DateTime.parse(data.dateEnd).toLocal();
          day = DateFormat('d').format(date);
          yMMM = DateFormat('yMMM').format(date);
        } else {
          day =
              '${data.expiredDate} ${translate("check_in_page.modal_offers.day_after_collected")}';
        }
        return '${translate("check_in_page.modal_offers.expire_date")} $day $yMMM';
      }
    } catch (e) {
      return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: InkWell(
        highlightColor: AppTheme.black5,
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          widget.onTapCouponItem(context, widget.data);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            renderImageItem(widget.data?.couponImage ?? ''),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextLabel(
                    text: '${widget.data?.couponName}',
                    color: AppTheme.black,
                    fontSize: Utilities.sizeFontWithDesityForDisplay(
                        context, AppFontSize.big),
                    fontWeight: FontWeight.bold,
                    maxLines: 1,
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
                          text: '${getDateFormat(widget.data)}',
                          color: AppTheme.gray9CA3AF,
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context,
                            AppFontSize.little,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 32),
              child: InkWell(
                onTap: () {
                  if (!widget.isCollect) {
                    widget.onTapIsCollect(widget.data);
                  }
                },
                child: Material(
                  // elevation: 1,
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color:
                            widget.isCollect ? AppTheme.white : AppTheme.blueD,
                        border: Border.all(color: AppTheme.blueD)),
                    child: TextLabel(
                        text: widget.isCollect
                            ? translate('coupon.coupon_search.button.collected')
                            : translate('coupon.coupon_search.button.collect'),
                        color:
                            widget.isCollect ? AppTheme.blueD : AppTheme.white,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.mini)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderImageItem(String imageUrl) {
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
          ImageAsset.ic_coupons,
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
            image: NetworkImage(imageUrl),
          ),
        ),
      );
    }
  }
}
