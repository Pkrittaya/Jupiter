import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/presentation/widgets/modal_calendar.dart';
import 'package:jupiter/src/presentation/widgets/modal_select_list.dart';
import 'package:jupiter/src/presentation/widgets/phone_formatter.dart';
import 'package:jupiter/src/utilities.dart';

class ProfileFieldEdit extends StatefulWidget {
  const ProfileFieldEdit({
    super.key,
    required this.onChangeSetHasEditTrue,
    required this.controllerUsername,
    required this.controllerFirstName,
    required this.controllerLastName,
    required this.controllerBirthDay,
    required this.controllerPhoneNumber,
    required this.controllerGender,
  });
  final Function(String?) onChangeSetHasEditTrue;
  final TextEditingController controllerUsername;
  final TextEditingController controllerFirstName;
  final TextEditingController controllerLastName;
  final TextEditingController controllerBirthDay;
  final TextEditingController controllerPhoneNumber;
  final TextEditingController controllerGender;
  @override
  _ProfileFieldEditState createState() => _ProfileFieldEditState();
}

class _ProfileFieldEditState extends State<ProfileFieldEdit> {
  List<dynamic> genderList = [
    {
      'value': translate('input_form.register.gender_list.male.value'),
      'text': translate('input_form.register.gender_list.male.text'),
    },
    {
      'value': translate('input_form.register.gender_list.female.value'),
      'text': translate('input_form.register.gender_list.female.text'),
    },
    {
      'value':
          translate('input_form.register.gender_list.rather_not_say.value'),
      'text': translate('input_form.register.gender_list.rather_not_say.text'),
    }
  ];
  int indexGender = 0;
  String beforeGender = '';
  int beforeIndexGender = 0;
  // SELECT BIRTHDATE
  List<dynamic> dayList = [];
  List<dynamic> monthList = [];
  List<dynamic> yearList = [];
  int indexDay = 0;
  String beforeDay = '';
  int beforeIndexDay = 0;
  int indexMonth = 0;
  String beforeMonth = '';
  int beforeIndexMonth = 2;
  int indexYear = 0;
  String beforeYear = '';
  int beforeIndexYear = 0;
  FixedExtentScrollController controllerDay = FixedExtentScrollController();
  FixedExtentScrollController controllerMonth = FixedExtentScrollController();
  FixedExtentScrollController controllerYear = FixedExtentScrollController();

  void initialDate() {
    FocusScope.of(context).unfocus();
    List<String> splitDate = widget.controllerBirthDay.text.split('/');
    yearList = Utilities.generrateListYear();
    beforeIndexYear = yearList.indexOf(splitDate[2]);
    indexYear = beforeIndexYear;
    beforeYear = yearList[indexYear];
    monthList = MonthWordList.MONTHS;
    beforeIndexMonth = int.parse(splitDate[1]) - 1;
    indexMonth = beforeIndexMonth;
    beforeMonth = '${indexMonth < 9 ? '0' : ''}${(indexMonth + 1).toString()}';
    dayList = Utilities.generrateListDay();
    beforeIndexDay = int.parse(splitDate[0]) - 1;
    indexDay = beforeIndexDay;
    beforeDay = '${indexDay < 9 ? '0' : ''}${(indexDay + 1).toString()}';
    controllerDay = FixedExtentScrollController(initialItem: indexDay);
    controllerMonth = FixedExtentScrollController(initialItem: indexMonth);
    controllerYear = FixedExtentScrollController(initialItem: indexYear);
  }

  void initialGender() {
    FocusScope.of(context).unfocus();
    if (widget.controllerGender.text == genderList[0]['value']) {
      beforeGender = genderList[0]['value'];
      indexGender = 0;
    } else if (widget.controllerGender.text == genderList[1]['value']) {
      beforeGender = genderList[1]['value'];
      indexGender = 1;
    } else {
      beforeGender = genderList[2]['value'];
      indexGender = 2;
    }
  }

