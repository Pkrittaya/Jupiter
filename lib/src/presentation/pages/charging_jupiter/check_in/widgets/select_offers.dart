import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/search_coupon_for_used_entity.dart';
import 'package:jupiter/src/presentation/widgets/tootip_information.dart';
import 'package:jupiter/src/utilities.dart';

import '../../../../../apptheme.dart';
import '../../../../widgets/text_label.dart';
import 'modal_bottom_offer.dart';

class SelectOffer extends StatefulWidget {
  const SelectOffer(
      {Key? key,
      required this.listItemOffer,
      required this.onSelectCouponOffer,
      this.ItemOffer})
      : super(key: key);

  final List<SearchCouponItemForUsedEntity> listItemOffer;
  final Function(SearchCouponItemForUsedEntity?) onSelectCouponOffer;
  final SearchCouponItemForUsedEntity? ItemOffer;

  @override
  State<SelectOffer> createState() => _SelectOfferState();
}

class _SelectOfferState extends State<SelectOffer> {
  bool isCanUse = true;
  @override
  Widget build(BuildContext context) {
    isCanUse = widget.ItemOffer?.statusCanUse ?? true;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          TextLabel(
              text: translate("check_in_page.select_offers.offers"),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.big),
              fontWeight: FontWeight.bold,
              color: AppTheme.blueDark),
          const SizedBox(width: 10),
          TooltipInformation(
            message: translate("check_in_page.information"),
          ),
        ]),
        const Expanded(child: SizedBox()),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: TextButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12))),
                builder: (BuildContext context) {
                  return ModalBottomOffer(
                    listItemOffer: widget.listItemOffer,
                    controllerTextSearch: TextEditingController(),
                    // handlerSearchOfferItem: (String textSearch) {},
                    onSelectCouponOffer: widget.onSelectCouponOffer,
                    ItemOffer: widget.ItemOffer,
                  );
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: (isCanUse ? false : true),
                  child: TextLabel(
                    text:
                        translate("check_in_page.select_offers.not_available"),
                    color: AppTheme.red,
                    fontSize: Utilities.sizeFontWithDesityForDisplay(
                        context, AppFontSize.mini),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    decoration: (isCanUse)
                        ? BoxDecoration()
                        : BoxDecoration(
                            border: Border.all(color: AppTheme.red),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextLabel(
                            text: widget.ItemOffer == null
                                ? translate(
                                    "check_in_page.select_offers.apply_coupon")
                                : widget.ItemOffer!.couponName,
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, AppFontSize.big),
                            color: AppTheme.black40,
                            fontWeight: FontWeight.w400,
                            textAlign:
                                (isCanUse) ? TextAlign.end : TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: AppTheme.lightBlue,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
