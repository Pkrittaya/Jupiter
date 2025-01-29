import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class BookingSelectDate extends StatefulWidget {
  const BookingSelectDate({
    super.key,
    required this.index,
    required this.onPressedDate,
    required this.dateToRender,
  });

  final DateTime dateToRender;
  final int index;
  final Function(int, bool) onPressedDate;

  @override
  State<BookingSelectDate> createState() => _BookingSelectDateState();
}

class _BookingSelectDateState extends State<BookingSelectDate> {
  String generateTextDate(int index, String type) {
    // var now = DateTime.now();
    if (type == 'TITLE') {
      if (index == 0) {
        return getWordDateFromNumberDate(0);
      } else {
        var futureDate = widget.dateToRender.add(Duration(days: index));
        return getWordDateFromNumberDate(futureDate.weekday);
      }
    } else {
      var futureDate = widget.dateToRender.add(Duration(days: index));
      var formatter = DateFormat('dd');
      var futureDateText = formatter.format(futureDate);
      return futureDateText;
    }
  }

  String getWordDateFromNumberDate(int dateNumber) {
    switch (dateNumber) {
      case 0:
        return translate('date.today');
      case 1:
        return translate('date.monday');
      case 2:
        return translate('date.tuesday');
      case 3:
        return translate('date.wednesday');
      case 4:
        return translate('date.thursday');
      case 5:
        return translate('date.friday');
      case 6:
        return translate('date.saturday');
      case 7:
        return translate('date.sunday');
      default:
        return translate('date.today');
    }
  }

  Widget generateDateSevenDays() {
    List<Widget> listDateSelect = [];
    for (int i = 0; i < 7; i++) {
      listDateSelect.add(
        Row(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                widget.onPressedDate(i, false);
              },
              child: Container(
                  width: ((MediaQuery.of(context).size.width) - 20 - 48) / 7,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: widget.index == i ? AppTheme.blueD : AppTheme.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextLabel(
                        text: generateTextDate(i, 'TITLE'),
                        color: i == widget.index
                            ? AppTheme.white
                            : AppTheme.gray9CA3AF,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.little),
                      ),
                      TextLabel(
                        text: generateTextDate(i, 'SUB_TITLE'),
                        color:
                            i == widget.index ? AppTheme.white : AppTheme.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.big),
                      ),
                    ],
                  )),
            ),
            SizedBox(width: i == 6 ? 0 : 6)
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: listDateSelect,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return generateDateSevenDays();
  }
}
