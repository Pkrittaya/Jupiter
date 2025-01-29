import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/presentation/widgets/loading_page.dart';
import 'package:jupiter/src/presentation/widgets/unfocus_area.dart';
import 'package:jupiter/src/utilities.dart';
import '../../../firebase_log.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key, this.verifyemail});
  final bool? verifyemail;
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  double heightText = 1.5;
  double paddingField = 16;
  bool canSend = false;
  bool isLoading = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
    FirebaseLog.logPage(this);
    super.initState();
  }

  void onPressedBackButton() {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop();
  }

  bool validateEmail(String email) {
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    return emailRegex.hasMatch(email);
  }

  void onChangedTextField(String? value) {
    if (validateEmail(emailController.text.trim()) &&
        value != '' &&
        value != null) {
      setState(() {
        canSend = true;
      });
    } else {
      setState(() {
        canSend = false;
      });
    }
  }

  void onSubmitPassword() {
    FocusScope.of(context).unfocus();
    if (canSend) {
      BlocProvider.of<ForgotPasswordCubit>(context)
          .fetchSendEmailToResetPassword(emailController.text.trim());
    }
  }

  void onSubmitVerifyEmail() {
    FocusScope.of(context).unfocus();
    if (canSend) {
      debugPrint(' SendEmail for verify ');
      BlocProvider.of<ForgotPasswordCubit>(context)
          .fetchSendEmailToVerify(emailController.text.trim());
    }
  }

  void actionForgotPasswordSendEmailLoading() {
    if (!isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          isLoading = true;
        });
      });
    }
  }

  void actionForgotPasswordSendEmailFailure(state) {
    if (isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
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
      });
    }
  }

  void actionForgotPasswordSendEmailSuccess() {
    if (isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          isLoading = false;
        });
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.SUCCESS,
          isForce: true,
          title: translate('alert.title.success'),
          description: translate('alert.description.send_forgot_password'),
          textButton: translate('button.done'),
          onPressButton: () {
            while (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
          },
        );
      });
    }
  }

  void actionVerifySendEmailFailure(state) {
    if (isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
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
      });
    }
  }

  void actionVerifySendEmailSuccess() {
    if (isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          isLoading = false;
        });
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.SUCCESS,
          isForce: true,
          title: translate('alert.title.success'),
          description: translate('alert.description.verify_email'),
          textButton: translate('button.step_next'),
          onPressButton: () {
            while (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
          },
        );
      });
    }
  }

  bool isKeyboardOpen() {
    return FocusScope.of(context).hasFocus;
  }

  @override
  Widget build(BuildContext context) {
    return UnfocusArea(
      child: Stack(
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
                text: '',
                color: AppTheme.blueDark,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.title),
                fontWeight: FontWeight.w700,
              ),
            ),
            body: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
              builder: (context, state) {
                switch (state.runtimeType) {
                  case ForgotPasswordSendEmailLoading:
                    actionForgotPasswordSendEmailLoading();
                    break;
                  case ForgotPasswordSendEmailFailure:
                    actionForgotPasswordSendEmailFailure(state);
                    break;
                  case ForgotPasswordSendEmailSuccess:
                    actionForgotPasswordSendEmailSuccess();
                    break;
                  case VerifySendEmailFailure:
                    actionVerifySendEmailFailure(state);
                    break;
                  case VerifySendEmailSuccess:
                    actionVerifySendEmailSuccess();
                    break;
                }
                return Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      padding: const EdgeInsets.fromLTRB(48, 16, 48, 0),
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.width * 0.5,
                              child: SvgPicture.asset(
                                  ImageAsset.ic_email_forgot_password),
                            ),
                            const SizedBox(height: 32),
                            TextInputForm(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: paddingField),
                              controller: emailController,
                              style: TextStyle(
                                fontSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                        context, AppFontSize.big),
                                height: heightText,
                              ),
                              hintText: translate('input_form.login.email'),
                              hintStyle: TextStyle(
                                color: AppTheme.gray9CA3AF,
                                fontSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                        context, AppFontSize.big),
                              ),
                              onSaved: (text) {},
                              onChanged: (text) {
                                onChangedTextField(text);
                              },
                              fillColor: AppTheme.grayF1F5F9,
                              borderRadius: 200,
                              keyboardType: TextInputType.text,
                              errorStyle: TextStyle(height: 0),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              width: double.infinity,
                              child: TextLabel(
                                text: widget.verifyemail == true
                                    ? translate(
                                        'login_page.remark_verify_email')
                                    : translate(
                                        'login_page.remark_forgot_password'),
                                textAlign: TextAlign.left,
                                fontSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                        context, AppFontSize.little),
                                color: AppTheme.gray9CA3AF,
                              ),
                            ),
                            const SizedBox(height: 48),
                            Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  elevation: 0.0,
                                  shadowColor: Colors.transparent,
                                  backgroundColor: canSend
                                      ? AppTheme.blueD
                                      : AppTheme.gray9CA3AF,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(200)),
                                  ),
                                ),
                                onPressed: (widget.verifyemail ?? false)
                                    ? onSubmitVerifyEmail
                                    : onSubmitPassword,
                                child: Text(
                                  translate('button.confirm'),
                                  style: TextStyle(
                                    fontSize:
                                        Utilities.sizeFontWithDesityForDisplay(
                                      context,
                                      AppFontSize.large,
                                    ),
                                    color: AppTheme.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 48),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isKeyboardOpen(),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                  width: 0.5, color: AppTheme.black20),
                            ),
                            color: AppTheme.black5,
                          ),
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                },
                                child: TextLabel(
                                  fontSize:
                                      Utilities.sizeFontWithDesityForDisplay(
                                          context, AppFontSize.normal),
                                  color: AppTheme.blueD,
                                  text: translate('button.done'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          LoadingPage(visible: isLoading)
        ],
      ),
    );
  }
}
