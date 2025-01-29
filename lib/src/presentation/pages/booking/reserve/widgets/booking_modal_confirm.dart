import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/connector_entity.dart';
import 'package:jupiter_api/domain/entities/credit_card_entity.dart';
import 'package:jupiter_api/domain/entities/station_details_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class BookingModalConfirm extends StatefulWidget {
  const BookingModalConfirm({
    super.key,
    required this.onCancelModal,
    required this.onConfirmModal,
    required this.stationData,
    required this.connector,
    required this.startTime,
    required this.endTime,
    required this.totalTime,
    required this.startDate,
    required this.endDate,
    required this.selectedPayment,
    required this.priceReserve,
  });

  final ConnectorEntity? connector;
  final String endDate;
  final String endTime;
  final Function() onCancelModal;
  final Function() onConfirmModal;
  final double priceReserve;
  final CreditCardEntity selectedPayment;
  final String startDate;
  final String startTime;
  final StationDetailEntity? stationData;
  final String totalTime;

  @override
  State<BookingModalConfirm> createState() => _BookingModalConfirmState();
}

class _BookingModalConfirmState extends State<BookingModalConfirm> {
  String getConnectorType(String connectPower, String connectType) {
    switch (connectPower) {
      case 'AC':
        if (connectType == 'CS1') {
          return ImageAsset.ic_ac_cs1;
        } else if (connectType == 'CS2') {
          return ImageAsset.ic_ac_cs2;
        } else {
          return ImageAsset.ic_ac_chadeMO;
        }
      case 'DC':
        if (connectType == 'CS1') {
          return ImageAsset.ic_dc_cs1;
        } else if (connectType == 'CS2') {
          return ImageAsset.ic_dc_cs2;
        } else {
          return ImageAsset.ic_dc_chadeMO;
        }
      default:
        return ImageAsset.ic_ac_chadeMO;
    }
  }

  String checkPositionConnector(String position) {
    switch (position) {
      case 'L':
        return translate('check_in_page.charger_data.left');
      case 'R':
        return translate('check_in_page.charger_data.right');
      default:
        return translate('check_in_page.charger_data.middle');
    }
  }

