import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter_api/data/data_models/request/signout_account_form.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/presentation/pages/update_password/cubit/update_password_cubit.dart';
import 'package:jupiter/src/presentation/pages/update_password/widgets/update_password_eye_icon.dart';
import 'package:jupiter/src/presentation/widgets/button_close_keyboard.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/presentation/widgets/loading_page.dart';
import 'package:jupiter/src/utilities.dart';
import '../../../firebase_log.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  TextEditingController previousController = TextEditingController();
  TextEditingController newController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  bool visiblePrevious = false;
  bool visibleNew = false;
  bool visibleConfirm = false;
  double heightText = 1.5;
  String obscuringCharacter = '•';
  double paddingField = 16;
  bool loadingPage = false;
  String statusNewPassword = 'DEFAULT';
  String statusConfirmPassword = 'DEFAULT';
  bool canChangePassword = false;
  UserManagementUseCase useCase = getIt();
  List<String> idField = [
    'PASSWORD',
    'NEW_PASSWORD',
    'CONFIRM_PASSWORD',
  ];
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  @override
  void initState() {
    FirebaseLog.logPage(this);
    super.initState();
  }

  void onSubmitPassword() {
    if (canChangePassword) {
      FocusScope.of(context).unfocus();
      BlocProvider.of<UpdatePasswordCubit>(context)
          .fetchUpdatePassword(previousController.text, confirmController.text);
    }
  }

  void onChangedTextField(String? value, String id) {
    if (id == idField[1]) {
      // PASSWORD
      if (validatePatternPassword(newController.text)) {
        setState(() {
          statusNewPassword = 'PASSWORD_CORRECT';
        });
      } else if (newController.text == '') {
        setState(() {
          statusNewPassword = 'DEFAULT';
        });
      } else {
        setState(() {
          statusNewPassword = 'PASSWORD_INCORRECT';
        });
      }
    }
    if (id == idField[1] || id == idField[2]) {
      if (validatePatternPassword(confirmController.text) &&
          confirmController.text == newController.text) {
        setState(() {
          canChangePassword = true;
          statusConfirmPassword = 'CONFIRM_PASSWORD_CORRECT';
        });
      } else if (confirmController.text == '') {
        setState(() {
          canChangePassword = false;
          statusConfirmPassword = 'DEFAULT';
        });
      } else {
        setState(() {
          canChangePassword = false;
          statusConfirmPassword = 'CONFIRM_PASSWORD_INCORRECT';
        });
      }
    }
  }

  bool validatePatternPassword(String input) {
    RegExp pattern = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@.])[a-zA-Z0-9!@.]+$');
    if (pattern.hasMatch(input) && input.length >= 8) {
      return true;
    } else {
      return false;
    }
  }

  void onTapEyeIcon(String name) {
    if (name == 'PASSWORD') {
      setState(() {
        visiblePrevious = !visiblePrevious;
      });
    }
    if (name == 'NEW_PASSWORD') {
      setState(() {
        visibleNew = !visibleNew;
      });
    }
    if (name == 'CONFIRM_PASSWORD') {
      setState(() {
        visibleConfirm = !visibleConfirm;
      });
    }
  }

  void onPressedBackButton() {
    Utilities.alertTwoButtonAction(
      context: context,
      type: AppAlertType.WARNING,
      title: translate('alert.title.warning'),
      description: translate('alert.description.cancel_update_password'),
      textButtonLeft: translate('button.close'),
      onPressButtonLeft: () {
        Navigator.of(context).pop();
      },
      textButtonRight: translate('button.confirm'),
      onPressButtonRight: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );
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

  Color getColorStatusPasswordDescription() {
    if (statusNewPassword == 'PASSWORD_INCORRECT' ||
        statusConfirmPassword == 'CONFIRM_PASSWORD_INCORRECT') {
      return AppTheme.red;
    } else {
      return AppTheme.gray9CA3AF;
    }
  }

  void actionUpdatePasswordLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingPage) {
        setState(() {
          loadingPage = true;
        });
      }
    });
  }

  void actionUpdatePasswordSuccess() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
        });
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.SUCCESS,
          isForce: true,
          title: translate('alert.title.success'),
          description: translate('alert.description.change_password_success'),
          textButton: translate('button.login'),
          onPressButton: () async {
            while (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
            String username = jupiterPrefsAndAppData.username ?? '';
            String deviceCode = jupiterPrefsAndAppData.deviceId ?? '';
            bool? language = jupiterPrefsAndAppData.language;
            final result = await useCase.signOut(SignOutAccountForm(
                username: username,
                deviceCode: deviceCode,
                orgCode: ConstValue.orgCode,
                language: language ?? false ? 'EN' : 'TH'));
            result.fold(
              (failure) {
                debugPrint('SignOut Failure');
                Utilities.logout(context);
              },
              (data) {
                debugPrint('SignOut Success');
                Utilities.logout(context);
              },
            );
          },
        );
      }
    });
  }

  void actionUpdatePasswordFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
        });
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.DEFAULT,
          isForce: true,
          title: translate('alert.title.default'),
          description: state.message ?? translate('alert.description.default'),
          textButton: translate('button.try_again'),
          onPressButton: () {
            Navigator.of(context).pop();
          },
        );
        BlocProvider.of<UpdatePasswordCubit>(context).resetStateInitial();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool value) {
        if (!value) {
          onPressedBackButton();
        }
      },
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: AppTheme.white,
            appBar: AppBar(
              backgroundColor: AppTheme.white,
              bottomOpacity: 0.0,
              elevation: 0.0,
              iconTheme: const IconThemeData(
                color: AppTheme.blueDark, //change your color here
              ),
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppTheme.blueDark),
                  onPressed: onPressedBackButton),
              centerTitle: true,
              title: TextLabel(
                text: translate('app_title.update_password'),
                color: AppTheme.blueDark,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.title),
                fontWeight: FontWeight.w700,
              ),
            ),
            body: Stack(
              children: [
                BlocBuilder<UpdatePasswordCubit, UpdatePasswordState>(
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case UpdatePasswordLoading:
                        actionUpdatePasswordLoading();
                        break;
                      case UpdatePasswordSuccess:
                        actionUpdatePasswordSuccess();
                        break;
                      case UpdatePasswordFailure:
                        actionUpdatePasswordFailure(state);
                        break;
                    }
                    return NotificationListener<
                        OverscrollIndicatorNotification>(
                      onNotification:
                          (OverscrollIndicatorNotification overscroll) {
                        overscroll.disallowIndicator();
                        return true;
                      },
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(48, 16, 48, 0),
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(height: 32),
                                TextInputForm(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: paddingField),
                                  controller: previousController,
                                  style: TextStyle(
                                    fontSize:
                                        Utilities.sizeFontWithDesityForDisplay(
                                            context, AppFontSize.big),
                                    height: heightText,
                                  ),
                                  hintText: translate(
                                      'update_password_page.previous'),
                                  hintStyle: TextStyle(
                                    color: AppTheme.gray9CA3AF,
                                    fontSize:
                                        Utilities.sizeFontWithDesityForDisplay(
                                            context, AppFontSize.big),
                                  ),
                                  suffixIcon: UpdatePasswordEycIcon(
                                    name: 'PASSWORD',
                                    visible: visiblePrevious,
                                    onTap: () {
                                      onTapEyeIcon('PASSWORD');
                                    },
                                  ),
                                  onSaved: (text) {},
                                  onChanged: (text) {},
                                  fillColor: AppTheme.grayF1F5F9,
                                  borderColor: AppTheme.grayF1F5F9,
                                  borderRadius: 200,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: !visiblePrevious,
                                  obscuringCharacter: obscuringCharacter,
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
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: paddingField),
                                  controller: newController,
                                  style: TextStyle(
                                    fontSize:
                                        Utilities.sizeFontWithDesityForDisplay(
                                            context, AppFontSize.big),
                                    height: heightText,
                                  ),
                                  hintText:
                                      translate('update_password_page.new'),
                                  hintStyle: TextStyle(
                                    color: AppTheme.gray9CA3AF,
                                    fontSize:
                                        Utilities.sizeFontWithDesityForDisplay(
                                            context, AppFontSize.big),
                                  ),
                                  suffixIcon: UpdatePasswordEycIcon(
                                    name: 'NEW_PASSWORD',
                                    visible: visibleNew,
                                    onTap: () {
                                      onTapEyeIcon('NEW_PASSWORD');
                                    },
                                  ),
                                  onSaved: (text) {},
                                  onChanged: (text) {
                                    onChangedTextField(text, 'NEW_PASSWORD');
                                  },
                                  fillColor: getColorFillOnFieldStatusPassword(
                                      statusNewPassword),
                                  borderColor:
                                      getColorStatusPassword(statusNewPassword),
                                  borderRadius: 200,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: !visibleNew,
                                  obscuringCharacter: obscuringCharacter,
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
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: paddingField),
                                  controller: confirmController,
                                  style: TextStyle(
                                    fontSize:
                                        Utilities.sizeFontWithDesityForDisplay(
                                            context, AppFontSize.big),
                                  ),
                                  hintText:
                                      translate('update_password_page.confirm'),
                                  hintStyle: TextStyle(
                                    color: AppTheme.gray9CA3AF,
                                    fontSize:
                                        Utilities.sizeFontWithDesityForDisplay(
                                            context, AppFontSize.big),
                                    height: heightText,
                                  ),
                                  suffixIcon: UpdatePasswordEycIcon(
                                    name: 'CONFIRM_PASSWORD',
                                    visible: visibleConfirm,
                                    onTap: () {
                                      onTapEyeIcon('CONFIRM_PASSWORD');
                                    },
                                  ),
                                  onSaved: (text) {},
                                  onChanged: (text) {
                                    onChangedTextField(
                                        text, 'CONFIRM_PASSWORD');
                                  },
                                  fillColor: getColorFillOnFieldStatusPassword(
                                      statusConfirmPassword),
                                  borderColor: getColorStatusPassword(
                                      statusConfirmPassword),
                                  borderRadius: 200,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: !visibleConfirm,
                                  obscuringCharacter: obscuringCharacter,
                                  errorStyle: TextStyle(height: 0),
                                  validator: (text) {
                                    if (text == null || text == '') {
                                      return '';
                                    } else {
                                      return '';
                                    }
                                  },
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: TextLabel(
                                    color: getColorStatusPasswordDescription(),
                                    text: translate(
                                        'register_page.rule_password'),
                                    fontSize:
                                        Utilities.sizeFontWithDesityForDisplay(
                                            context, AppFontSize.small),
                                  ),
                                ),
                                const SizedBox(height: 32),
                                Container(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12),
                                      elevation: 0.0,
                                      shadowColor: Colors.transparent,
                                      backgroundColor: canChangePassword
                                          ? AppTheme.blueD
                                          : AppTheme.gray9CA3AF,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(200)),
                                      ),
                                    ),
                                    onPressed: onSubmitPassword,
                                    child: Text(
                                      translate('button.confirm'),
                                      style: TextStyle(
                                        fontSize: Utilities
                                            .sizeFontWithDesityForDisplay(
                                          context,
                                          AppFontSize.large,
                                        ),
                                        color: AppTheme.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 32)
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                ButtonCloseKeyboard(contextPage: context),
              ],
            ),
          ),
          LoadingPage(visible: loadingPage),
        ],
      ),
    );
  }
}
