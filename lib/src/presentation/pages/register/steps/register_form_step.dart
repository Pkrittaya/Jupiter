import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/pages/register/cubit/register_cubit.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jupiter/src/presentation/widgets/modal_calendar.dart';
import 'package:jupiter/src/presentation/widgets/modal_select_list.dart';
import 'package:jupiter/src/presentation/widgets/phone_formatter.dart';
import 'package:jupiter/src/utilities.dart';

class RegisterFormStep extends StatefulWidget {
  RegisterFormStep({
    Key? key,
    required this.formKey,
    required this.emailField,
    required this.passwordField,
    required this.confirmPasswordField,
    required this.firstnameField,
    required this.lastnameField,
    required this.genderField,
    required this.mobileField,
    required this.birthdayField,
    // required this.isErrorEmail,
    // required this.isErrorPassword,
    // required this.isErrorConfirmPassword,
    // required this.isErrorFirstname,
    // required this.isErrorLastname,
    // required this.isErrorMobile,
    required this.statusPassword,
    required this.statusConfirmPassword,
    required this.isOpenKeyboard,
    required this.onChanged,
  }) : super(key: key);

  final GlobalKey formKey;
  final TextEditingController emailField;
  final TextEditingController passwordField;
  final TextEditingController confirmPasswordField;
  final TextEditingController firstnameField;
  final TextEditingController lastnameField;
  final TextEditingController genderField;
  final TextEditingController mobileField;
  final TextEditingController birthdayField;
  // final bool isErrorEmail;
  // final bool isErrorPassword;
  // final bool isErrorConfirmPassword;
  // final bool isErrorFirstname;
  // final bool isErrorLastname;
  // final bool isErrorMobile;
  final String statusPassword;
  final String statusConfirmPassword;
  final bool isOpenKeyboard;
  final Function(String?, String) onChanged;

  @override
  _RegisterFormStepState createState() => _RegisterFormStepState();
}

class _RegisterFormStepState extends State<RegisterFormStep> {
  // GENDER STATE
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
  // DATE STATE

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
  // WIDGET SIZE
  double spaceLineHeight = 8;
  double heightTitle = 70;
  double heightStep = 64;
  double paddingHorizontal = 40;
  double paddingHorizontalField = 16;
  String obscuringCharacter = '•';
  bool visiblePassword = false;
  bool visibleConfirmPassword = false;
  List<String> idField = [
    'EMAIL',
    'PASSWORD',
    'CONFIRM_PASSWORD',
    'FIRSTNAME',
    'LASTNAME',
    'MOBILE',
  ];
  final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');

  GlobalKey<State<StatefulWidget>> keyEmail =
      GlobalKey<State<StatefulWidget>>();
  GlobalKey<State<StatefulWidget>> keyPassword =
      GlobalKey<State<StatefulWidget>>();
  GlobalKey<State<StatefulWidget>> keyConfirmPassword =
      GlobalKey<State<StatefulWidget>>();
  GlobalKey<State<StatefulWidget>> keyName = GlobalKey<State<StatefulWidget>>();
  GlobalKey<State<StatefulWidget>> keyLastName =
      GlobalKey<State<StatefulWidget>>();
  GlobalKey<State<StatefulWidget>> keyMobile =
      GlobalKey<State<StatefulWidget>>();

  @override
  void initState() {
    initialDate();
    widget.genderField.text =
        translate('input_form.register.gender_list.male.value');
    super.initState();
  }

