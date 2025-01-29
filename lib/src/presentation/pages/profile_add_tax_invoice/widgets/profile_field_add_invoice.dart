import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/national_id_card_formatter.dart';
import 'package:jupiter_api/domain/entities/billing_entity.dart';
import 'package:jupiter_api/domain/entities/district_master.dart';
import 'package:jupiter_api/domain/entities/province_master.dart';
import 'package:jupiter_api/domain/entities/sub_district_master.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter/src/presentation/widgets/modal_select_list.dart';

class ProfileFieldAddTaxInVoice extends StatefulWidget {
  const ProfileFieldAddTaxInVoice({
    super.key,
    required this.billingData,
    required this.formKey,
    required this.indexType,
    required this.onChangeSetHasEditTrue,
    required this.controllerBillingName,
    required this.controllerTaxIdNationalId,
    required this.controllerBranchName,
    required this.controllerBranchCode,
    required this.controllerAddress,
    required this.controllerProvince,
    required this.controllerDistrict,
    required this.controllerSubdistrict,
    required this.controllerPostalCode,
    required this.isDefault,
    required this.onChangeSwitchDefault,
    required this.colorValidateField,
  });
  final BillingEntity? billingData;
  final GlobalKey formKey;
  final int indexType;
  final Function(String?, String) onChangeSetHasEditTrue;
  final TextEditingController controllerBillingName;
  final TextEditingController controllerTaxIdNationalId;
  final TextEditingController controllerBranchName;
  final TextEditingController controllerBranchCode;
  final TextEditingController controllerAddress;
  final TextEditingController controllerProvince;
  final TextEditingController controllerDistrict;
  final TextEditingController controllerSubdistrict;
  final TextEditingController controllerPostalCode;
  final bool isDefault;
  final Function(bool) onChangeSwitchDefault;
  final List<String> colorValidateField;
  @override
  _ProfileFieldAddTaxInVoiceState createState() =>
      _ProfileFieldAddTaxInVoiceState();
}

class _ProfileFieldAddTaxInVoiceState extends State<ProfileFieldAddTaxInVoice> {
  List<ProvinceMasterEntity> provinceEntity = [];
  List<DistrictMasterEntity> districtEntity = [];
  List<SubDistrictMasterEntity> subDistrictEntity = [];
  TextEditingController provinceController = TextEditingController();
  int indexProvince = 0;
  int indexDistrict = 0;
  int indexSubdistrict = 0;
  int idProvince = 0;
  int idDistrict = 0;
  int idSubdistrict = 0;

  String beforeProvince = '';
  String beforeDistrict = '';
  String beforeSubdistrict = '';
  String beforePostalCode = '';
  int beforeIndexProvince = 0;
  int beforeIndexDistrict = 0;
  int beforeIndexSubdistrict = 0;
  int beforeIdProvince = 0;
  int beforeIdDistrict = 0;
  int beforeIdSubdistrict = 0;

  List<String> idField = [
    'BILLING_TYPE',
    'BILLING_NAME',
    'BILLING_TAX_ID',
    'BRANCH_NAME',
    'BRANCH_CODE',
    'ADDRESS',
    'PROVINCE',
    'DISTRICT',
    'SUB_DISTRICT',
    'POSTAL_CODE',
    'DEFAULT'
  ];
  // TA

  GlobalKey<State<StatefulWidget>> keyAddress =
      GlobalKey<State<StatefulWidget>>();
  GlobalKey<State<StatefulWidget>> keyPostCode =
      GlobalKey<State<StatefulWidget>>();

  Color borderValidate(String text) {
    switch (text) {
      case 'default':
        return AppTheme.borderGray;
      case 'success':
        return AppTheme.blueD;
      case 'error':
        return AppTheme.red;
      default:
        return AppTheme.borderGray;
    }
  }

  @override
  void initState() {
    initialDropdownAddressWhenIsUpdateAction();
    super.initState();
  }

