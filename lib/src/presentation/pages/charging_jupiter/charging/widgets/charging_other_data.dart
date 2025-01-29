import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/charging/widgets/low_priority.dart';
import 'package:jupiter_api/domain/entities/payment_type_has_defalut_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';

class ChargingOtherData extends StatefulWidget {
  const ChargingOtherData({
    Key? key,
    required this.location,
    required this.chargerName,
    required this.chargerType,
    required this.chargerID,
    required this.chargerIndex,
    required this.chargingMode,
    required this.chargingPrice,
    required this.chargingPower,
    required this.creditCardType,
    required this.creditCardNumber,
    required this.isLoadingListPayment,
    required this.isErrorPayment,
    required this.listPaymentItem,
    required this.onShowModalSelectPayment,
    required this.isLowPriority,
    this.couponTitle,
    this.fromFleet,
  }) : super(key: key);

  final String location;
  final String chargerName;
  final String chargerType;
  final String chargerID;
  final String chargerIndex;
  final String chargingMode;
  final String chargingPrice;
  final String chargingPower;
  final String creditCardType;
  final String creditCardNumber;
  final bool isLoadingListPayment;
  final bool isErrorPayment;
  final List<PaymentTypeHasDefalutEntity> listPaymentItem;
  final bool isLowPriority;
  final String? couponTitle;
  final Function() onShowModalSelectPayment;
  final bool? fromFleet;

  @override
  _ChargingOtherDataState createState() => _ChargingOtherDataState();
}

class _ChargingOtherDataState extends State<ChargingOtherData> {
  double widthHalf = 0.45;
  double widthTextIcon = 0.29;
  double widthText = 0.4;
  double widthTitleText = 0.38;
  double whiteSpace = 4.0;

  @override
  void initState() {
    super.initState();
  }

  isHightSpeed() {
    return widget.chargingMode == 'hightspeed';
  }

  String getLastFourCharacter() {
    if (widget.creditCardNumber != '') {
      return widget.creditCardNumber
          .substring(widget.creditCardNumber.length - 4);
    } else {
      return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_chargerInformation(context), _otherCar(context)],
    );
  }

  Widget _chargerInformation(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      constraints: const BoxConstraints(maxHeight: 180),
      width: width * widthHalf,
      padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.grayD4A50),
          color: AppTheme.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 25,
            alignment: Alignment.centerLeft,
            width: width * widthTitleText,
            child: TextLabel(
              text: translate('charging_page.charging_other.information'),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.normal),
              fontWeight: FontWeight.bold,
              color: AppTheme.gray9CA3AF,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.location_pin,
                        color: AppTheme.blueDark,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: width * widthHalf - 56,
                      child: TextLabel(
                        text: widget.location,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.normal),
                        fontWeight: FontWeight.bold,
                        color: AppTheme.blueDark,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
                SizedBox(height: widget.isLowPriority ? 0 : 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        ImageAsset.ic_charger_energy,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: width * widthHalf - 56,
                      child: TextLabel(
                        text: widget.chargerName,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.normal),
                        color: AppTheme.blueDark,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: widget.isLowPriority ? 0 : 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        ImageAsset.ic_ac_type_lightblue,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: width * widthHalf - 56,
                      child: TextLabel(
                        text: widget.chargerType,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.normal),
                        color: AppTheme.blueDark,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: widget.isLowPriority ? 0 : 4),
                Visibility(
                  visible: widget.isLowPriority,
                  child: LowPriority(),
                ),
              ],
            )),
          )
        ],
      ),
    );
  }

  Widget _otherCar(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 180),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _chargerSpeed(context),
          _chargerCreditCard(context),
          _chargerCoupon(context),
        ],
      ),
    );
  }

  Widget _chargerSpeed(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    String type = '';
    if (isHightSpeed()) {
      type = 'Hight Speed Charging';
    } else {
      type = 'Standard Charging';
    }
    return Container(
      width: width * widthHalf,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.grayD4A50),
          color: AppTheme.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _renderIconHightSpeed(),
              SizedBox(
                width: isHightSpeed()
                    ? width * (widthTextIcon + 0.05)
                    : width * widthText,
                child: TextLabel(
                  textAlign: TextAlign.center,
                  text: type,
                  fontWeight: FontWeight.bold,
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.big),
                  color: AppTheme.blueDark,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          const SizedBox(height: 3),
          Container(
            width: width * widthText,
            child: TextLabel(
              textAlign: TextAlign.center,
              text: 'Power ${widget.chargingPower} ● ${widget.chargingPrice}',
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.little),
              color: AppTheme.blueDark,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  Widget _chargerCreditCard(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if (widget.isLoadingListPayment) {
      return Container(
        width: width * widthHalf,
        height: 40,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.grayD4A50),
            color: AppTheme.white),
        child: const Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: AppTheme.blueD,
              strokeCap: StrokeCap.round,
            ),
          ),
        ),
      );
    } else if (widget.isErrorPayment || widget.listPaymentItem.length == 0) {
      return Container(
        width: width * widthHalf,
        height: 40,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.grayD4A50),
            color: AppTheme.white),
        child: Center(
          child: TextLabel(
            text: translate('charging_page.error_load_creditcard'),
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.little),
            fontWeight: FontWeight.bold,
            color: AppTheme.blueDark,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    } else {
      return Material(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            if (widget.fromFleet != true) {
              widget.onShowModalSelectPayment();
            }
          },
          child: Container(
            width: width * widthHalf,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.grayD4A50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _renderIconCreditCard(),
                    Container(
                        padding: const EdgeInsets.only(left: 8),
                        width: width * 0.24,
                        child: TextLabel(
                          text: getLastFourCharacter(),
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.big),
                          fontWeight: FontWeight.bold,
                          color: AppTheme.blueDark,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ))
                  ],
                ),
                Visibility(
                  visible: widget.fromFleet != true,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppTheme.blueDark,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _chargerCoupon(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    if (widget.fromFleet != true) {
      return Container(
        width: width * widthHalf,
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.grayD4A50),
            color: AppTheme.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 20,
              child: SvgPicture.asset(
                ImageAsset.ic_coupon_selected,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: width * (widthTextIcon),
              child: TextLabel(
                text: widget.couponTitle == null || widget.couponTitle == ''
                    ? translate('charging_page.coupon.no_coupon')
                    : '${widget.couponTitle}',
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.little),
                color: AppTheme.blueDark,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      );
    } else {
      return SizedBox(height: 40);
    }
  }

  Widget _renderIconHightSpeed() {
    if (isHightSpeed()) {
      return Padding(
        padding: const EdgeInsets.only(right: 2),
        child: SvgPicture.asset(
          ImageAsset.ic_crown,
          width: 20,
          height: 20,
        ),
      );
    }
    return const SizedBox();
  }

  Widget _renderIconCreditCard() {
    return Container(
      width: 32,
      height: 22,
      child: Utilities.assetCreditCard(
          cardBrand: widget.creditCardType,
          defaultCard: ImageAsset.card_default_logo),
    );
  }
}
