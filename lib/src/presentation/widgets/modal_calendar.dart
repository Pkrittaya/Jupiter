import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class ModalCalendar extends StatefulWidget {
  const ModalCalendar({
    Key? key,
    required this.title,
    required this.controllerDay,
    required this.controllerMonth,
    required this.controllerYear,
    required this.listDay,
    required this.listMonth,
    required this.listYear,
    required this.initialIndexDay,
    required this.initialIndexMonth,
    required this.initialIndexYear,
    required this.onChangeDay,
    required this.onChangeMonth,
    required this.onChangeYear,
    required this.onDoneModal,
  }) : super(key: key);

  final String title;
  final FixedExtentScrollController controllerDay;
  final FixedExtentScrollController controllerMonth;
  final FixedExtentScrollController controllerYear;
  final List<dynamic> listDay;
  final List<dynamic> listMonth;
  final List<dynamic> listYear;
  final int initialIndexDay;
  final int initialIndexMonth;
  final int initialIndexYear;
  final Function(int) onChangeDay;
  final Function(int) onChangeMonth;
  final Function(int) onChangeYear;
  final Function() onDoneModal;
  @override
  _ModalCalendarState createState() => _ModalCalendarState();
}

class _ModalCalendarState extends State<ModalCalendar> {
  @override
  void initState() {
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  double heightItem = 35;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            height: 250,
            decoration: const BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _headerAndIconClose(),
                const SizedBox(height: 16),
                renderListItem(),
              ],
            ),
          )),
    );
  }

  Widget _headerAndIconClose() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextLabel(
          text: '${widget.title}',
          color: AppTheme.black,
          fontSize: Utilities.sizeFontWithDesityForDisplay(
              context, AppFontSize.superlarge),
          fontWeight: FontWeight.bold,
        ),
        GestureDetector(
          onTap: widget.onDoneModal,
          child: Container(
            color: AppTheme.white,
            padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8),
            child: Text(
              translate('button.done'),
              style: TextStyle(
                height: 0.8,
                color: AppTheme.blueD,
                fontWeight: FontWeight.w700,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context,
                  AppFontSize.large,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget renderListItem() {
    return Container(
      height: (heightItem * 5) - 1,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: heightItem,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppTheme.blueD.withOpacity(0.1),
            ),
          ),
          renderContainerDate()
        ],
      ),
    );
  }

  Widget renderContainerDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: (heightItem * 5) - 1,
          width: MediaQuery.of(context).size.width * 0.15,
          child: ListWheelScrollView.useDelegate(
            controller: widget.controllerDay,
            itemExtent: heightItem,
            perspective: 0.0025,
            // diameterRatio: 1.5,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              widget.onChangeDay(index);
            },
            childDelegate: ListWheelChildListDelegate(
              children: List<Widget>.generate(
                widget.listDay.length,
                (index) => renderItem(widget.listDay[index]),
              ),
            ),
          ),
        ),
        Container(
          height: (heightItem * 5) - 1,
          width: MediaQuery.of(context).size.width * 0.3,
          child: ListWheelScrollView.useDelegate(
            controller: widget.controllerMonth,
            itemExtent: heightItem,
            perspective: 0.0025,
            // diameterRatio: 1.5,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              widget.onChangeMonth(index);
            },
            childDelegate: ListWheelChildListDelegate(
              children: List<Widget>.generate(
                widget.listMonth.length,
                (index) => renderItem(widget.listMonth[index]),
              ),
            ),
          ),
        ),
        Container(
          height: (heightItem * 5) - 1,
          width: MediaQuery.of(context).size.width * 0.2,
          child: ListWheelScrollView.useDelegate(
            controller: widget.controllerYear,
            itemExtent: heightItem,
            perspective: 0.0025,
            // diameterRatio: 1.5,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              widget.onChangeYear(index);
            },
            childDelegate: ListWheelChildListDelegate(
              children: List<Widget>.generate(
                widget.listYear.length,
                (index) => renderItem(widget.listYear[index]),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget renderItem(dynamic item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Center(
        child: TextLabel(
            text: item,
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.large),
            color: AppTheme.blueDark),
      ),
    );
  }
}
