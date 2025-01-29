import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/payment_type_has_defalut_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/presentation/widgets/tootip_information.dart';
import 'package:jupiter/src/utilities.dart';

class SelectPayment extends StatefulWidget {
  const SelectPayment({
    Key? key,
    required this.error,
    required this.indexSelected,
    required this.listItemPayment,
    required this.onSelectPayment,
    required this.onClickAddCard,
    required this.fromFleet,
  }) : super(key: key);

  final bool error;
  final int indexSelected;
  final List<PaymentTypeHasDefalutEntity> listItemPayment;
  final Function(int) onSelectPayment;
  final Function() onClickAddCard;
  final bool fromFleet;

  @override
  _SelectPaymentState createState() => _SelectPaymentState();
}

class _SelectPaymentState extends State<SelectPayment> {
  @override
  void initState() {
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  double buttonChargingEnergyHeight = 45;
  double spaceLineHeight = 16;
  double widthSelector = 0.25;
  double widthSizedbox = 0.15;
  double heightItem = 35;

  bool isSelected(int index) {
    return widget.indexSelected == index;
  }

  String formatCreditCardDisplay(String display) {
    if (widget.fromFleet == true) {
      try {
        return display.substring(display.length - 4);
      } catch (e) {
        return display;
      }
    } else {
      return display;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        children: [
          SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    TextLabel(
                        text: translate("check_in_page.select_payment.payment"),
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.big),
                        fontWeight: FontWeight.bold,
                        color: AppTheme.blueDark),
                    const SizedBox(width: 10),
                    TooltipInformation(
                      message: translate("check_in_page.information"),
                    ),
                  ]),
                  const SizedBox(height: 5),
                  Container(
                    child: _listSelectorVehicle(),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget _imagePaymentFormType(String type, int index) {
    return Container(
      width: 80,
      height: 60,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppTheme.white,
        border: Border.all(
          color: isSelected(index) ? AppTheme.lightBlue : AppTheme.white,
          width: isSelected(index) ? 1 : 0,
        ),
      ),
      child: Utilities.assetCreditCard(
          cardBrand: type, defaultCard: ImageAsset.card_default_logo),
    );
  }

  Widget _listSelectorVehicle() {
    return SizedBox(
        height: 90,
        width: double.infinity,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: widget.listItemPayment.length + 1,
          separatorBuilder: (context, index) => const SizedBox(width: 16),
          itemBuilder: (context, index) => _renderItemPayment(index),
        ));
  }

  Widget _renderItemPayment(int index) {
    if (index == widget.listItemPayment.length) {
      if (widget.fromFleet) {
        return SizedBox();
      } else {
        return _addPayment();
      }
    } else {
      return _itemPayment(index);
    }
  }

  Widget _itemPayment(int value) {
    return Container(
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: GestureDetector(
            onTap: () {
              widget.onSelectPayment(value);
            },
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _imagePaymentFormType(
                      widget.listItemPayment[value].brand ?? '', value),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 16,
                    child: Center(
                      child: TextLabel(
                          text: formatCreditCardDisplay(
                              widget.listItemPayment[value].display ?? ''),
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.small),
                          fontWeight: FontWeight.bold,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          color: isSelected(value)
                              ? AppTheme.lightBlue
                              : AppTheme.gray9CA3AF),
                    ),
                  )
                ],
              ),
            )));
  }

  Widget _addPayment() {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: GestureDetector(
        onTap: widget.onClickAddCard,
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DottedBorder(
                color: widget.error ? AppTheme.red : AppTheme.gray9CA3AF,
                strokeWidth: 1,
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                dashPattern: const [6, 6],
                child: Container(
                    width: 78,
                    height: 56,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: TextLabel(
                        text:
                            translate("check_in_page.select_payment.add_card"),
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.small),
                        fontWeight: FontWeight.bold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        color:
                            widget.error ? AppTheme.red : AppTheme.gray9CA3AF,
                      ),
                    )),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