  Future<void> initialDropdownAddressWhenIsUpdateAction() async {
    if (widget.controllerProvince.text != '') {
      var thaiProvincesJson = 'assets/thaiProvince/thaiProvinces.json';
      String jsonProvince = await rootBundle.loadString(thaiProvincesJson);
      List listProvince = jsonDecode(jsonProvince);
      provinceEntity = List<ProvinceMasterEntity>.from(
          listProvince.map<ProvinceMasterEntity>(
              (dynamic i) => ProvinceMasterEntity.fromJson(i)));
      provinceEntity.sort((a, b) => a.nameTh!.compareTo(b.nameTh!));
      for (int i = 0; i < provinceEntity.length; i++) {
        if (widget.controllerProvince.text == provinceEntity[i].nameTh) {
          beforeProvince = provinceEntity[i].nameTh ?? '';
          beforeIdProvince = provinceEntity[i].id ?? 0;
          beforeIndexProvince = i;
          idProvince = beforeIdProvince;
          indexProvince = beforeIndexProvince;
          break;
        }
      }
      var thaiAmphuresJson = 'assets/thaiProvince/thaiAmphures.json';
      String jsonDistrict = await rootBundle.loadString(thaiAmphuresJson);
      List listDistrict = jsonDecode(jsonDistrict);
      districtEntity = List<DistrictMasterEntity>.from(
          listDistrict.map<DistrictMasterEntity>(
              (dynamic i) => DistrictMasterEntity.fromJson(i)));
      List<DistrictMasterEntity> districtEntityNew = districtEntity
          .where((item) => item.provinceId == idProvince)
          .toList();
      districtEntityNew.sort((a, b) => a.nameTh!.compareTo(b.nameTh!));
      districtEntity = districtEntityNew;
      for (int i = 0; i < districtEntity.length; i++) {
        if (widget.controllerDistrict.text == districtEntity[i].nameTh) {
          beforeDistrict = districtEntity[i].nameTh ?? '';
          beforeIdDistrict = districtEntity[i].id ?? 0;
          beforeIndexDistrict = i;
          idDistrict = beforeIdDistrict;
          indexDistrict = beforeIndexDistrict;
          break;
        }
      }
      var filejson = 'assets/thaiProvince/thaiTambons.json';
      String jsonSubDistrict = await rootBundle.loadString(filejson);
      List listSubDistrict = jsonDecode(jsonSubDistrict);
      subDistrictEntity = List<SubDistrictMasterEntity>.from(
          listSubDistrict.map<SubDistrictMasterEntity>(
              (dynamic i) => SubDistrictMasterEntity.fromJson(i)));
      List<SubDistrictMasterEntity> subDistrictEntityNew = subDistrictEntity
          .where((item) => item.amphureId == idDistrict)
          .toList();
      subDistrictEntityNew.sort((a, b) => a.nameTh!.compareTo(b.nameTh!));
      subDistrictEntity = subDistrictEntityNew;
      for (int i = 0; i < subDistrictEntity.length; i++) {
        if (widget.controllerSubdistrict.text == subDistrictEntity[i].nameTh) {
          beforeSubdistrict = subDistrictEntity[i].nameTh ?? '';
          beforeIdSubdistrict = subDistrictEntity[i].id ?? 0;
          beforeIndexSubdistrict = i;
          beforePostalCode = subDistrictEntity[i].zipCode.toString();
          idSubdistrict = beforeIdSubdistrict;
          indexSubdistrict = beforeIndexSubdistrict;
          break;
        }
      }
      setState(() {});
    } else {
      getProvinceJson();
    }
  }

  Future<void> getProvinceJson() async {
    var filejson = 'assets/thaiProvince/thaiProvinces.json';
    String jsonProvince = await rootBundle.loadString(filejson);
    List listProvince = jsonDecode(jsonProvince);
    provinceEntity = List<ProvinceMasterEntity>.from(
        listProvince.map<ProvinceMasterEntity>(
            (dynamic i) => ProvinceMasterEntity.fromJson(i)));
    provinceEntity.sort((a, b) => a.nameTh!.compareTo(b.nameTh!));
    setState(() {});
  }

