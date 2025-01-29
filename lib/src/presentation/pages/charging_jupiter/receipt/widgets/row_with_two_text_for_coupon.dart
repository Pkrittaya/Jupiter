import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class RowWithTwoTextForCoupon extends StatelessWidget {
  const RowWithTwoTextForCoupon(
      {super.key, required this.statusUseCoupon, required this.couponDiscount});
  final bool statusUseCoupon;
  final String couponDiscount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            TextLabel(
              maxLines: 1,
              text: translate('receipt_page.coupon_discount'),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                context,
                20,
              ),
              color: statusUseCoupon ? AppTheme.blueDark : AppTheme.red,
            ),
            !statusUseCoupon
                ? Row(
                    children: [
                      TextLabel(
                        maxLines: 1,
                        text: ' ( ',
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context,
                          20,
                        ),
                        color:
                            statusUseCoupon ? AppTheme.blueDark : AppTheme.red,
                      ),
                      Icon(
                        Icons.cancel,
                        color: AppTheme.red,
                        size: 10.0,
                      ),
                      TextLabel(
                        maxLines: 1,
                        text:
                            ' ${translate('receipt_page.coupon_not_available')}',
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context,
                          20,
                        ),
                        color:
                            statusUseCoupon ? AppTheme.blueDark : AppTheme.red,
                      ),
                      TextLabel(
                        maxLines: 1,
                        text: ' )',
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context,
                          20,
                        ),
                        color:
                            statusUseCoupon ? AppTheme.blueDark : AppTheme.red,
                      ),
                    ],
                  )
                : SizedBox(),
          ],
        ),
        const Expanded(child: SizedBox()),
        TextLabel(
          maxLines: 1,
          textAlign: TextAlign.end,
          text: statusUseCoupon ? '- $couponDiscount' : '$couponDiscount',
          fontSize: Utilities.sizeFontWithDesityForDisplay(
            context,
            20,
          ),
          color: statusUseCoupon ? AppTheme.blueDark : AppTheme.red,
          fontWeight: FontWeight.w400,
        )
      ],
    );
  }
}