  void initialDate() {
    yearList = Utilities.generrateListYear();
    beforeIndexYear = 0; //yearList.length - 1;
    indexYear = beforeIndexYear;
    beforeYear = yearList[indexYear];
    monthList = MonthWordList.MONTHS;
    beforeIndexMonth = 0;
    indexMonth = 0;
    beforeMonth = (indexMonth + 1).toString();
    dayList = Utilities.generrateListDay();
    beforeIndexDay = 0;
    indexDay = 0;
    beforeDay = dayList[indexDay];
    controllerDay = FixedExtentScrollController(initialItem: indexDay);
    controllerMonth = FixedExtentScrollController(initialItem: indexMonth);
    controllerYear = FixedExtentScrollController(initialItem: indexYear);
    widget.birthdayField.text = '${indexDay < 9 ? '0' : ''}${beforeDay}' +
        '/${indexMonth < 9 ? '0' : ''}${beforeMonth}/' +
        yearList[indexYear];
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
    widget.birthdayField.text =
        '${indexDay < 9 ? '0' : ''}${dayList[indexDay]}' +
            '/${indexMonth < 9 ? '0' : ''}${indexMonth + 1}/' +
            yearList[indexYear];
    if (widget.birthdayField.text == '') {
      indexDay = 0;
      indexMonth = 0;
      indexYear = yearList[yearList.length - 1];
      widget.birthdayField.text =
          '${indexDay < 9 ? '0' : ''}${dayList[indexDay]}' +
              '/${indexMonth < 9 ? '0' : ''}${indexMonth + 1}/' +
              yearList[indexYear];
    }
    controllerDay = FixedExtentScrollController(initialItem: indexDay);
    controllerMonth = FixedExtentScrollController(initialItem: indexMonth);
    controllerYear = FixedExtentScrollController(initialItem: indexYear);
    setState(() {});
    Navigator.of(context).pop();
  }

  void onChangeGender(int index) {
    beforeGender = genderList[index]['value'];
    beforeIndexGender = index;
  }

  void onDoneModalGender() {
    widget.genderField.text = beforeGender;
    indexGender = beforeIndexGender;
    if (widget.genderField.text == '') {
      beforeGender = genderList[0]['value'];
      widget.genderField.text = beforeGender;
      indexGender = 0;
    }
    setState(() {});
    Navigator.of(context).pop();
  }

  void whenComplete() {
    try {
      FocusScope.of(context).requestFocus(new FocusNode());
    } catch (e) {}
    setState(() {});
  }

  String getTextGenderFromIndex() {
    return genderList[indexGender]['text'];
  }

  Color getColorStatusPassword(String value) {
    switch (value) {
      case 'DEFAULT':
        return AppTheme.grayF1F5F9;
      case 'PASSWORD_CORRECT':
        return AppTheme.green80;
      case 'CONFIRM_PASSWORD_CORRECT':
        return AppTheme.green80;
      case 'PASSWORD_INCORRECT':
        return AppTheme.red;
      case 'CONFIRM_PASSWORD_INCORRECT':
        return AppTheme.red;
      default:
        return AppTheme.grayF1F5F9;
    }
  }

  Color getColorStatusPasswordDescription() {
    if (widget.statusPassword == 'PASSWORD_INCORRECT' ||
        widget.statusConfirmPassword == 'CONFIRM_PASSWORD_INCORRECT') {
      return AppTheme.red;
    } else {
      return AppTheme.gray9CA3AF;
    }
  }

  Color getColorFillOnFieldStatusPassword(String value) {
    switch (value) {
      case 'DEFAULT':
        return AppTheme.grayF1F5F9;
      case 'PASSWORD_CORRECT':
        return AppTheme.green80.withOpacity(0.15);
      case 'CONFIRM_PASSWORD_CORRECT':
        return AppTheme.green80.withOpacity(0.15);
      case 'PASSWORD_INCORRECT':
        return AppTheme.red80.withOpacity(0.15);
      case 'CONFIRM_PASSWORD_INCORRECT':
        return AppTheme.red80.withOpacity(0.15);
      default:
        return AppTheme.grayF1F5F9;
    }
  }

  Color getColorFillOnFieldEmail() {
    if (widget.emailField.text.trim() != '') {
      if (emailRegex.hasMatch(widget.emailField.text.trim())) {
        return AppTheme.grayF1F5F9;
      }
      return AppTheme.red80.withOpacity(0.15);
    } else {
      return AppTheme.grayF1F5F9;
    }
  }

