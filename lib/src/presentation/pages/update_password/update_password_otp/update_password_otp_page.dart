import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/request_otp_forgot_pin_entity.dart';
import 'package:jupiter/src/presentation/pages/update_password/cubit/update_password_cubit.dart';
import 'package:jupiter/src/presentation/pages/update_password/update_password_page.dart';
import 'package:jupiter/src/presentation/widgets/button_close_keyboard.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/presentation/widgets/loading_page.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:pinput/pinput.dart';

import '../../../../firebase_log.dart';

class UpdatePasswordOtpPage extends StatefulWidget {
  const UpdatePasswordOtpPage({super.key});

  @override
  State<UpdatePasswordOtpPage> createState() => _UpdatePasswordOtpPageState();
}

class _UpdatePasswordOtpPageState extends State<UpdatePasswordOtpPage> {
  // OTP
  String phoneNumber = '';
  String email = '';
  String refCode = '';
  RequestOtpForgotPinEntity? requestOtpdata;
  Timer? countdownTimer;
  Duration myDuration =
      const Duration(minutes: ConstValue.countDownOTPCanResend);
  bool timerOn = true;
  bool timerOff = false;
  var otpPin = '';
  bool loadingPage = false;
  final pinController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    FirebaseLog.logPage(this);
    initValue();
    BlocProvider.of<UpdatePasswordCubit>(context).fetchLoadProfile();
    super.initState();
  }

  String formatPhoneNumber(String text) {
    try {
      final List<String> parts = [];
      for (int i = 0; i < text.length; i++) {
        final String char = text[i];
        if (i == 3 || i == 6) {
          parts.add('-');
        }
        if (char != '-') {
          parts.add(char);
        }
      }
      final String formattedText = parts.join('');
      return formattedText;
    } catch (e) {
      return text;
    }
  }

  void initValue() {
    phoneNumber = '';
    refCode = '';
    requestOtpdata = null;
  }

  void onPressedBackButton() {
    try {
      stopTimer();
      Navigator.of(context).pop();
    } catch (e) {
      Navigator.of(context).pop();
    }
  }

  void onPressedPinCompleted(pin) {
    if (pin.length == 6) {
      otpPin = pin;
      BlocProvider.of<UpdatePasswordCubit>(context)
          .fetchVerifyOtpUpdatePassword(
        otpCode: otpPin,
        otpRefNumber: refCode,
        telphoneNumber: phoneNumber,
      );
    }
  }

  void startTimer() {
    if (!(countdownTimer?.isActive ?? false)) {
      if (!timerOff) {
        debugPrint('timerOn');
        countdownTimer =
            Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
      }
    }
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    if (timerOff) {
      BlocProvider.of<UpdatePasswordCubit>(context)
          .fetchRequestOtpUpdatePassword(phoneNumber);
    }
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
        timerOff = true;
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
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

  void actionLoadProfileSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          phoneNumber = state.profileEntity?.telphonenumber ?? '';
          email = state.profileEntity?.username ?? '';
        });
        BlocProvider.of<UpdatePasswordCubit>(context)
            .fetchRequestOtpUpdatePassword(phoneNumber);
      }
    });
  }

  void actionLoadProfileFailure(state) {
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
            Navigator.of(context).pop();
          },
        );
        BlocProvider.of<UpdatePasswordCubit>(context).resetStateInitial();
      }
    });
  }

  void actionRequestOtpSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          requestOtpdata = state.requestOtpdata;
          refCode = requestOtpdata?.otpRefNumber ?? '';
          timerOff = false;
          myDuration =
              const Duration(minutes: ConstValue.countDownOTPCanResend);
          loadingPage = false;
        });
        startTimer();
      }
    });
  }

  void actionRequestOtpFailure(state) {
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
            Navigator.of(context).pop();
          },
        );
        BlocProvider.of<UpdatePasswordCubit>(context).resetStateInitial();
      }
    });
  }

  void actionVerifyOtpSuccess() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        BlocProvider.of<UpdatePasswordCubit>(context).resetStateInitial();
        stopTimer();
        setState(() {
          loadingPage = false;
        });
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return UpdatePasswordPage();
          },
        ));
      }
    });
  }

  void actionVerifyOtpFailure(state) {
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
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    // startTimer();

    return Stack(
      children: [
        Scaffold(
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
                    case LoadProfileSuccess:
                      actionLoadProfileSuccess(state);
                      break;
                    case LoadProfileFailure:
                      actionLoadProfileFailure(state);
                      break;
                    case RequestOtpSuccess:
                      actionRequestOtpSuccess(state);
                      break;
                    case RequestOtpFailure:
                      actionRequestOtpFailure(state);
                      break;
                    case VerifyOtpSuccess:
                      actionVerifyOtpSuccess();
                      break;
                    case VerifyOtpFailure:
                      actionVerifyOtpFailure(state);
                      break;
                  }
                  return NotificationListener<OverscrollIndicatorNotification>(
                    onNotification:
                        (OverscrollIndicatorNotification overscroll) {
                      overscroll.disallowIndicator();
                      return true;
                    },
                    child: SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        color: AppTheme.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            TextLabel(
                              text: translate('input_form.otp.title'),
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.normallarge),
                              color: AppTheme.blueDark,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(height: 16),
                            TextLabel(
                              text: translate('input_form.otp.sub_title'),
                              color: AppTheme.gray9CA3AF,
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.big),
                            ),
                            const SizedBox(height: 4),
                            TextLabel(
                              // text: '${email}',
                              text: formatPhoneNumber(phoneNumber),
                              color: AppTheme.black,
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.big),
                            ),
                            TextLabel(
                              text: 'REF : ${refCode}',
                              color: AppTheme.black.withOpacity(0.7),
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.normal),
                            ),
                            const SizedBox(height: 36),
                            TextLabel(
                              text: timerOff ? '' : '$minutes:$seconds ',
                              color: AppTheme.lightBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.normallarge),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Pinput(
                                length: 6,
                                controller: pinController,
                                focusNode: focusNode,
                                // androidSmsAutofillMethod:
                                //     AndroidSmsAutofillMethod
                                //         .smsUserConsentApi,
                                // listenForMultipleSmsOnAndroid: true,
                                defaultPinTheme: PinTheme(
                                  width: 42,
                                  height: 42,
                                  textStyle: const TextStyle(
                                      fontSize: 22,
                                      color: AppTheme.black,
                                      fontWeight: FontWeight.bold),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        Border.all(color: AppTheme.lightBlue),
                                  ),
                                ),
                                separatorBuilder: (index) =>
                                    const SizedBox(width: 10),
                                onCompleted: (pin) {
                                  onPressedPinCompleted(pin);
                                },
                                onChanged: (pin) => {otpPin = pin},
                                cursor: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 9),
                                      width: 22,
                                      height: 1,
                                      color: AppTheme.lightBlue,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextLabel(
                                  text: translate('input_form.otp.resend_otp'),
                                  color: AppTheme.gray9CA3AF,
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (timerOff) {
                                      resetTimer();
                                    }
                                  },
                                  child: TextLabel(
                                    text: translate('input_form.otp.resend')
                                        .toUpperCase(),
                                    color: timerOff
                                        ? AppTheme.lightBlue
                                        : AppTheme.gray9CA3AF,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        Utilities.sizeFontWithDesityForDisplay(
                                            context, AppFontSize.big),
                                  ),
                                )
                              ],
                            ),
                          ],
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
    );
  }
}
