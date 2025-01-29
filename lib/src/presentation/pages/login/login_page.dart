import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/config/api/api_firebase.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter/src/presentation/pages/login/widget/button_change_language.dart';
import 'package:jupiter/src/presentation/widgets/unfocus_area.dart';
import 'package:jupiter/src/root_app.dart';
import 'package:jupiter/src/widget_key.dart';
import 'package:jupiter_api/data/data_models/request/signin_account_form.dart';
import 'package:jupiter_api/data/dio_config/dio_util.dart';
import 'package:jupiter_api/domain/entities/sign_in_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/login/cubit/login_cubit.dart';
import 'package:jupiter/src/presentation/pages/login/widget/email_input.dart';
import 'package:jupiter/src/presentation/widgets/button_close_keyboard.dart';
import 'package:jupiter/src/presentation/widgets/loading_page.dart';
import 'package:jupiter/src/utilities.dart';
import '../../../firebase_log.dart';
import '../../../injection.dart';
import '../../../route_names.dart';
import '../../widgets/button.dart';
import 'widget/do_not_have_account_register.dart';
import 'widget/forgot_password.dart';
import 'widget/password_input.dart';

class LoginPageWrapperProvider extends StatelessWidget {
  const LoginPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordError = false;
  bool isShowPopup = false;
  bool isUsernameError = false;
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  bool language = false;
  bool loginLoading = false;
  final passwordTextEditor = TextEditingController();
  late SignInAccountForm signInAccountForm;
  SignInEntity? signInEntity;
  String token = '';
  final usernameTextEditer = TextEditingController();

  @override
  void initState() {
    FirebaseLog.logPage(this);
    super.initState();
    setDioConfig();
    initLanguageSetting();
    BlocProvider.of<LoginCubit>(context).resetState();
  }

  Future<void> setDioConfig({bool? isLogin, String? username}) async {
    String appVersion =
        '${FirebaseLog.appVersionName} (${FirebaseLog.appVersionCode})';
    String platform = FirebaseLog.getDevicePlatform();
    String model = await FirebaseLog.getDeviceModel();
    String osVersion = await FirebaseLog.getDeviceOSVersion();
    DioUtil.configDefaultParam(
      username: isLogin == true ? username ?? 'N/A' : 'N/A',
      orgCode: ConstValue.orgCode,
      deviceCode: jupiterPrefsAndAppData.deviceId,
      platform: platform,
      model: model,
      osVersion: osVersion,
      appVersion: appVersion,
    );
  }