  Color getColorStatusEmail() {
    if (widget.emailField.text.trim() != '') {
      if (emailRegex.hasMatch(widget.emailField.text.trim())) {
        return AppTheme.grayF1F5F9;
      }
      return AppTheme.red;
    }
    return AppTheme.grayF1F5F9;
  }

  void actionRegisterLoading() {}

  void actionVerifyAccountFailure() {}

  void actionVerifyAccountSuccess() {}

  @override
  Widget build(BuildContext context) {
    double paddingHorizontal = 40;

    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: heightTitle,
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
            child: TextLabel(
              color: AppTheme.blueDark,
              text: translate('register_page.header'),
              fontWeight: FontWeight.bold,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.huge),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                switch (state.runtimeType) {
                  case RegisterLoading:
                    actionRegisterLoading();
                    break;
                  case VerifyAccountFailure:
                    actionVerifyAccountFailure();
                    break;
                  case VerifyAccountSuccess:
                    actionVerifyAccountSuccess();
                    break;
                  default:
                    break;
                }
                return renderFieldGroup();
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderFieldGroup() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        renderTextField(
          key: keyEmail,
          id: idField[0],
          controller: widget.emailField,
          hint: translate('input_form.register.email'),
          maxLength: 100,
          fillColor: getColorFillOnFieldEmail(),
          borderColor: getColorStatusEmail(),
          keyboardType: TextInputType.emailAddress,
          obscureText: false,
        ),
        SizedBox(height: spaceLineHeight),
        renderTextField(
          key: keyPassword,
          id: idField[1],
          controller: widget.passwordField,
          hint: translate('input_form.register.password_hint'),
          maxLength: 100,
          fillColor: getColorFillOnFieldStatusPassword(widget.statusPassword),
          borderColor: getColorStatusPassword(widget.statusPassword),
          keyboardType: TextInputType.visiblePassword,
          obscureText: !visiblePassword,
          suffixIcon: renderVisibilityIcon('PASSWORD', visiblePassword),
        ),
        SizedBox(height: spaceLineHeight),
        renderTextField(
          key: keyConfirmPassword,
          id: idField[2],
          controller: widget.confirmPasswordField,
          hint: translate('input_form.register.confirm_password'),
          maxLength: 100,
          fillColor:
              getColorFillOnFieldStatusPassword(widget.statusConfirmPassword),
          borderColor: getColorStatusPassword(widget.statusConfirmPassword),
          keyboardType: TextInputType.visiblePassword,
          obscureText: !visibleConfirmPassword,
          suffixIcon:
              renderVisibilityIcon('CONFIRM_PASSWORD', visibleConfirmPassword),
        ),
        SizedBox(height: spaceLineHeight),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextLabel(
            color: getColorStatusPasswordDescription(),
            text: translate('register_page.rule_password'),
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.little),
          ),
        ),
        SizedBox(height: spaceLineHeight * 2),
        renderTextField(
          key: keyName,
          id: idField[3],
          controller: widget.firstnameField,
          hint: translate('input_form.register.name'),
          maxLength: 100,
          fillColor: AppTheme.grayF1F5F9,
          borderColor: AppTheme.grayF1F5F9,
          keyboardType: TextInputType.name,
          obscureText: false,
          onTap: () {
            Utilities.ensureVisibleOnTextInput(textfieldKey: keyName);
          },
        ),
        SizedBox(height: spaceLineHeight),
        renderTextField(
          key: keyLastName,
          id: idField[4],
          controller: widget.lastnameField,
          hint: translate('input_form.register.lastname'),
          maxLength: 100,
          fillColor: AppTheme.grayF1F5F9,
          borderColor: AppTheme.grayF1F5F9,
          keyboardType: TextInputType.name,
          obscureText: false,
          onTap: () {
            Utilities.ensureVisibleOnTextInput(textfieldKey: keyLastName);
          },
        ),
        SizedBox(height: spaceLineHeight),
        InkWell(
          onTap: () {
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
            padding: EdgeInsets.symmetric(
                horizontal: paddingHorizontalField, vertical: 13),
            decoration: BoxDecoration(
              color: AppTheme.grayF1F5F9,
              borderRadius: BorderRadius.all(
                Radius.circular(200),
              ),
            ),
            child: TextLabel(
              text: widget.genderField.text != ''
                  ? getTextGenderFromIndex()
                  : translate('input_form.register.gender'),
              color: widget.genderField.text != ''
                  ? AppTheme.black
                  : AppTheme.gray9CA3AF,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.big),
            ),
          ),
        ),
        SizedBox(height: spaceLineHeight),
        InkWell(
          onTap: () {
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
            padding: EdgeInsets.symmetric(
                horizontal: paddingHorizontalField, vertical: 13),
            decoration: BoxDecoration(
              color: AppTheme.grayF1F5F9,
              borderRadius: BorderRadius.all(
                Radius.circular(200),
              ),
            ),
            child: TextLabel(
              text: widget.birthdayField.text != ''
                  ? widget.birthdayField.text
                  : translate('input_form.register.birthdate'),
              color: widget.birthdayField.text != ''
                  ? AppTheme.black
                  : AppTheme.gray9CA3AF,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.big),
            ),
          ),
        ),
        SizedBox(height: spaceLineHeight),
        renderTextField(
            key: keyMobile,
            id: idField[5],
            controller: widget.mobileField,
            hint: translate('input_form.register.mobile'),
            keyboardType: TextInputType.phone,
            maxLength: 12,
            fillColor: AppTheme.grayF1F5F9,
            borderColor: AppTheme.grayF1F5F9,
            obscureText: false,
            onTap: () {
              Utilities.ensureVisibleOnTextInput(textfieldKey: keyMobile);
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              PhoneNumberTextInputFormatter()
            ]),
        // spacebottomHeight //
        SizedBox(
          height: (MediaQuery.of(context).size.height * 0.2),
        )
      ],
    );
  }

  Widget renderTextField(
      {required String id,
      required TextEditingController controller,
      required String hint,
      required bool obscureText,
      required TextInputType keyboardType,
      required int maxLength,
      required Color fillColor,
      required Color borderColor,
      Widget? suffixIcon,
      required GlobalKey<State<StatefulWidget>> key,
      List<TextInputFormatter>? inputFormatters,
      Function()? onTap}) {
    return TextInputForm(
      key: key,
      inputFormatters: inputFormatters,
      contentPadding: EdgeInsets.symmetric(horizontal: paddingHorizontalField),
      controller: controller,
      hintText: hint,
      hintStyle: TextStyle(
        color: AppTheme.gray9CA3AF,
        fontSize:
            Utilities.sizeFontWithDesityForDisplay(context, AppFontSize.big),
      ),
      style: TextStyle(
        fontSize:
            Utilities.sizeFontWithDesityForDisplay(context, AppFontSize.big),
      ),
      borderColor: borderColor,
      fillColor: fillColor,
      borderRadius: 200,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      keyboardType: keyboardType,
      maxLength: maxLength,
      suffixIcon: suffixIcon,
      errorStyle: TextStyle(height: 0),
      onChanged: (value) {
        widget.onChanged(value, id);
      },
      onSaved: (text) {},
      onTap: onTap,
    );
  }

  Widget renderVisibilityIcon(String name, bool visible) {
    return InkWell(
      onTap: () {
        if (name == 'PASSWORD') {
          setState(() {
            visiblePassword = !visiblePassword;
          });
        }
        if (name == 'CONFIRM_PASSWORD') {
          setState(() {
            visibleConfirmPassword = !visibleConfirmPassword;
          });
        }
      },
      child: visible
          ? Icon(Icons.visibility_off, color: AppTheme.black40)
          : Icon(Icons.visibility, color: AppTheme.black40),
    );
  }
}
