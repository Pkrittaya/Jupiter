import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/billing_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';

class ProfileAddTaxInvoice extends StatefulWidget {
  const ProfileAddTaxInvoice({
    super.key,
    required this.onPressedItemTaxInvoice,
    required this.onPressedAddTaxInvoice,
    required this.listItem,
    required this.onSlide,
  });
  final List<BillingEntity> listItem;
  final Function(int) onPressedItemTaxInvoice;
  final Function() onPressedAddTaxInvoice;
  final Function(BillingEntity) onSlide;
  @override
  _ProfileAddTaxInvoiceState createState() => _ProfileAddTaxInvoiceState();
}

class _ProfileAddTaxInvoiceState extends State<ProfileAddTaxInvoice> {
  String formatIDCard(String text) {
    final List<String> parts = [];

    for (int i = 0; i < text.length; i++) {
      final String char = text[i];
      if (i == 1 || i == 5 || i == 10 || i == 12) {
        parts.add('-');
      }
      if (char != '-') {
        parts.add(char);
      }
    }

    final String formattedText = parts.join('');
    return formattedText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      color: AppTheme.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextLabel(
            text: translate('profile_edit_page.tax_invoice.title_button'),
            color: AppTheme.blueDark,
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.little),
          ),
          const SizedBox(height: 8),
          renderItemTax()
        ],
      ),
    );
  }

  Widget renderButtonAddTax() {
    return Container(
      child: InkWell(
        onTap: widget.onPressedAddTaxInvoice,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1,
              color: AppTheme.blueD,
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.add, color: AppTheme.blueD, size: AppFontSize.title),
              SizedBox(width: 12),
              Expanded(
                child: TextLabel(
                  text: translate('profile_edit_page.tax_invoice.text_button'),
                  color: AppTheme.blueD,
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.big),
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderItemTax() {
    List<Widget> item = [];
    for (int i = 0; i < widget.listItem.length; i++) {
      item.add(
        InkWell(
          onTap: () {
            widget.onPressedItemTaxInvoice(i);
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              Slidable(
                key: ValueKey(widget.listItem[i].billingId),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio:
                      70 * 100 / MediaQuery.of(context).size.width / 100,
                  children: [
                    // SlidableInListView(
                    //   onPressed: (context) {
                    //     widget.onSlide(widget.listItem[i]);
                    //   },
                    //   borderRadius: BorderRadius.only(
                    //     topRight: Radius.circular(12),
                    //     bottomRight: Radius.circular(12),
                    //   ),
                    //   backgroundColor: AppTheme.red,
                    //   foregroundColor: AppTheme.black,
                    //   icon: Icons.delete,
                    //   iconsize: 40,
                    //   // label: 'Delete',
                    // ),
                    ElevatedButton(
                      onPressed: () {
                        widget.onSlide(widget.listItem[i]);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.all(10),
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ],
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: AppTheme.borderGray,
                    ),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(ImageAsset.ic_tax_item),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: TextLabel(
                                text: '${widget.listItem[i].billingName}',
                                color: AppTheme.blueDark,
                                fontSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                        context, AppFontSize.big),
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            TextLabel(
                              text:
                                  '${formatIDCard(widget.listItem[i].billingId)}',
                              color: AppTheme.gray9CA3AF,
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.little),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: widget.listItem[i].billingDefault
                            ? Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(200),
                                    color: AppTheme.lightBlue10),
                                child: TextLabel(
                                  text: translate(
                                      'tax_invoice_page.hint.default'),
                                  color: AppTheme.blueDark,
                                  fontSize:
                                      Utilities.sizeFontWithDesityForDisplay(
                                          context, AppFontSize.little),
                                ),
                              )
                            : SizedBox(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8)
            ],
          ),
        ),
      );
    }
    item.add(renderButtonAddTax());
    return Column(children: item);
  }
}
