import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter_api/data/data_models/request/signup_account_form.dart';
import 'package:jupiter_api/data/data_models/request/verify_account_form.dart';
import 'package:jupiter_api/domain/entities/verify_account_entity.dart';
import 'package:jupiter/src/presentation/pages/register/cubit/register_cubit.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:pinput/pinput.dart';
import '../../../../constant_value.dart';

class OtpStep extends StatefulWidget {
  OtpStep({
    Key? key,
    required this.onContinueStep,
    required this.onCancelStep,
    required this.verifyAccountForm,
    required this.verifyAccountEntity,
    required this.onResendOtp,
    required this.timerOn,
  }) : super(key: key);

  final Function() onContinueStep;
  final Function() onCancelStep;
  final Function() onResendOtp;
  final VerifyAccountEntity? verifyAccountEntity;
  final VerifyAccountForm? verifyAccountForm;
  final bool timerOn;

  @override
  _OtpSteptate createState() => _OtpSteptate();
}

class _OtpSteptate extends State<OtpStep> {
  Timer? countdownTimer;
  Duration myDuration =
      const Duration(minutes: ConstValue.countDownOTPCanResend);
  bool timerOff = false;
  var otpPin = '';
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  bool? language = false;

  @override
  void initState() {
    otpPin = '';
    getLanguage();
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

  void getLanguage() async {
    JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
    language = jupiterPrefsAndAppData.language;
  }

  void startTimer() {
    if (widget.timerOn) {
      if (!(countdownTimer?.isActive ?? false)) {
        if (!timerOff) {
          debugPrint('timerOn');
          countdownTimer =
              Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
        }
      }
    }
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    if (timerOff) {
      timerOff = false;
      widget.onResendOtp();
      myDuration = const Duration(minutes: ConstValue.countDownOTPCanResend);
      startTimer();
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
      SignupAccountForm signupAccountForm = SignupAccountForm(
        username: widget.verifyAccountForm?.username ?? '',
        password: widget.verifyAccountForm?.password ?? '',
        name: widget.verifyAccountForm?.name ?? '',
        lastname: widget.verifyAccountForm?.lastname ?? '',
        telphonenumber: widget.verifyAccountForm?.telphonenumber ?? '',
        gender: widget.verifyAccountForm?.gender ?? '',
        dateofbirth: widget.verifyAccountForm?.dateofbirth ?? DateTime.now(),
        otpCode: pin,
        orgCode: ConstValue.orgCode,
        language: language ?? false ? 'EN' : 'TH',
      );
      BlocProvider.of<RegisterCubit>(context).signUp(signupAccountForm);
    }
  }

  @override
  Widget build(BuildContext context) {
    double heightDevice = MediaQuery.of(context).size.height;
    double heightAppbar = AppBar().preferredSize.height;
    double heightPage = heightDevice - heightAppbar - 40;

    String strDigits(int n) => n.toString().padLeft(2, '0');

    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    startTimer();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: AppTheme.white,
          height: heightPage * 0.85,
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
                text: translate(
                  'input_form.otp.sub_title',
                ),
                color: AppTheme.gray9CA3AF,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.big),
              ),
              const SizedBox(height: 4),
              TextLabel(
                // text: widget.verifyAccountForm?.username ?? '',
                text: formatPhoneNumber(
                    widget.verifyAccountForm?.telphonenumber ?? ''),
                color: AppTheme.black,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.big),
              ),
              TextLabel(
                text:
                    'REF : ${widget.verifyAccountEntity?.otpRefNumber != null ? widget.verifyAccountEntity?.otpRefNumber : ''}',
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
                      border: Border.all(color: AppTheme.lightBlue),
                    ),
                  ),
                  separatorBuilder: (index) => const SizedBox(width: 10),
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
                    text: translate(
                      'input_form.otp.resend_otp',
                    ),
                    color: AppTheme.gray9CA3AF,
                  ),
                  TextButton(
                    onPressed: () {
                      if (timerOff) {
                        resetTimer();
                      }
                    },
                    child: TextLabel(
                      text: translate('input_form.otp.resend').toUpperCase(),
                      color:
                          timerOff ? AppTheme.lightBlue : AppTheme.gray9CA3AF,
                      fontWeight: FontWeight.bold,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.big),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // _onCompleted(BuildContext context) {
  //   final AlertDialog dialog = AlertDialog(
  //     title: TextLabel(
  //       text: translate('input_form.otp.complete_title'),
  //       fontWeight: FontWeight.bold,
  //       fontSize: 20,
  //     ),
  //     content: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         const Icon(
  //           Icons.check_circle_rounded,
  //           color: Colors.greenAccent,
  //           size: 64,
  //         ),
  //         const SizedBox(height: 20),
  //         TextLabel(text: translate('input_form.otp.complete_message'))
  //       ],
  //     ),
  //     actions: [
  //       Button(
  //         onPressed: () {
  //           final navigator = Navigator.of(context);
  //           if (navigator.canPop()) {
  //             navigator.pop();
  //           }
  //           navigator.pushReplacementNamed(RouteNames.home);
  //         },
  //         text: translate('button.Ok'),
  //       ),
  //     ],
  //   );

  //   showDialog<void>(context: context, builder: (context) => dialog);
  // }
}
