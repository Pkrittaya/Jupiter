import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class ModalBottomBattery extends StatefulWidget {
  const ModalBottomBattery({
    Key? key,
    required this.controller,
    // required this.onChangeBattery,
    required this.onCloseModal,
    required this.onDoneModal,
  }) : super(key: key);

  final TextEditingController controller;
  // final Function(String) onChangeBattery;
  final Function() onCloseModal;
  final Function() onDoneModal;
  @override
  _ModalBottomBatteryState createState() => _ModalBottomBatteryState();
}

class _ModalBottomBatteryState extends State<ModalBottomBattery> {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          height: 190,
          decoration: const BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerAndIconClose(),
              const SizedBox(height: 16),
              TextLabel(
                text: translate("check_in_page.battery.description"),
                color: AppTheme.gray9CA3AF,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.little),
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(height: 16),
              _textfiledCurrentBattery(),
            ],
          ),
        ));
  }

  Widget _headerAndIconClose() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.close, color: AppTheme.black),
          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
          constraints: const BoxConstraints(),
          onPressed: widget.onCloseModal,
        ),
        TextLabel(
          text: translate("check_in_page.battery.current_battery"),
          fontWeight: FontWeight.bold,
          color: AppTheme.black,
          fontSize: Utilities.sizeFontWithDesityForDisplay(
              context, AppFontSize.title),
        ),
        GestureDetector(
            onTap: widget.onDoneModal,
            child: Container(
              color: AppTheme.white,
              padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8),
              child: Text(
                translate("button.done"),
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
            ))
      ],
    );
  }

  Widget _textfiledCurrentBattery() {
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: 50,
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: AppTheme.gray9CA3AF),
        color: const Color(0xFFEDF7FD),
      ),
      child: Row(
        children: [
          SizedBox(
            width: width * 0.73,
            child: TextFormField(
              // onChanged: (String value) {
              //   widget.onChangeBattery(value);
              // },
              textAlign: TextAlign.center,
              controller: widget.controller,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                  contentPadding: EdgeInsets.only(left: 24)),
              keyboardType: TextInputType.number,
              style: TextStyle(
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.title),
                  color: AppTheme.blueDark,
                  height: 1),
              maxLength: 3,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
            ),
          ),
          Container(
            width: width * 0.1325,
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(width: 1, color: AppTheme.gray9CA3AF),
              ),
              // color: AppTheme.grayD4A50,
            ),
            child: Center(
              child: TextLabel(
                text: '%',
                textAlign: TextAlign.right,
                fontWeight: FontWeight.bold,
                color: AppTheme.blueDark,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.title),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
