import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/payment_type_has_defalut_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/button.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class ModalSelectPayment extends StatefulWidget {
  const ModalSelectPayment({
    Key? key,
    required this.idSelectedPayment,
    required this.listPaymentItem,
    required this.onSelectPayment,
    required this.confirmPayment,
    required this.onPressedAddCards,
  }) : super(key: key);

  final int idSelectedPayment;
  final List<PaymentTypeHasDefalutEntity> listPaymentItem;
  final Function(int) onSelectPayment;
  final Function() confirmPayment;
  final Function() onPressedAddCards;
  @override
  _ModalSelectPaymentState createState() => _ModalSelectPaymentState();
}

class _ModalSelectPaymentState extends State<ModalSelectPayment> {
  int idSelected = 0;
  @override
  void initState() {
    super.initState();
    idSelected = widget.idSelectedPayment;
    debugPrint('${widget.listPaymentItem}');
  }

  final formKey = GlobalKey<FormState>();
  double buttonChargingEnergyHeight = 45;
  double spaceLineHeight = 16;
  double widthSelector = 0.25;
  double widthSizedbox = 0.15;
  double heightItem = 35;

  String getLastFourCharacter(String value) {
    if (value != '') {
      return value.substring(value.length - 4);
    } else {
      return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          height: height * 0.7,
          child: Column(
            children: [
              _headerAndIconClose(),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: TextLabel(
                  text: translate("charging_page.payment.description"),
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.little),
                ),
              ),
              const SizedBox(height: 16),
              _listPaymentItem(),
              _buttonModel()
            ],
          ),
        ));
  }

  Widget _headerAndIconClose() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextLabel(
          text: translate("charging_page.payment.title"),
          fontWeight: FontWeight.bold,
          color: AppTheme.black,
          fontSize: Utilities.sizeFontWithDesityForDisplay(
              context, AppFontSize.title),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: AppTheme.black),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _listPaymentItem() {
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
        // height: height * 0.55,
        height: height * 0.37,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: widget.listPaymentItem.length,
            separatorBuilder: (context, index) => const SizedBox(height: 24),
            itemBuilder: (context, index) => _cardItem(context, index),
          ),
        ));
  }

  Widget _cardItem(BuildContext context, int index) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        widget.onSelectPayment(index);
        setState(() {
          idSelected = index;
        });
      },
      child: InkWell(
        // width: double.infinity,
        // height: 30,
        child: SizedBox(
          width: double.infinity,
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(4),
                  width: width * 0.5,
                  child: Row(
                    children: [
                      _renderIconCreditCard(
                          widget.listPaymentItem[index].brand ?? ''),
                      TextLabel(
                          text: getLastFourCharacter(
                              widget.listPaymentItem[index].display ?? ''),
                          maxLines: 2,
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.normal),
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.blueDark),
                    ],
                  )),
              Container(
                padding: const EdgeInsets.only(left: 16),
                width: width * 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      shape: const CircleBorder(),
                      // fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: index == idSelected,
                      onChanged: (bool? value) {
                        widget.onSelectPayment(index);
                        setState(() {
                          idSelected = index;
                        });
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderIconCreditCard(String type) {
    return Container(
        width: 32,
        margin: const EdgeInsets.only(right: 8),
        child: Utilities.assetCreditCard(
            cardBrand: type, defaultCard: ImageAsset.card_default_logo));
  }

  Widget _buttonModel() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Button(
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                shadowColor: Colors.transparent,
                backgroundColor: AppTheme.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(200)),
                  side: BorderSide(color: AppTheme.blueD),
                ),
              ),
              text: translate('receipt_page.modal_payment.add_card'),
              onPressed: () {
                widget.onPressedAddCards();
              },
              textColor: AppTheme.blueD,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            child: Button(
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                shadowColor: Colors.transparent,
                backgroundColor: AppTheme.blueD,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(200)),
                ),
              ),
              text: translate('receipt_page.modal_payment.confirm'),
              onPressed: () {
                widget.confirmPayment();
              },
              textColor: AppTheme.white,
            ),
          ),
        ],
      ),
    );
  }
}
