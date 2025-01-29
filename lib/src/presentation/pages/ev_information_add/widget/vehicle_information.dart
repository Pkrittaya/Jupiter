import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/province_master.dart';
import 'package:jupiter/src/presentation/widgets/modal_select_list.dart';
import 'package:jupiter/src/presentation/widgets/text_input_form.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/presentation/widgets/tootip_information.dart';
import 'package:jupiter/src/utilities.dart';

class VehicleInform extends StatefulWidget {
  const VehicleInform(
      {Key? key,
      required this.licensePlateController,
      required this.provinceController,
      required this.canEdit,
      required this.validateLicensePlate,
      required this.validateProvince,
      required this.onValidate})
      : super(key: key);

  final TextEditingController licensePlateController;
  final TextEditingController provinceController;
  final bool canEdit;
  final bool validateLicensePlate;
  final bool validateProvince;
  final Function() onValidate;

  @override
  _VehicleInformState createState() => _VehicleInformState();
}

class _VehicleInformState extends State<VehicleInform> {
  List<ProvinceMasterEntity> provinceEntity = [];
  int indexProvince = 0;
  String beforeProvince = '';
  int beforeIndexProvince = 0;
  bool isError = false;

  GlobalKey<State<StatefulWidget>> keyLicensePlate =
      GlobalKey<State<StatefulWidget>>();

  Color getColorStatus(String value) {
    switch (value) {
      case 'DEFAULT_BORDER':
        return AppTheme.borderGray;
      case 'DEFAULT_FIELD':
        return AppTheme.white;
      case 'VALIDATE_BORDER':
        return AppTheme.red;
      case 'VALIDATE_FIELD':
        return AppTheme.red.withOpacity(0.1);
      default:
        return AppTheme.grayF1F5F9;
    }
  }

  @override
  void initState() {
    getProvinceJson();
    super.initState();
  }

  void initialIndexProvince() {
    FocusScope.of(context).unfocus();
    beforeProvince = widget.provinceController.text;
    beforeIndexProvince = provinceEntity
        .indexWhere((item) => item.nameTh == widget.provinceController.text);
    if (beforeIndexProvince < 0) {
      beforeIndexProvince = 0;
    }
    indexProvince = beforeIndexProvince;
    setState(() {});
  }

  void getProvinceJson() async {
    var filejson = 'assets/thaiProvince/thaiProvinces.json';
    String jsonProvince = await rootBundle.loadString(filejson);
    List listProvince = jsonDecode(jsonProvince);
    provinceEntity = List<ProvinceMasterEntity>.from(
        listProvince.map<ProvinceMasterEntity>(
            (dynamic i) => ProvinceMasterEntity.fromJson(i)));
    provinceEntity.sort((a, b) => a.nameTh!.compareTo(b.nameTh!));
    setState(() {});
  }

  void onChangeProvince(int index) {
    beforeProvince = provinceEntity[index].nameTh ?? '';
    beforeIndexProvince = index;
  }

  void onDoneModalProvince() {
    widget.provinceController.text = beforeProvince;
    indexProvince = beforeIndexProvince;
    if (widget.provinceController.text == '') {
      widget.provinceController.text = provinceEntity[0].nameTh ?? '';
      indexProvince = 0;
    }
    // setState(() {});
    widget.onValidate();
    Navigator.of(context).pop();
  }

  void whenCompleteProvince() {
    setState(() {});
    try {
      FocusScope.of(context).requestFocus(new FocusNode());
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextLabel(
                color: AppTheme.blueDark,
                text: translate(
                    "ev_information_add_page.vahicle_information.vehicle_information"),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(
                width: 8,
              ),
              TooltipInformation(
                message: translate("ev_information_add_page.information"),
              ),
            ],
          ),

          const SizedBox(height: 10),
          widget.canEdit
              ? TextInputForm(
                  key: keyLicensePlate,
                  contentPadding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                  controller: widget.licensePlateController,
                  hintText: translate(
                      "ev_information_add_page.vahicle_information.license_plate"),
                  hintStyle: TextStyle(
                    color: AppTheme.black60,
                    fontSize:
                        Utilities.sizeFontWithDesityForDisplay(context, 20),
                  ),
                  style: TextStyle(
                      color: AppTheme.blueDark,
                      fontSize:
                          Utilities.sizeFontWithDesityForDisplay(context, 20)),
                  fillColor: getColorStatus(widget.validateLicensePlate
                      ? 'VALIDATE_FIELD'
                      : 'DEFAULT_FIELD'),
                  borderColor: getColorStatus(widget.validateLicensePlate
                      ? 'VALIDATE_BORDER'
                      : 'DEFAULT_BORDER'),
                  onTap: () {
                    Utilities.ensureVisibleOnTextInput(
                        textfieldKey: keyLicensePlate);
                  },
                  onChanged: (val) {
                    widget.onValidate();
                  },
                  validator: (text) {
                    if (text == null || text == "") {
                      return translate(
                          "ev_information_add_page.validate.required");
                    } else {
                      return '';
                    }
                  },
                )
              : Container(
                  height: 48,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppTheme.black60.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: AppTheme.borderGray),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextLabel(
                        text: widget.licensePlateController.text,
                        textAlign: TextAlign.start,
                        color: AppTheme.blueDark,
                      ),
                    ],
                  ),
                ),
          const SizedBox(height: 10),
          // province
          InkWell(
            onTap: () {
              if (widget.canEdit) {
                initialIndexProvince();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12))),
                  builder: (BuildContext context) {
                    return ModalSelectList(
                      type: 'PROVINCE',
                      listItem: provinceEntity,
                      initialIndex: indexProvince,
                      onChange: onChangeProvince,
                      onDoneModal: onDoneModalProvince,
                    );
                  },
                ).whenComplete(whenCompleteProvince);
              }
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 13),
              decoration: BoxDecoration(
                color: widget.canEdit
                    ? getColorStatus(widget.validateProvince
                        ? 'VALIDATE_FIELD'
                        : 'DEFAULT_FIELD')
                    : AppTheme.black60.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: isError
                      ? AppTheme.red
                      : getColorStatus(widget.validateProvince
                          ? 'VALIDATE_BORDER'
                          : 'DEFAULT_BORDER'),
                ),
              ),
              child: TextLabel(
                text: widget.provinceController.text != ''
                    ? widget.provinceController.text
                    : translate(
                        "ev_information_add_page.vahicle_information.province"),
                color: widget.provinceController.text != ''
                    ? AppTheme.blueDark
                    : AppTheme.black60,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.normal),
              ),
            ),
          )
        ],
      ),
    );
  }
}
