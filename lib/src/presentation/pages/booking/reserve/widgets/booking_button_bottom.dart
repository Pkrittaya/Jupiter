import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/credit_card_entity.dart';
import 'package:jupiter_api/domain/entities/reserve_slot_entity.dart';
import 'package:jupiter/src/presentation/widgets/button.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class BookingButtonButtom extends StatefulWidget {
  const BookingButtonButtom({
    super.key,
    required this.bookingSelect,
    required this.emptyBookingTable,
    required this.errorPage,
    required this.selectedPayment,
    required this.canBook,
    required this.onPressedBookNow,
    required this.onPressedPayment,
    required this.priceReserve,
  });

  final ReserveSlotEntity? bookingSelect;
  final bool canBook;
  final bool emptyBookingTable;
  final bool errorPage;
  final Function() onPressedBookNow;
  final Function() onPressedPayment;
  final double priceReserve;
  final CreditCardEntity selectedPayment;

  @override
  State<BookingButtonButtom> createState() => _BookingButtonButtomState();
}

class _BookingButtonButtomState extends State<BookingButtonButtom> {
  double heightButtonBottom = 160;
  double sizePaddingHorizontal = 16;

  @override
  Widget build(BuildContext context) {
    if (widget.bookingSelect != null &&
        widget.bookingSelect!.status == true &&
        !widget.emptyBookingTable &&
        !widget.errorPage) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.all(sizePaddingHorizontal),
          width: double.infinity,
          height: heightButtonBottom,
          decoration: BoxDecoration(
              color: AppTheme.white,
              border: Border(
                  top: BorderSide(
                width: 1,
                color: AppTheme.borderGray,
              ))),
          child: Column(
            children: [
              Material(
                color: AppTheme.white,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: widget.onPressedPayment,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextLabel(
                        text: translate('booking_page.payment'),
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.big),
                        color: AppTheme.blueD,
                        fontWeight: FontWeight.bold,
                      ),
                      widget.selectedPayment.display == ''
                          ? TextLabel(
                              text: 'N/A',
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.big),
                              color: AppTheme.blueD,
                            )
                          : Container(
                              child: Row(
                                children: [
                                  Container(
                                      child: Utilities.assetCreditCard(
                                          cardBrand:
                                              widget.selectedPayment.cardBrand,
                                          width: 24,
                                          height: 24)),
                                  const SizedBox(width: 8),
                                  TextLabel(
                                    text: widget.selectedPayment.display != ''
                                        ? (widget.selectedPayment.display)
                                            .substring(widget.selectedPayment
                                                    .display.length -
                                                4)
                                        : '',
                                    color: AppTheme.blueD,
                                    fontSize:
                                        Utilities.sizeFontWithDesityForDisplay(
                                            context, AppFontSize.big),
                                  ),
                                ],
                              ),
                            )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextLabel(
                    text: translate('booking_page.total_payment'),
                    fontSize: Utilities.sizeFontWithDesityForDisplay(
                        context, AppFontSize.big),
                    color: AppTheme.blueD,
                    fontWeight: FontWeight.bold,
                  ),
                  TextLabel(
                    text: Utilities.formatMoney('${widget.priceReserve}', 2),
                    fontSize: Utilities.sizeFontWithDesityForDisplay(
                        context, AppFontSize.big),
                    color: AppTheme.blueD,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 45,
                child: Button(
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    shadowColor: Colors.transparent,
                    backgroundColor:
                        widget.canBook ? AppTheme.blueD : AppTheme.gray9CA3AF,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(200)),
                    ),
                  ),
                  text: translate('booking_page.book_now'),
                  onPressed: widget.onPressedBookNow,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    } else
      return SizedBox();
  }
}
