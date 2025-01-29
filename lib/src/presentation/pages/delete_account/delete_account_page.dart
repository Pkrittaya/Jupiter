import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/pages/delete_account/cubit/delete_account_cubit.dart';
import 'package:jupiter/src/presentation/widgets/button_close_keyboard.dart';
import 'package:jupiter/src/presentation/widgets/text_input_form.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

import '../../../firebase_log.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteaccountPageState();
}

class _DeleteaccountPageState extends State<DeleteAccountPage> {
  TextEditingController passwordController = TextEditingController();
  // bool loadingAlert = true;
  String obscuringCharacter = '•';
  bool loadSendPassword = false;
  GlobalKey<State<StatefulWidget>> keyButtonDelete =
      GlobalKey<State<StatefulWidget>>();

  Future<void> onPressedBackButton() async {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    FirebaseLog.logPage(this);
    super.initState();
  }

  void alertConfirmDelete(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // if (loadingAlert) {
      Utilities.alertTwoButtonAction(
        context: context,
        type: AppAlertType.WARNING,
        title: translate('delete_account_page.alert_confirm.title'),
        description: translate('delete_account_page.alert_confirm.description'),
        textButtonLeft: translate("button.cancel"),
        textButtonRight: translate("button.confirm"),
        onPressButtonLeft: () {
          Navigator.of(context).pop();
        },
        onPressButtonRight: () {
          BlocProvider.of<DeleteAccountCubit>(context)
              .fetchdeleteAccount(passwordController.text);
          Navigator.of(context).pop();
        },
      );
      //   setState(() {
      //     loadingAlert = false;
      //   });
      // }
    });
  }

  void actionDeleteAccountLoading() {
    if (!loadSendPassword) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          loadSendPassword = true;
        });
      });
    }
  }

  void actionDeleteAccountFailure(state) {
    if (loadSendPassword) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          loadSendPassword = false;
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

  void actionDeleteAccountSuccess() {
    if (loadSendPassword) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          loadSendPassword = false;
        });
        Utilities.logout(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: BlocBuilder<DeleteAccountCubit, DeleteAccountState>(
              builder: (context, state) {
                switch (state.runtimeType) {
                  case DeleteAccountLoading:
                    actionDeleteAccountLoading();
                    break;
                  case DeleteAccountSuccess:
                    actionDeleteAccountSuccess();
                    break;
                  case DeleteAccountFailure:
                    actionDeleteAccountFailure(state);
                    break;
                }
                return NotificationListener<OverscrollIndicatorNotification>(
                    onNotification:
                        (OverscrollIndicatorNotification overscroll) {
                      overscroll.disallowIndicator();
                      return true;
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.2),
                          Container(
                            padding: const EdgeInsets.only(left: 8),
                            child: TextLabel(
                              text: translate(
                                  'delete_account_page.enter_password'),
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.large),
                              color: AppTheme.blueDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 50),
                          TextInputForm(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                            controller: passwordController,
                            style: TextStyle(
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.big),
                              height: 1.5,
                            ),
                            hintText: translate('delete_account_page.hintText'),
                            hintStyle: TextStyle(
                              color: AppTheme.gray9CA3AF,
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.big),
                            ),
                            onSaved: (text) {},
                            onChanged: (text) {},
                            borderRadius: 200,
                            keyboardType: TextInputType.visiblePassword,
                            obscuringCharacter: obscuringCharacter,
                            errorStyle: TextStyle(height: 0),
                            obscureText: true,
                            onTap: () {
                              Utilities.ensureVisibleOnTextInput(
                                  textfieldKey: keyButtonDelete);
                            },
                            validator: (text) {
                              if (text == null || text == '') {
                                return '';
                              } else {
                                return '';
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.only(left: 8),
                            child: TextLabel(
                              text: translate('delete_account_page.note'),
                              color: AppTheme.black60,
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.normal),
                            ),
                          ),
                          const SizedBox(height: 60),
                          Container(
                            key: keyButtonDelete,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                elevation: 0.0,
                                shadowColor: Colors.transparent,
                                backgroundColor: AppTheme.red,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(200)),
                                ),
                              ),
                              onPressed: () {
                                alertConfirmDelete(context);
                              },
                              child: Text(
                                translate('delete_account_page.confirm_delete'),
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
                          const SizedBox(height: 60),
                        ],
                      ),
                    ));
              },
            ),
          ),
          ButtonCloseKeyboard(contextPage: context),
        ],
      ),
    );
  }
}
