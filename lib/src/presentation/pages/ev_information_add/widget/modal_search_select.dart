import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/text_input_form.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class ModalSearchSelect extends StatefulWidget {
  const ModalSearchSelect(
      {Key? key,
      required this.type,
      required this.initialIndex,
      required this.listItem,
      required this.onChange,
      required this.onDoneModal,
      required this.itemSelect})
      : super(key: key);

  final String type;
  final int initialIndex;
  final List<dynamic> listItem;
  final Function(int, List<dynamic>, String type) onChange;
  final Function(List<dynamic> listItem, String type) onDoneModal;
  final String itemSelect;
  @override
  _ModalSearchSelectState createState() => _ModalSearchSelectState();
}

class _ModalSearchSelectState extends State<ModalSearchSelect> {
  TextEditingController controllerTextSearch = TextEditingController();
  List<dynamic> listItem = [];
  int initialIndex = 0;
  final formKey = GlobalKey<FormState>();
  double heightItem = 35;
  FixedExtentScrollController listController = FixedExtentScrollController();

  @override
  void initState() {
    listItem = widget.listItem;
    initialIndex = widget.initialIndex;
    listController =
        FixedExtentScrollController(initialItem: widget.initialIndex);
    super.initState();
  }

  String getTitleModal() {
    if (widget.type == 'BRAND')
      return translate('ev_information_add_page.select_brand_model.brand');
    else if (widget.type == 'MODEL')
      return translate('ev_information_add_page.select_brand_model.model');
    else
      return '';
  }

  String getLabelitem(dynamic item) {
    if (widget.type == 'BRAND')
      return item.brand;
    else if (widget.type == 'MODEL')
      return item.name;
    else
      return item['text'];
  }

  List<dynamic> checklistItem(list) {
    if (controllerTextSearch.text == '') {
      listItem = widget.listItem;
    } else {
      listItem = list;
    }
    return listItem;
  }

  void checkSelect() {
    // กรณีมีการเลือก brand หรือ model ไว้แล้ว ถ้า search จะเลือกข้อมูลนั้นให้
    int checkSelect = 0;
    switch (widget.type) {
      case 'BRAND':
        checkSelect =
            listItem.indexWhere((item) => item.brand == widget.itemSelect);
        break;
      case 'MODEL':
        checkSelect =
            listItem.indexWhere((item) => item.name == widget.itemSelect);
        break;
    }

    if (checkSelect < 0) {
      checkSelect = 0;
    }

    listController.animateToItem(checkSelect,
        duration: Duration(milliseconds: 100), curve: Curves.linear);
  }

  void onChangSearch(String? text, String type) {
    // พิมพ์ค้นหาข้อมูลใน list
    switch (type) {
      case 'BRAND':
        if (text != '') {
          listItem = widget.listItem.where((item) {
            return item.brand.toLowerCase().contains(text!.toLowerCase());
          }).toList();
        } else {
          listItem = widget.listItem;
        }
        checkSelect();
        break;
      case 'MODEL':
        if (text != '') {
          listItem = widget.listItem.where((item) {
            return item.name.toLowerCase().contains(text!.toLowerCase());
          }).toList();
        } else {
          listItem = widget.listItem;
        }
        checkSelect();
        break;
      default:
        listItem = widget.listItem;
        break;
    }

    setState(() {});
  }

  void onPressedClearList() {
    // กดปุ่ม clear ในแถบ search
    controllerTextSearch.text = '';
    listItem = widget.listItem;

    checkSelect();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          height: 300,
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
              textfiledSearch(),
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
          onTap: () {
            widget.onDoneModal(listItem, widget.type);
          },
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
          listItem.length > 0
              ? Container(
                  height: heightItem,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppTheme.blueD.withOpacity(0.1),
                  ),
                )
              : SizedBox.shrink(),
          NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: ListWheelScrollView.useDelegate(
              controller: listController,
              itemExtent: heightItem,
              perspective: 0.0025,
              // diameterRatio: 1.5,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                widget.onChange(index, listItem, widget.type);
              },
              childDelegate: ListWheelChildListDelegate(
                children: List<Widget>.generate(
                  listItem.length,
                  (index) => renderItem(listItem[index]),
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

  Widget textfiledSearch() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 48,
        child: TextInputForm(
          // focusNode: _focus,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          controller: controllerTextSearch,
          fillColor: AppTheme.white,
          hintText: translate('ev_information_add_page.modal.search'),
          hintStyle: TextStyle(
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.normal),
              color: AppTheme.black40),
          suffixIcon: IconButton(
            icon: Material(
              color: AppTheme.black20,
              borderRadius: BorderRadius.circular(200),
              child: Icon(
                Icons.close_outlined,
                color: AppTheme.white,
                size: 16,
              ),
            ),
            onPressed: () => onPressedClearList(),
          ),
          onSaved: (text) {},
          keyboardType: TextInputType.text,
          onChanged: (value) {
            onChangSearch(value, widget.type);
          },
        ));
  }
}
