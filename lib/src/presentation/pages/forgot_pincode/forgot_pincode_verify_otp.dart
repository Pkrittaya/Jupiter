import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/request_otp_forgot_pin_entity.dart';
import 'package:jupiter/src/presentation/pages/create_pincode/create_pincode_page.dart';
import 'package:jupiter/src/presentation/pages/forgot_pincode/cubit/forgot_pincode_cubit.dart';
import 'package:jupiter/src/presentation/pages/profile/cubit/profile_cubit.dart';
import 'package:jupiter/src/presentation/widgets/button_close_keyboard.dart';
import 'package:jupiter/src/presentation/widgets/loading_page.dart';
import 'package:pinput/pinput.dart';
import '../../../firebase_log.dart';
import '../../../utilities.dart';
import '../../widgets/text_label.dart';

class ForgotPinCodeVerifyOTP extends StatefulWidget {
  const ForgotPinCodeVerifyOTP({super.key});
  @override
  State<ForgotPinCodeVerifyOTP> createState() => _ForgotPinCodeVerifyOTPState();
}

class _ForgotPinCodeVerifyOTPState extends State<ForgotPinCodeVerifyOTP> {
  Timer? countdownTimer;
  Duration myDuration =
      const Duration(minutes: ConstValue.countDownOTPCanResend);
  bool timerOff = false;
  var otpPin = '';
  String phoneNumber = '';
  String email = '';
  String refCode = '';
  RequestOtpForgotPinEntity? requestOtpdata;
  bool isLoading = true;
  final pinController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    FirebaseLog.logPage(this);
    initValue();
    BlocProvider.of<ProfileCubit>(context).loadProfile();
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
      stopTimer();
      BlocProvider.of<ForgotPincodeCubit>(context)
          .fetchRequestOtpForgotPinCode(phoneNumber);
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

  void onPressedPinCompleted(pin) {
    if (pin.length == 6) {
      otpPin = pin;
      FocusScope.of(context).unfocus();
      BlocProvider.of<ForgotPincodeCubit>(context).fetchVerifyOtpForgotPinCode(
        otpCode: otpPin,
        otpRefNumber: refCode,
        telphoneNumber: phoneNumber,
      );
    }
  }

  void listenerProfileCubit(ProfileState state) {
    switch (state.runtimeType) {
      case ProfileSuccess:
        phoneNumber = state.profileEntity?.telphonenumber ?? '';
        email = state.profileEntity?.username ?? '';
        BlocProvider.of<ForgotPincodeCubit>(context)
            .fetchRequestOtpForgotPinCode(phoneNumber);
        break;
    }
  }

  void onPressedBackButton() {
    Navigator.of(context).pop();
  }

  void actionRequestOtpToResetPinLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isLoading) {
        setState(() {
          isLoading = true;
        });
      }
    });
  }

  void actionRequestOtpToResetPinFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoading) {
        stopTimer();
        setState(() {
          isLoading = false;
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
      }
    });
    BlocProvider.of<ForgotPincodeCubit>(context).resetStateInitialForgotPin();
  }

  void actionRequestOtpToResetPinSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoading) {
        setState(() {
          requestOtpdata = state.requestOtpdata;
          refCode = requestOtpdata?.otpRefNumber ?? '';
          timerOff = false;
          myDuration =
              const Duration(minutes: ConstValue.countDownOTPCanResend);
          isLoading = false;
        });
        startTimer();
      }
    });
    BlocProvider.of<ForgotPincodeCubit>(context).resetStateInitialForgotPin();
  }

  void actionSendOtpVerifyToResetPinLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isLoading) {
        setState(() {
          isLoading = true;
        });
      }
    });
  }

  void actionSendOtpVerifyToResetPinFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoading) {
        setState(() {
          isLoading = false;
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
      }
    });
    BlocProvider.of<ForgotPincodeCubit>(context).resetStateInitialForgotPin();
  }

  void actionSendOtpVerifyToResetPinSuccess() {
    BlocProvider.of<ForgotPincodeCubit>(context).resetStateInitialForgotPin();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoading) {
        stopTimer();
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return CreatePinCodePage();
          },
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeMedia = MediaQuery.of(context).size;
    String strDigits(int n) => n.toString().padLeft(2, '0');

    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppTheme.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppTheme.white,
            iconTheme: const IconThemeData(
              color: AppTheme.blueDark, //change your color here
            ),
            centerTitle: true,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppTheme.blueDark),
                onPressed: onPressedBackButton),
            title: TextLabel(
              text: '',
              color: AppTheme.blueDark,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.title),
              fontWeight: FontWeight.bold,
            ),
          ),
          body: Stack(
            children: [
              BlocBuilder<ForgotPincodeCubit, ForgotPincodeState>(
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case RequestOtpToResetPinLoading:
                      actionRequestOtpToResetPinLoading();
                      break;
                    case RequestOtpToResetPinFailure:
                      actionRequestOtpToResetPinFailure(state);
                      break;
                    case RequestOtpToResetPinSuccess:
                      actionRequestOtpToResetPinSuccess(state);
                      break;
                    case SendOtpVerifyToResetPinLoading:
                      actionSendOtpVerifyToResetPinLoading();
                      break;
                    case SendOtpVerifyToResetPinFailure:
                      actionSendOtpVerifyToResetPinFailure(state);
                      break;
                    case SendOtpVerifyToResetPinSuccess:
                      actionSendOtpVerifyToResetPinSuccess();
                      break;
                  }
                  return Container(
                    color: AppTheme.white,
                    height: sizeMedia.height,
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        TextLabel(
                          text: translate('input_form.otp.title'),
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.large),
                          color: AppTheme.blueDark,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 16),
                        TextLabel(
                          text: translate('input_form.otp.sub_title'),
                          color: AppTheme.gray9CA3AF,
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.normal),
                        ),
                        const SizedBox(height: 4),
                        BlocListener<ProfileCubit, ProfileState>(
                          listener: (context, state) {
                            listenerProfileCubit(state);
                          },
                          child: TextLabel(
                            // text: '${email}',
                            text: '${formatPhoneNumber(phoneNumber)}',
                            color: AppTheme.black,
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, AppFontSize.normal),
                          ),
                        ),
                        TextLabel(
                          text: 'REF : ${refCode}',
                          color: AppTheme.black.withOpacity(0.7),
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.little),
                        ),
                        const SizedBox(height: 36),
                        TextLabel(
                          text: timerOff ? '' : '$minutes:$seconds ',
                          color: AppTheme.lightBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.large),
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
                                  fontSize: 20,
                                  color: AppTheme.black,
                                  fontWeight: FontWeight.bold),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: AppTheme.lightBlue),
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
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.normal),
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
                                        context, AppFontSize.normal),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              ButtonCloseKeyboard(contextPage: context),
            ],
          ),
        ),
        LoadingPage(visible: isLoading),
      ],
    );
  }
}