  void getDistrictJson() async {
    var filejson = 'assets/thaiProvince/thaiAmphures.json';
    String jsonDistrict = await rootBundle.loadString(filejson);
    List listDistrict = jsonDecode(jsonDistrict);
    districtEntity = List<DistrictMasterEntity>.from(
        listDistrict.map<DistrictMasterEntity>(
            (dynamic i) => DistrictMasterEntity.fromJson(i)));
    List<DistrictMasterEntity> districtEntityNew =
        districtEntity.where((item) => item.provinceId == idProvince).toList();
    districtEntityNew.sort((a, b) => a.nameTh!.compareTo(b.nameTh!));
    setState(() {
      districtEntity = districtEntityNew;
    });
  }

  void getSubDistrictJson() async {
    var filejson = 'assets/thaiProvince/thaiTambons.json';
    String jsonSubDistrict = await rootBundle.loadString(filejson);
    List listSubDistrict = jsonDecode(jsonSubDistrict);
    subDistrictEntity = List<SubDistrictMasterEntity>.from(
        listSubDistrict.map<SubDistrictMasterEntity>(
            (dynamic i) => SubDistrictMasterEntity.fromJson(i)));
    List<SubDistrictMasterEntity> subDistrictEntityNew = subDistrictEntity
        .where((item) => item.amphureId == idDistrict)
        .toList();
    subDistrictEntityNew.sort((a, b) => a.nameTh!.compareTo(b.nameTh!));
    setState(() {
      subDistrictEntity = subDistrictEntityNew;
    });
  }

  void resetDistrict() {
    widget.controllerDistrict.text = '';
    idDistrict = 0;
    indexDistrict = 0;
    widget.onChangeSetHasEditTrue('', idField[7]);
  }

  void resetSubDistrict() {
    widget.controllerSubdistrict.text = '';
    idSubdistrict = 0;
    indexSubdistrict = 0;
    widget.onChangeSetHasEditTrue('', idField[8]);
  }

  void resetPostalCode() {
    widget.controllerPostalCode.text = '';
    widget.onChangeSetHasEditTrue('', idField[9]);
  }

  void onChangeProvince(int index) {
    // widget.controllerProvince.text = provinceEntity[index].nameTh ?? '';
    // idProvince = provinceEntity[index].id ?? 0;
    // indexProvince = index;
    beforeProvince = provinceEntity[index].nameTh ?? '';
    beforeIdProvince = provinceEntity[index].id ?? 0;
    beforeIndexProvince = index;
  }

  void onDoneModalProvince() {
    widget.controllerProvince.text = beforeProvince;
    idProvince = beforeIdProvince;
    indexProvince = beforeIndexProvince;
    if (widget.controllerProvince.text == '') {
      widget.controllerProvince.text = provinceEntity[0].nameTh ?? '';
      idProvince = provinceEntity[0].id ?? 0;
      indexProvince = 0;
    }
    resetDistrict();
    resetSubDistrict();
    resetPostalCode();
    getDistrictJson();
    setState(() {});
    widget.onChangeSetHasEditTrue('', idField[6]);
    Navigator.of(context).pop();
  }

  void whenCompleteProvince() {
    setState(() {});
    try {
      FocusScope.of(context).requestFocus(new FocusNode());
    } catch (e) {}
  }

  void onChangeDistrict(int index) {
    // widget.controllerDistrict.text = districtEntity[index].nameTh ?? '';
    // idDistrict = districtEntity[index].id ?? 0;
    // indexDistrict = index;
    beforeDistrict = districtEntity[index].nameTh ?? '';
    beforeIdDistrict = districtEntity[index].id ?? 0;
    beforeIndexDistrict = index;
  }

  void onDoneModalDistrict() {
    var hasInList = false;
    for (int i = 0; i < districtEntity.length; i++) {
      if (beforeDistrict == districtEntity[i].nameTh) {
        hasInList = true;
        break;
      }
    }
    widget.controllerDistrict.text =
        hasInList ? beforeDistrict : districtEntity[0].nameTh ?? '';
    idDistrict = hasInList ? beforeIdDistrict : districtEntity[0].id ?? 0;
    indexDistrict = hasInList ? beforeIndexDistrict : 0;
    if (widget.controllerDistrict.text == '') {
      widget.controllerDistrict.text = districtEntity[0].nameTh ?? '';
      idDistrict = districtEntity[0].id ?? 0;
      indexDistrict = 0;
    }
    resetSubDistrict();
    resetPostalCode();
    getSubDistrictJson();
    setState(() {});
    widget.onChangeSetHasEditTrue('', idField[7]);
    Navigator.of(context).pop();
  }

