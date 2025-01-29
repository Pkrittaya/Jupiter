import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class ModalSelectList extends StatefulWidget {
  const ModalSelectList({
    Key? key,
    required this.type,
    required this.initialIndex,
    required this.listItem,
    required this.onChange,
    required this.onDoneModal,
  }) : super(key: key);

  final String type;
  final int initialIndex;
  final List<dynamic> listItem;
  final Function(int) onChange;
  final Function() onDoneModal;
  @override
  _ModalSelectListState createState() => _ModalSelectListState();
}

class _ModalSelectListState extends State<ModalSelectList> {
  @override
  void initState() {
    super.initState();
  }

  String getTitleModal() {
    if (widget.type == 'PROVINCE')
      return translate('tax_invoice_page.hint.province');
    else if (widget.type == 'DISTRICT')
      return translate('tax_invoice_page.hint.district');
    else if (widget.type == 'SUB_DISTRICT')
      return translate('tax_invoice_page.hint.subdistrict');
    else if (widget.type == 'GENDER')
      return translate('input_form.register.gender');
    else if (widget.type == 'MONTH')
      return '';
    else
      return translate('tax_invoice_page.hint.province');
  }

  String getLabelitem(dynamic item) {
    if (widget.type == 'PROVINCE')
      return item.nameTh;
    else if (widget.type == 'DISTRICT')
      return item.nameTh;
    else if (widget.type == 'SUB_DISTRICT')
      return item.nameTh;
    else if (widget.type == 'GENDER')
      return item['text'];
    else if (widget.type == 'MONTH')
      return item['text'];
    else
      return item.nameTh;
  }

  final formKey = GlobalKey<FormState>();
  double heightItem = 35;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
        ));
  }

  Widget _headerAndIconClose() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextLabel(
          text: getTitleModal(),
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
      // color: AppTheme.red80,
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
          NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: ListWheelScrollView.useDelegate(
              controller:
                  FixedExtentScrollController(initialItem: widget.initialIndex),
              itemExtent: heightItem,
              perspective: 0.0025,
              // diameterRatio: 1.5,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                widget.onChange(index);
              },
              childDelegate: ListWheelChildListDelegate(
                children: List<Widget>.generate(
                  widget.listItem.length,
                  (index) => renderItem(widget.listItem[index]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderItem(dynamic item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Center(
        child: TextLabel(
            text: getLabelitem(item),
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.big),
            color: AppTheme.blueDark),
      ),
    );
  }
}