  void initLanguageSetting() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        language = jupiterPrefsAndAppData.language ?? false;
      });
    });
  }

  Future<void> getTokenNotification() async {
    String getToken = await ApiFirebase().getTokenNotification();
    debugPrint('TOKEN LOGIN : ${getToken}');
    setState(() {
      token = getToken;
    });
  }

  void onPressedLogin() async {
    if (kDebugMode) {
      if (token != '') {
        await signIn();
      } else {
        await getTokenNotification();
        await signIn();
      }
    } else {
      bool canSignIn = true;
      setState(() {
        isUsernameError = false;
        isPasswordError = false;
      });
      if (usernameTextEditer.text == '') {
        canSignIn = false;
        setState(() {
          isUsernameError = true;
        });
      }
      if (passwordTextEditor.text == '') {
        canSignIn = false;
        setState(() {
          isPasswordError = true;
        });
      }
      if (canSignIn) {
        if (token != '') {
          await signIn();
        } else {
          await getTokenNotification();
          await signIn();
        }
      }
    }
  }

  void onChangedUsername(String? value) {
    if (isUsernameError) {
      setState(() {
        isUsernameError = false;
      });
    }
  }

  void onChangedPassword(String? value) {
    if (isPasswordError) {
      setState(() {
        isPasswordError = false;
      });
    }
  }

  void onChangeLanguage() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        loginLoading = true;
      });
    });
    language = await jupiterPrefsAndAppData.language ?? false;
    bool newLang = !language;
    jupiterPrefsAndAppData.saveSettingLanguage(newLang);
    RootApp.setLocale(newLang);
    Future.delayed(const Duration(milliseconds: 300), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          loginLoading = false;
          language = newLang;
        });
      });
    });
  }

  Future<void> signIn() async {
    language = jupiterPrefsAndAppData.language ?? false;
    jupiterPrefsAndAppData.setCheckFirstLogin(true);
    if (kDebugMode) {
      signInAccountForm = SignInAccountForm(
          // username: 'niwat.r@pttdigital.com',
          // password: 'P@ssw0rd',
          // username: 'tletawan6@gmail.com',
          // password: 'P@ssw0rd',
          username: 'surasit.suwannara@gmail.com',
          password: '11111111',
          // username: 'k.krittaya.paenklom@gmail.com',
          // password: 'P@ssw0rd',
          deviceCode: jupiterPrefsAndAppData.deviceId ?? '',
          notificationToken: token,
          language: language ? 'EN' : 'TH',
          orgCode: ConstValue.orgCode);
      BlocProvider.of<LoginCubit>(context).signIn(signInAccountForm);
    } else {
      signInAccountForm = SignInAccountForm(
          username: usernameTextEditer.text.toLowerCase().trim(),
          password: passwordTextEditor.text.trim(),
          deviceCode: jupiterPrefsAndAppData.deviceId ?? '',
          notificationToken: token,
          language: language ? 'EN' : 'TH',
          orgCode: ConstValue.orgCode);
      BlocProvider.of<LoginCubit>(context).signIn(signInAccountForm);
    }
  }

  void actionLoginLoading() {
    loginLoading = true;
  }

  void actionLoginSuccess(state) {
    debugPrint(state.signInEntity?.message ?? '');
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (loginLoading) {
        jupiterPrefsAndAppData = getIt();
        await setDioConfig(
          isLogin: true,
          username: jupiterPrefsAndAppData.username,
        );
        loginLoading = false;
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setBool(ConstValue.checkFirstLogin, true);
        Navigator.pushReplacementNamed(context, RouteNames.create_pincode);
      }
    });
  }

  void actionLoginFailure(state) {
    loginLoading = false;
    debugPrint(state.message ?? '');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<LoginCubit>(context).resetState();
      if (!isShowPopup) {
        isShowPopup = true;
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.DEFAULT,
          isForce: true,
          title: translate('alert.title.default'),
          description:
              state.message ?? translate('alert.description.error_login'),
          textButton: translate('button.try_again'),
          onPressButton: () {
            isShowPopup = false;
            Navigator.of(context).pop();
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeMedia = MediaQuery.of(context).size;
    return UnfocusArea(
      child: Scaffold(
        backgroundColor: AppTheme.white,
        body: BlocBuilder<LoginCubit, LoginState>(
          builder: (contextBlocBuilder, state) {
            switch (state.runtimeType) {
              case LoginLoading:
                actionLoginLoading();
                break;
              case LoginSuccess:
                actionLoginSuccess(state);
                break;
              case LoginFailure:
                actionLoginFailure(state);
                break;
            }
            return Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              child: Image.asset(
                                ImageAsset.bg_login_page,
                                width: sizeMedia.width,
                                fit: BoxFit.values.first,
                              ),
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.only(top: 100),
                              child: SvgPicture.asset(
                                ImageAsset.logo_jupiter,
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: [
                                SizedBox(height: 40),
                                EmailInput(
                                  key: WidgetKey.LOGIN_TF_USERNAME,
                                  usernameTextEditer: usernameTextEditer,
                                  onChanged: onChangedUsername,
                                  isError: isUsernameError,
                                ),
                                SizedBox(height: 20),
                                PasswordInput(
                                  key: WidgetKey.LOGIN_TF_PASSWORD,
                                  passwordTextEditor: passwordTextEditor,
                                  onChanged: onChangedPassword,
                                  isError: isPasswordError,
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: sizeMedia.width,
                                  child: Button(
                                    key: WidgetKey.LOGIN_BT_LOGIN,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppTheme.blueD,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                      ),
                                      elevation: 0,
                                    ),
                                    text: translate('button.login'),
                                    onPressed: onPressedLogin,
                                    textColor: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                //* Forgot password and resend verify email *//
                                ForgotPassword(),
                                SizedBox(height: sizeMedia.height * .075),
                                DonotHaveAccountRegister(sizeMedia: sizeMedia),
                                ButtonChangeLanguage(
                                  onPressedButton: onChangeLanguage,
                                  language: language,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom >
                                            0
                                        ? 40
                                        : 0),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                LoadingPage(visible: loginLoading),
                ButtonCloseKeyboard(contextPage: context)
              ],
            );
          },
        ),
      ),
    );
  }
}