  void whenCompleteDistrict() {
    setState(() {});
    try {
      FocusScope.of(context).requestFocus(new FocusNode());
    } catch (e) {}
  }

  void onChangeSubDistrict(int index) {
    // widget.controllerSubdistrict.text = subDistrictEntity[index].nameTh ?? '';
    // idSubdistrict = subDistrictEntity[index].id ?? 0;
    // indexSubdistrict = index;
    // widget.controllerPostalCode.text =
    //     subDistrictEntity[index].zipCode.toString();
    beforeSubdistrict = subDistrictEntity[index].nameTh ?? '';
    beforeIdSubdistrict = subDistrictEntity[index].id ?? 0;
    beforeIndexSubdistrict = index;
    beforePostalCode = subDistrictEntity[index].zipCode.toString();
  }

  void onDoneModalSubDistrict() {
    var hasInList = false;
    for (int i = 0; i < subDistrictEntity.length; i++) {
      if (beforeSubdistrict == subDistrictEntity[i].nameTh) {
        hasInList = true;
        break;
      }
    }
    widget.controllerSubdistrict.text =
        hasInList ? beforeSubdistrict : subDistrictEntity[0].nameTh ?? '';
    idSubdistrict =
        hasInList ? beforeIdSubdistrict : subDistrictEntity[0].id ?? 0;
    indexSubdistrict = hasInList ? beforeIndexSubdistrict : 0;
    widget.controllerPostalCode.text =
        hasInList ? beforePostalCode : subDistrictEntity[0].zipCode.toString();
    if (widget.controllerSubdistrict.text == '') {
      widget.controllerSubdistrict.text = subDistrictEntity[0].nameTh ?? '';
      idSubdistrict = subDistrictEntity[0].id ?? 0;
      indexSubdistrict = 0;
      widget.controllerPostalCode.text =
          subDistrictEntity[0].zipCode.toString();
    }
    widget.onChangeSetHasEditTrue('', idField[8]);
    widget.onChangeSetHasEditTrue('', idField[9]);
    setState(() {});
    Navigator.of(context).pop();
  }