  Widget renderCardPreReserve() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 215,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1,
            color: AppTheme.borderGray,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            renderStartTimeEndTime(),
            renderTotalTime(),
            renderStartDateEndDate(),
            renderBottomDescription(),
          ],
        ),
      ),
    );
  }

  Widget renderStartTimeEndTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextLabel(
              text: translate('booking_page.detail.start_time'),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.little),
            ),
            TextLabel(
              text: '${widget.startTime}',
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.xxl),
              fontWeight: FontWeight.bold,
              color: AppTheme.black,
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 12),
            SvgPicture.asset(
              ImageAsset.ic_booking,
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextLabel(
              text: translate('booking_page.detail.end_time'),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.little),
            ),
            TextLabel(
              text: '${widget.endTime}',
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.xxl),
              fontWeight: FontWeight.bold,
              color: AppTheme.red,
            ),
          ],
        ),
      ],
    );
  }

  Widget renderTotalTime() {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          renderDashline(),
          TextLabel(
            text: '${widget.totalTime}',
            color: AppTheme.black,
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.big),
            fontWeight: FontWeight.bold,
          ),
          renderDashline(),
        ],
      ),
    );
  }

  Widget renderStartDateEndDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextLabel(
              text: translate('booking_page.detail.start_date'),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.little),
            ),
            TextLabel(
              text: '${widget.startDate}',
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.large),
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B7280).withOpacity(0.8),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextLabel(
              text: translate('booking_page.detail.end_date'),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.little),
            ),
            TextLabel(
              text: '${widget.endDate}',
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.large),
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B7280).withOpacity(0.8),
            ),
          ],
        ),
      ],
    );
  }

  Widget renderBottomDescription() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Center(
        child: TextLabel(
          text: translate('booking_page.detail.description'),
          fontSize: Utilities.sizeFontWithDesityForDisplay(
              context, AppFontSize.small),
        ),
      ),
    );
  }

  Widget renderDashline() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.275,
      child: Flex(
        direction: Axis.vertical,
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final boxWidth = constraints.constrainWidth();
              final double dashHeight = 1;
              final dashCount = (boxWidth / (2 * 5)).floor();
              return Flex(
                children: List.generate(dashCount, (_) {
                  return SizedBox(
                    width: 5,
                    height: dashHeight,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: AppTheme.black20),
                    ),
                  );
                }),
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
              );
            },
          )
        ],
      ),
    );
  }

  Widget renderStationName() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: AppTheme.borderGray,
        ),
      ),
      child: Column(
        children: [
          renderRowStationName(),
          renderDivider(),
          renderConnector(),
        ],
      ),
    );
  }

  Widget renderRowStationName() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: TextLabel(
              text: '${widget.stationData?.stationName}',
              color: AppTheme.blueDark,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.normal),
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.125,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: AppTheme.blueD,
                  ),
                  child: SvgPicture.asset(
                    ImageAsset.ic_route,
                    width: 14,
                    height: 14,
                    color: AppTheme.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget renderConnector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      getConnectorType(widget.connector!.connectorPowerType,
                          widget.connector!.connectorType),
                      width: 30,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextLabel(
                        color: AppTheme.blueDark,
                        text: Utilities.nameConnecterType(
                            widget.connector!.connectorPowerType,
                            widget.connector!.connectorType),
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.normal),
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.blueDark,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: TextLabel(
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, AppFontSize.mini),
                            text: checkPositionConnector(
                                widget.connector!.connectorPosition),
                            fontWeight: FontWeight.w400,
                            color: AppTheme.white),
                      ),
                    ],
                  ),
                  TextLabel(
                    fontWeight: FontWeight.w400,
                    fontSize: Utilities.sizeFontWithDesityForDisplay(
                        context, AppFontSize.little),
                    text:
                        '${widget.connector!.connectorPower} • ${widget.connector!.connectorPrice}',
                    color: AppTheme.black40,
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TextLabel(
              //   fontWeight: FontWeight.w400,
              //   fontSize: Utilities.sizeFontWithDesityForDisplay(
              //       context, AppFontSize.small),
              //   text:
              //       '${Utilities.capitalizeWords(widget.connector?.connectorStatusActive ?? 'N/A')}',
              //   color: getStatusText(
              //       widget.connector?.connectorStatusActive ?? 'N/A'),
              //   maxLines: 1,
              //   overflow: TextOverflow.ellipsis,
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget renderDivider() {
    return Container(
      height: 1,
      color: AppTheme.borderGray,
    );
  }

  Widget renderPaymentDetail() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextLabel(
                text: translate('booking_page.payment'),
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.normal),
                color: AppTheme.blueD,
                fontWeight: FontWeight.bold,
              ),
              widget.selectedPayment.display == ''
                  ? TextLabel(
                      text: 'N/A',
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.normal),
                      color: AppTheme.blueD,
                    )
                  : Container(
                      child: Row(
                        children: [
                          Container(
                              child: Utilities.assetCreditCard(
                                  cardBrand: widget.selectedPayment.cardBrand,
                                  width: 18,
                                  height: 18)),
                          const SizedBox(width: 8),
                          TextLabel(
                            text: widget.selectedPayment.display != ''
                                ? (widget.selectedPayment.display).substring(
                                    widget.selectedPayment.display.length - 4)
                                : '',
                            color: AppTheme.blueD,
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, AppFontSize.normal),
                          ),
                        ],
                      ),
                    )
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextLabel(
                text: translate('booking_page.total_payment'),
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.normal),
                color: AppTheme.blueD,
                fontWeight: FontWeight.bold,
              ),
              TextLabel(
                text: '${Utilities.formatMoney('${widget.priceReserve}', 2)}',
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.normal),
                color: AppTheme.blueD,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      actionsAlignment: MainAxisAlignment.center,
      titlePadding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      contentPadding: EdgeInsets.fromLTRB(16, 12, 16, 0),
      actionsPadding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      insetPadding: EdgeInsets.all(0),
      title: Center(
        child: Column(
          children: [
            TextLabel(
              text: translate('alert.description.confirm_booking'),
              color: AppTheme.black,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.superlarge),
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
      content: Container(
        height: 390,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            renderStationName(),
            renderCardPreReserve(),
            renderPaymentDetail(),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: AppTheme.black5,
                  elevation: 0.0,
                  shadowColor: Colors.transparent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(200)),
                  ),
                ),
                onPressed: widget.onCancelModal,
                child: TextLabel(
                  text: translate('button.cancel'),
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.normal),
                  fontWeight: FontWeight.w700,
                  color: AppTheme.gray9CA3AF,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: AppTheme.blueD,
                  elevation: 0.0,
                  shadowColor: Colors.transparent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(200)),
                  ),
                ),
                onPressed: widget.onConfirmModal,
                child: TextLabel(
                  text: translate('button.confirm'),
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.normal),
                  fontWeight: FontWeight.w700,
                  color: AppTheme.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