  void onChangeDay(int index) {
    if (int.parse(yearList[beforeIndexYear]) % 4 != 0 &&
        beforeIndexMonth == 1 &&
        index > 27) {
      beforeIndexDay = 27;
      controllerDay.animateToItem(
        27,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    } else if (int.parse(yearList[beforeIndexYear]) % 4 == 0 &&
        beforeIndexMonth == 1 &&
        index > 28) {
      beforeIndexDay = 28;
      controllerDay.animateToItem(
        28,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    } else if (index > 29 &&
        (beforeIndexMonth == 3 ||
            beforeIndexMonth == 5 ||
            beforeIndexMonth == 8 ||
            beforeIndexMonth == 10)) {
      beforeIndexDay = 29;
      controllerDay.animateToItem(
        29,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    } else {
      beforeIndexDay = index;
    }
  }

  void onChangeMonth(int index) {
    // IF MONTH IS FEB AND THIS YEAR HAVE 29 DAYS
    if (index == 1 &&
        int.parse(yearList[beforeIndexYear]) % 4 == 0 &&
        beforeIndexDay > 28) {
      beforeIndexDay = 28;
      controllerDay.animateToItem(
        28,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
    // IF MONTH IS FEB AND THIS YEAR HAVE 28 DAYS
    else if (index == 1 &&
        int.parse(yearList[beforeIndexYear]) % 4 != 0 &&
        beforeIndexDay > 27) {
      beforeIndexDay = 27;
      controllerDay.animateToItem(
        27,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
    // IF MONTH HAVE 30 DAYS
    else if ((index == 3 || index == 5 || index == 8 || index == 10) &&
        beforeIndexDay > 29) {
      beforeIndexDay = 29;
      controllerDay.animateToItem(
        29,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
    beforeIndexMonth = index;
  }

  void onChangeYear(int index) {
    if (int.parse(yearList[index]) % 4 == 0 &&
        beforeIndexMonth == 1 &&
        beforeIndexDay > 28) {
      beforeIndexDay = 28;
      controllerDay.animateToItem(
        28,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    } else if (int.parse(yearList[index]) % 4 != 0 &&
        beforeIndexMonth == 1 &&
        beforeIndexDay > 27) {
      beforeIndexDay = 27;
      controllerDay.animateToItem(
        27,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
    beforeIndexYear = index;
  }

  void onDoneModalCalendar() {
    indexDay = beforeIndexDay;
    indexMonth = beforeIndexMonth;
    indexYear = beforeIndexYear;
    widget.controllerBirthDay.text =
        '${indexDay < 9 ? '0' : ''}${dayList[indexDay]}' +
            '/${indexMonth < 9 ? '0' : ''}${indexMonth + 1}/' +
            yearList[indexYear];
    if (widget.controllerBirthDay.text == '') {
      indexDay = 0;
      indexMonth = 0;
      indexYear = yearList[yearList.length - 1];
      widget.controllerBirthDay.text =
          '${indexDay < 9 ? '0' : ''}${dayList[indexDay]}' +
              '/${indexMonth < 9 ? '0' : ''}${indexMonth + 1}/' +
              yearList[indexYear];
    }
    widget.onChangeSetHasEditTrue('');
    setState(() {});
    Navigator.of(context).pop();
  }

  void onChangeGender(int index) {
    beforeGender = genderList[index]['value'];
    beforeIndexGender = index;
  }

  void onDoneModalGender() {
    widget.controllerGender.text = beforeGender;
    indexGender = beforeIndexGender;
    if (widget.controllerGender.text == '') {
      beforeGender = genderList[0]['value'];
      widget.controllerGender.text = beforeGender;
      indexGender = 0;
    }
    widget.onChangeSetHasEditTrue('');
    setState(() {});
    Navigator.of(context).pop();
  }

  void whenComplete() {
    setState(() {});
    try {
      FocusScope.of(context).requestFocus(new FocusNode());
    } catch (e) {}
  }

  String getTextGenderFromTextController() {
    if (widget.controllerGender.text == genderList[0]['value']) {
      return genderList[0]['text'];
    } else if (widget.controllerGender.text == genderList[1]['value']) {
      return genderList[1]['text'];
    } else {
      return genderList[2]['text'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.white,
      ),
      child: Column(
        children: [
          TextInputForm(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            controller: widget.controllerFirstName,
            style: TextStyle(
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.big),
            ),
            hintText: translate('input_form.register.name'),
            hintStyle: TextStyle(
                color: AppTheme.gray9CA3AF,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.big)),
            onSaved: (text) {},
            onChanged: widget.onChangeSetHasEditTrue,
            fillColor: AppTheme.white,
            borderColor: AppTheme.borderGray,
            keyboardType: TextInputType.text,
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
          TextInputForm(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            controller: widget.controllerLastName,
            style: TextStyle(
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.big),
            ),
            hintText: translate('input_form.register.lastname'),
            hintStyle: TextStyle(
                color: AppTheme.gray9CA3AF,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.big)),
            onSaved: (text) {},
            onChanged: widget.onChangeSetHasEditTrue,
            fillColor: AppTheme.white,
            borderColor: AppTheme.borderGray,
            keyboardType: TextInputType.text,
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
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    initialGender();
                    showModalBottomSheet(
                      context: context,
                      // enableDrag: false,
                      // isDismissible: false,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(12))),
                      builder: (BuildContext context) {
                        return ModalSelectList(
                          type: 'GENDER',
                          listItem: genderList,
                          initialIndex: indexGender,
                          onChange: onChangeGender,
                          onDoneModal: onDoneModalGender,
                        );
                      },
                    ).whenComplete(whenComplete);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      border: Border.all(color: AppTheme.borderGray),
                    ),
                    height: 48,
                    child: TextLabel(
                      text: widget.controllerGender.text != ''
                          ? getTextGenderFromTextController()
                          : translate('input_form.register.gender'),
                      color: widget.controllerGender.text != ''
                          ? AppTheme.black
                          : AppTheme.gray9CA3AF,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.big),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: InkWell(
                  onTap: () {
                    initialDate();
                    showModalBottomSheet(
                      context: context,
                      // enableDrag: false,
                      // isDismissible: false,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(12))),
                      builder: (BuildContext context) {
                        return ModalCalendar(
                          title: translate('input_form.register.birthdate'),
                          controllerDay: controllerDay,
                          controllerMonth: controllerMonth,
                          controllerYear: controllerYear,
                          listDay: dayList,
                          listMonth: monthList,
                          listYear: yearList,
                          initialIndexDay: indexDay,
                          initialIndexMonth: indexMonth,
                          initialIndexYear: indexYear,
                          onChangeDay: onChangeDay,
                          onChangeMonth: onChangeMonth,
                          onChangeYear: onChangeYear,
                          onDoneModal: onDoneModalCalendar,
                        );
                      },
                    ).whenComplete(whenComplete);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      border: Border.all(color: AppTheme.borderGray),
                    ),
                    height: 48,
                    child: TextLabel(
                      text: widget.controllerBirthDay.text != ''
                          ? widget.controllerBirthDay.text
                          : translate('input_form.register.birthdate'),
                      color: widget.controllerBirthDay.text != ''
                          ? AppTheme.black
                          : AppTheme.gray9CA3AF,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.big),
                    ),
                  ),
                ),
              ),
              //     Expanded(
              //       child: TextInputForm(
              //         contentPadding: EdgeInsets.symmetric(horizontal: 10),
              //         controller: widget.controllerBirthDay,
              //         style: TextStyle(
              //           fontSize: Utilities.sizeFontWithDesityForDisplay(
              //               context, AppFontSize.big),
              //         ),
              //         hintText: translate('input_form.register.birthdate'),
              //         hintStyle: TextStyle(
              //             color: AppTheme.gray9CA3AF,
              //             fontSize: Utilities.sizeFontWithDesityForDisplay(
              //                 context, AppFontSize.big)),
              //         fillColor: AppTheme.white,
              //         borderRadius: 12,
              //         obscureText: false,
              //         borderColor: AppTheme.black20,
              //         onSaved: (text) {},
              //         keyboardType: TextInputType.text,
              //         readOnly: true,
              //         errorStyle: TextStyle(height: 0),
              //         onTap: () {
              //           Utilities.onBirthDayTap(
              //             context,
              //             textField: widget.controllerBirthDay,
              //           );
              //           widget.onChangeSetHasEditTrue('');
              //         },
              //         validator: (text) {
              //           if (text == null || text == '') {
              //             return '';
              //           }
              //         },
              //       ),
              //     ),
            ],
          ),
          const SizedBox(height: 8),
          TextInputForm(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            controller: widget.controllerPhoneNumber,
            style: TextStyle(
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.big),
            ),
            hintText: translate('input_form.register.mobile'),
            hintStyle: TextStyle(
                color: AppTheme.gray9CA3AF,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.big)),
            onSaved: (text) {},
            onChanged: widget.onChangeSetHasEditTrue,
            fillColor: AppTheme.white,
            borderColor: AppTheme.borderGray,
            keyboardType: TextInputType.number,
            obscureText: false,
            errorStyle: TextStyle(height: 0),
            maxLength: 12,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              PhoneNumberTextInputFormatter()
            ],
            validator: (text) {
              if (text == null || text == '') {
                return '';
              }
              if (!RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                  .hasMatch(text)) {
                return '';
              }
              return '';
            },
          ),
        ],
      ),
    );
  }
}