  void whenCompleteSubDistrict() {
    setState(() {});
    try {
      FocusScope.of(context).requestFocus(new FocusNode());
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppTheme.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextInputForm(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              controller: widget.controllerBillingName,
              style: TextStyle(
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.big),
              ),
              hintText: translate('tax_invoice_page.hint.billing_name'),
              hintStyle: TextStyle(
                  color: AppTheme.gray9CA3AF,
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.big)),
              onSaved: (text) {},
              onChanged: (value) {
                widget.onChangeSetHasEditTrue(value, idField[1]);
              },
              fillColor: AppTheme.white,
              borderColor: borderValidate(widget.colorValidateField[1]),
              keyboardType: TextInputType.name,
              obscureText: false,
              errorStyle: TextStyle(height: 0),
              validator: (text) {
                if (text == null || text == '') {
                  return '';
                } else {
                  return '';
                }
              },
            ),
            const SizedBox(height: 8),
            widget.billingData == null
                ? TextInputForm(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    controller: widget.controllerTaxIdNationalId,
                    style: TextStyle(
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.big),
                    ),
                    hintText:
                        translate('tax_invoice_page.hint.tax_id_national_id'),
                    hintStyle: TextStyle(
                        color: AppTheme.gray9CA3AF,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.big)),
                    onSaved: (text) {},
                    onChanged: (value) {
                      widget.onChangeSetHasEditTrue(value, idField[2]);
                    },
                    fillColor: AppTheme.white,
                    borderColor: borderValidate(widget.colorValidateField[2]),
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    errorStyle: TextStyle(height: 0),
                    maxLength: 17,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      NationalIDCardInputFormatter()
                    ],
                    validator: (text) {
                      if (text == null || text == '') {
                        return '';
                      } else {
                        return '';
                      }
                    },
                  )
                : Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                    decoration: BoxDecoration(
                      color: AppTheme.black60.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: AppTheme.borderGray),
                    ),
                    child: TextLabel(
                      text: '${widget.controllerTaxIdNationalId.text}',
                      color: AppTheme.gray9CA3AF,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.big),
                    ),
                  ),
            SizedBox(height: widget.indexType == 1 ? 8 : 0),
            widget.indexType == 1
                ? TextInputForm(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    controller: widget.controllerBranchName,
                    style: TextStyle(
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.big),
                    ),
                    hintText: translate('tax_invoice_page.hint.branch_name'),
                    hintStyle: TextStyle(
                        color: AppTheme.gray9CA3AF,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.big)),
                    onSaved: (text) {},
                    onChanged: (value) {
                      widget.onChangeSetHasEditTrue(value, idField[3]);
                    },
                    fillColor: AppTheme.white,
                    borderColor: borderValidate(widget.colorValidateField[3]),
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    errorStyle: TextStyle(height: 0),
                    validator: (text) {
                      if (text == null || text == '') {
                        return '';
                      } else {
                        return '';
                      }
                    },
                  )
                : SizedBox(),
            const SizedBox(height: 8),
            widget.indexType == 1
                ? TextInputForm(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    controller: widget.controllerBranchCode,
                    style: TextStyle(
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.big),
                    ),
                    hintText: translate('tax_invoice_page.hint.branch_code'),
                    hintStyle: TextStyle(
                        color: AppTheme.gray9CA3AF,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.big)),
                    onSaved: (text) {},
                    onChanged: (value) {
                      widget.onChangeSetHasEditTrue(value, idField[4]);
                    },
                    fillColor: AppTheme.white,
                    borderColor: borderValidate(widget.colorValidateField[4]),
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    errorStyle: TextStyle(height: 0),
                    maxLength: 5,
                    validator: (text) {
                      if (text == null || text == '') {
                        return '';
                      } else {
                        return '';
                      }
                      // if (!RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                      //     .hasMatch(text)) {
                      //   return '';
                      // }
                    },
                  )
                : SizedBox(),
            const SizedBox(height: 16),
            TextLabel(
              text: translate('tax_invoice_page.title.address'),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.big),
              color: AppTheme.blueDark,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 12),
            TextInputForm(
              key: keyAddress,
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              controller: widget.controllerAddress,
              style: TextStyle(
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.big),
              ),
              hintText: translate('tax_invoice_page.hint.address'),
              hintStyle: TextStyle(
                  color: AppTheme.gray9CA3AF,
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.big)),
              onSaved: (text) {},
              onChanged: (value) {
                widget.onChangeSetHasEditTrue(value, idField[5]);
              },
              fillColor: AppTheme.white,
              borderColor: borderValidate(widget.colorValidateField[5]),
              keyboardType: TextInputType.name,
              obscureText: false,
              errorStyle: TextStyle(height: 0),
              onTap: () {
                Utilities.ensureVisibleOnTextInput(textfieldKey: keyAddress);
              },
              validator: (text) {
                if (text == null || text == '') {
                  return '';
                } else {
                  return '';
                }
              },
            ),
            const SizedBox(height: 8),
            renderDropdown(
              hintText: translate('tax_invoice_page.hint.province'),
              type: 'PROVINCE',
              listItemData: provinceEntity,
              controller: widget.controllerProvince,
              initialIndex: indexProvince,
              onChange: onChangeProvince,
              enabled: true,
              whenComplete: whenCompleteProvince,
              onDoneModal: onDoneModalProvince,
              borderValidate: borderValidate(widget.colorValidateField[6]),
            ),
            const SizedBox(height: 8),
            renderDropdown(
              hintText: translate('tax_invoice_page.hint.district'),
              type: 'DISTRICT',
              listItemData: districtEntity,
              controller: widget.controllerDistrict,
              initialIndex: indexDistrict,
              onChange: onChangeDistrict,
              enabled: widget.controllerProvince.text != '' &&
                  districtEntity.length > 0,
              whenComplete: whenCompleteDistrict,
              onDoneModal: onDoneModalDistrict,
              borderValidate: borderValidate(widget.colorValidateField[7]),
            ),
            const SizedBox(height: 8),
            renderDropdown(
              hintText: translate('tax_invoice_page.hint.subdistrict'),
              type: 'SUB_DISTRICT',
              listItemData: subDistrictEntity,
              controller: widget.controllerSubdistrict,
              initialIndex: indexSubdistrict,
              onChange: onChangeSubDistrict,
              enabled: widget.controllerDistrict.text != '' &&
                  subDistrictEntity.length > 0,
              whenComplete: whenCompleteSubDistrict,
              onDoneModal: onDoneModalSubDistrict,
              borderValidate: borderValidate(widget.colorValidateField[8]),
            ),
            const SizedBox(height: 8),
            TextInputForm(
              key: keyPostCode,
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              controller: widget.controllerPostalCode,
              style: TextStyle(
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.big),
              ),
              hintText: translate('tax_invoice_page.hint.post_code'),
              hintStyle: TextStyle(
                  color: AppTheme.gray9CA3AF,
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.big)),
              onSaved: (text) {},
              onChanged: (value) {
                widget.onChangeSetHasEditTrue(value, idField[9]);
              },
              fillColor: AppTheme.white,
              borderColor: borderValidate(widget.colorValidateField[9]),
              keyboardType: TextInputType.number,
              obscureText: false,
              errorStyle: TextStyle(height: 0),
              maxLength: 5,
              onTap: () {
                Utilities.ensureVisibleOnTextInput(textfieldKey: keyPostCode);
              },
              validator: (text) {
                if (text == null || text == '') {
                  return '';
                } else {
                  return '';
                }
              },
            ),
            const SizedBox(height: 16),
            TextLabel(
              text: translate('tax_invoice_page.title.tax_invoice'),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.big),
              color: AppTheme.blueDark,
              fontWeight: FontWeight.bold,
            ),
            Row(
              children: [
                Container(
                  width: 50,
                  height: 30,
                  child: Transform.scale(
                    scale: 0.7,
                    alignment: Alignment.centerLeft,
                    child: CupertinoSwitch(
                      value: widget.isDefault,
                      activeColor: AppTheme.blueD,
                      onChanged: (value) {
                        widget.onChangeSwitchDefault(value);
                        setState(() {});
                      },
                    ),
                  ),
                ),
                TextLabel(
                  text: translate(
                      'ev_information_add_page.default_vehicle.default'),
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.little),
                  color:
                      widget.isDefault ? AppTheme.blueD : AppTheme.gray9CA3AF,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget renderDropdown({
    required String hintText,
    required String type,
    required List<dynamic> listItemData,
    required TextEditingController controller,
    required int initialIndex,
    required Function(int) onChange,
    required bool enabled,
    required Function() whenComplete,
    required Function() onDoneModal,
    required Color borderValidate,
  }) {
    return InkWell(
      onTap: () {
        if (enabled) {
          FocusScope.of(context).unfocus();
          showModalBottomSheet(
            context: context,
            // enableDrag: false,
            // isDismissible: false,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
            builder: (BuildContext context) {
              return ModalSelectList(
                type: type,
                listItem: listItemData,
                initialIndex: initialIndex,
                onChange: onChange,
                onDoneModal: onDoneModal,
              );
            },
          ).whenComplete(whenComplete);
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
        decoration: BoxDecoration(
          color: enabled ? AppTheme.white : AppTheme.black60.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: borderValidate),
        ),
        child: TextLabel(
          text: controller.text != '' ? controller.text : hintText,
          color: controller.text != '' ? AppTheme.black : AppTheme.gray9CA3AF,
          fontSize:
              Utilities.sizeFontWithDesityForDisplay(context, AppFontSize.big),
        ),
      ),
    );
  }
}
