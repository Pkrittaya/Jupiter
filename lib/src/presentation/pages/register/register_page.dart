import 'package:flutter/material.dart' hide StepperType, Step, StepState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/config/api/api_firebase.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/unfocus_area.dart';
import 'package:jupiter_api/data/data_models/request/signup_account_form.dart';
import 'package:jupiter_api/data/data_models/request/verify_account_form.dart';
import 'package:jupiter_api/domain/entities/car_master_entity.dart';
import 'package:jupiter_api/domain/entities/sign_up_entity.dart';
import 'package:jupiter/src/presentation/pages/create_pincode/create_pincode_page.dart';
import 'package:jupiter/src/presentation/pages/main_menu/main_menu_page.dart';
import 'package:jupiter/src/presentation/pages/register/cubit/register_cubit.dart';
import 'package:jupiter/src/presentation/widgets/button.dart';
import 'package:jupiter/src/presentation/widgets/button_close_keyboard.dart';
import 'package:jupiter/src/presentation/widgets/custom_stepper.dart';
import 'package:jupiter/src/presentation/widgets/loading_page.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/domain/entities/verify_account_entity.dart';
import '../../../firebase_log.dart';
import '../../../injection.dart';
import '../../../route_names.dart';
import 'steps/otp_step.dart';
import 'steps/register_form_step.dart';
import 'steps/term_step.dart';

class RegisterPageWrapperProvider extends StatelessWidget {
  const RegisterPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterCubit>(),
      child: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int currentStep = 0;
  bool isVerifyAccount = false;
  bool isVerifyOtp = false;
  VerifyAccountForm? verifyAccountForm;
  VerifyAccountEntity? verifyAccountEntity;
  SignupAccountForm? signupAccountForm;
  bool isTermAndConditionCheck = false;
  bool timerOn = false;
  SignUpEntity? signUpEntity;
  List<CarMasterEntity> listCarFromService = List.empty(growable: true);
  double heightAppbar = AppBar().preferredSize.height;

  // PADDING
  double paddingHorizontal = 40;
  double paddingVerticalButton = 12;

  // STEP 1
  ScrollController scrollController = ScrollController();
  bool isActiveAccept = false;

  // STEP 2
  final formKey = GlobalKey<FormState>();
  final emailField = TextEditingController();
  final passwordField = TextEditingController();
  final confirmPasswordField = TextEditingController();
  final firstnameField = TextEditingController();
  final lastnameField = TextEditingController();
  final genderField = TextEditingController();
  final mobileField = TextEditingController();
  final birthdayField = TextEditingController();
  // bool isErrorEmail = false;
  // bool isErrorPassword = false;
  // bool isErrorConfirmPassword = false;
  // bool isErrorFirstname = false;
  // bool isErrorLastname = false;
  // bool isErrorMobile = false;
  String statusPassword = 'DEFAULT';
  String statusConfirmPassword = 'DEFAULT';
  List<String> idField = [
    'EMAIL',
    'PASSWORD',
    'CONFIRM_PASSWORD',
    'FIRSTNAME',
    'LASTNAME',
    'MOBILE',
  ];
  bool enableRegister = false;

  // STEP 3
  // TextEditingController licensePlateController = TextEditingController();
  // TextEditingController provinceController = TextEditingController();
  // TextEditingController brandTxEditController = TextEditingController();
  // TextEditingController modelTxEditController = TextEditingController();

  // TOKEN
  String token = '';
  bool loadingPage = false;

  @override
  void initState() {
    FirebaseLog.logPage(this);
    super.initState();
    currentStep = 0;
    isVerifyAccount = false;
    isVerifyOtp = false;
    verifyAccountForm = null;
    verifyAccountEntity = null;
    isTermAndConditionCheck = false;
    timerOn = false;
    signUpEntity = null;
    BlocProvider.of<RegisterCubit>(context).getTermAndCondition();
  }

  Future<void> getTokenNotification() async {
    String getToken = await ApiFirebase().getTokenNotification();
    debugPrint('TOKEN LOGIN : ${getToken}');
    setState(() {
      token = getToken;
    });
  }

  void scrollControllerListen() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      setState(() {
        isActiveAccept = true;
      });
    }
  }

  // void onSubmitAddCar() async {
  //   try {
  //     BlocProvider.of<RegisterCubit>(context).fetchAddCar(
  //       vehicleNo: getVehicleID(
  //           brand: brandTxEditController.text,
  //           model: modelTxEditController.text),
  //       licensePlate: licensePlateController.text,
  //       province: provinceController.text,
  //       defalut: true,
  //     );
  //   } catch (e) {
  //     if (loadingPage) {
  //       setState(() {
  //         loadingPage = false;
  //       });
  //     }
  //     BlocProvider.of<RegisterCubit>(context).resetStatetoInital();
  //     Utilities.alertOneButtonAction(
  //       context: context,
  //       type: AppAlertType.DEFAULT,
  //       isForce: true,
  //       title: translate('alert.title.default'),
  //       description: translate('alert.description.default'),
  //       textButton: translate('button.try_again'),
  //       onPressButton: () {
  //         Navigator.of(context).pop();
  //       },
  //     );
  //   }
  // }

  // int getVehicleID({required String brand, required String model}) {
  //   if (listCarFromService.length > 0) {
  //     for (int i = 0; i < listCarFromService.length; i++) {
  //       for (int j = 0; j < listCarFromService[i].model.length; j++) {
  //         if (brandTxEditController.text == listCarFromService[i].brand &&
  //             modelTxEditController.text ==
  //                 listCarFromService[i].model[j].name) {
  //           debugPrint(
  //               'NAME : ${listCarFromService[i].brand} ${listCarFromService[i].model[j].name}');
  //           debugPrint('ID : ${listCarFromService[i].model[j].vehicleNo}');
  //           return listCarFromService[i].model[j].vehicleNo ?? -1;
  //         }
  //       }
  //     }
  //   }
  //   return -1;
  // }

  DateTime parseDateStringToDateTime(String value) {
    // String dateString = '14/06/2023';
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateTime dateTime = dateFormat.parse(value);
    return dateTime;
  }

  void _onSubmitForm() {
    if (enableRegister) {
      FocusScope.of(context).unfocus();
      BlocProvider.of<RegisterCubit>(context).sendVerifyAccount(
        username: emailField.text.trim(),
        password: passwordField.text.trim(),
        firstname: firstnameField.text.trim(),
        lastname: lastnameField.text.trim(),
        mobile: mobileField.text.trim().replaceAll('-', ''),
        gender: genderField.text.trim(),
        birthdate: parseDateStringToDateTime(birthdayField.text.trim()),
      );
    }
  }

  bool validateEmail(String email) {
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    return emailRegex.hasMatch(email.trim());
  }

  bool validatePatternPassword(String input) {
    RegExp pattern = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@.])[a-zA-Z0-9!@.]+$');
    if (pattern.hasMatch(input.trim()) && input.trim().length >= 8) {
      return true;
    } else {
      return false;
    }
  }

  bool validateMobile(String mobile) {
    if (mobile.length == 10) {
      return true;
    } else {
      return false;
    }
  }

  void onChangedTextField(String? value, String id) {
    if (id == idField[1]) {
      // PASSWORD
      if (validatePatternPassword(passwordField.text.trim())) {
        setState(() {
          statusPassword = 'PASSWORD_CORRECT';
        });
      } else if (passwordField.text.trim() == '') {
        setState(() {
          statusPassword = 'DEFAULT';
        });
      } else {
        setState(() {
          statusPassword = 'PASSWORD_INCORRECT';
        });
      }
    }
    if (id == idField[1] || id == idField[2]) {
      if (validatePatternPassword(confirmPasswordField.text.trim()) &&
          confirmPasswordField.text.trim() == passwordField.text.trim()) {
        setState(() {
          statusConfirmPassword = 'CONFIRM_PASSWORD_CORRECT';
        });
      } else if (confirmPasswordField.text.trim() == '') {
        setState(() {
          statusConfirmPassword = 'DEFAULT';
        });
      } else {
        setState(() {
          statusConfirmPassword = 'CONFIRM_PASSWORD_INCORRECT';
        });
      }
    }
    if (validateEmail(emailField.text.trim()) &&
        confirmPasswordField.text.trim() == passwordField.text.trim() &&
        validatePatternPassword(confirmPasswordField.text.trim()) &&
        validatePatternPassword(passwordField.text.trim()) &&
        validateMobile(mobileField.text.trim().replaceAll('-', '')) &&
        firstnameField.text.trim() != '' &&
        lastnameField.text.trim() != '' &&
        mobileField.text.trim() != '') {
      setState(() {
        enableRegister = true;
      });
    } else {
      setState(() {
        enableRegister = false;
      });
    }
  }

  void onStepCancel() {
    if (isVerifyAccount && !isVerifyOtp) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        BlocProvider.of<RegisterCubit>(context).resetStatetoInital();
        Utilities.alertTwoButtonAction(
          context: context,
          type: AppAlertType.WARNING,
          title: translate('alert.title.warning'),
          description: translate('alert.description.unsubscribe'),
          textButtonLeft: translate('button.cancel'),
          onPressButtonLeft: () {
            Navigator.of(context).pop();
          },
          textButtonRight: translate('button.confirm'),
          onPressButtonRight: () {
            while (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
          },
        );
      });
    } else if (isVerifyAccount && isVerifyOtp) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        BlocProvider.of<RegisterCubit>(context).resetStatetoInital();
        Utilities.alertTwoButtonAction(
          context: context,
          type: AppAlertType.WARNING,
          title: translate('alert.title.warning'),
          description: translate('alert.description.add_vehicle_later'),
          textButtonLeft: translate('button.cancel'),
          onPressButtonLeft: () {
            Navigator.of(context).pop();
          },
          textButtonRight: translate('button.confirm'),
          onPressButtonRight: () {
            while (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
            // Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) {
            //   return MainMenuPage(
            //     checkStatusEntity: CheckStatusEntity(
            //       chargingStatus: false,
            //       data: null,
            //       informationCharger: null,
            //     ),
            //   );
            // }));
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return MainMenuPage();
            }));
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CreatePinCodePage();
            }));
          },
        );
      });
    } else {
      if (currentStep != 2) {
        if (currentStep == 0) {
          Navigator.of(context).pop();
          return;
        }
        if (currentStep > 0) {
          setState(() {
            currentStep = currentStep -= 1;
          });
          if (currentStep == 0) {
            BlocProvider.of<RegisterCubit>(context).getTermAndCondition();
          }
        }
      }
    }
  }

  void onStepTapped(int index) {
    // if (isVerifyOtp) {
    //   return;
    // }
    // if (isVerifyAccount || index < 2) {
    //   setState(() => currentStep = index);
    // }
  }

  void onStepContinue() {
    if (currentStep == 0) {
      BlocProvider.of<RegisterCubit>(context).registerFormReady();
    }
    if (currentStep < 1) {
      setState(() => currentStep += 1);
    }
    debugPrint('onStepContinue After $currentStep');
    if (currentStep == 3) {
      final navigator = Navigator.of(context);
      if (navigator.canPop()) {
        navigator.pop();
      }
      navigator.pushReplacementNamed(RouteNames.home);
    }
  }

  // bool checkIsLoading(runtime) {
  //   if (runtime == RegisterLoading ||
  //       runtime == GetCarMasterLoading ||
  //       runtime == AddCarMasterLoading) {
  //     return true;
  //   }
  //   return false;
  // }

  // void clearBrand() {
  //   modelTxEditController.text = '';
  //   brandTxEditController.text = '';
  //   setState(() {});
  // }

  // void clearModel() {
  //   modelTxEditController.text = '';
  //   setState(() {});
  // }

  void actionRegisterLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingPage) {
        setState(() {
          loadingPage = true;
        });
      }
    });
  }

  void actionTermAndConditionAccepted() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        currentStep = 1;
        setState(() {
          loadingPage = false;
        });
      }
    });
  }

  void actionTermAndConditionSuccess() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        currentStep = 0;
        setState(() {
          loadingPage = false;
        });
      }
    });
  }

  void actionTermAndConditionFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
        });
        BlocProvider.of<RegisterCubit>(context).resetStatetoInital();
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
  }

  void actionVerifyAccountSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        verifyAccountForm = state.verifyAccountForm;
        verifyAccountEntity = state.verifyAccountEntity;
        currentStep = 2;
        isVerifyAccount = true;
        timerOn = true;
        setState(() {
          loadingPage = false;
        });
      }
    });
  }

  void actionVerifyAccountFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
        });
        BlocProvider.of<RegisterCubit>(context).resetStatetoInital();
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
  }

  Future<void> actionSignUpSuccess(state) async {
    // DEFALUT
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        isVerifyOtp = true;
        signUpEntity = state.signUpEntity;
        setState(() {
          loadingPage = false;
        });
        BlocProvider.of<RegisterCubit>(context).resetStatetoInital();
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.SUCCESS,
          isForce: true,
          title: translate('alert.title.success'),
          description: translate('alert.description.register_success'),
          textButton: translate('button.step_next'),
          onPressButton: () async {
            while (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
          },
        );
      }
    });
  }

  Future<void> actionSignUpFailure(state) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
        });
        BlocProvider.of<RegisterCubit>(context).resetStatetoInital();
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
  }

  // void actionLoginLoading() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (!loadingPage) {
  //       setState(() {
  //         loadingPage = true;
  //       });
  //     }
  //   });
  // }

  // void actionLoginFailure(state) {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (loadingPage) {
  //       setState(() {
  //         loadingPage = false;
  //       });
  //       BlocProvider.of<RegisterCubit>(context).resetStatetoInital();
  //       Utilities.alertTwoButtonAction(
  //         context: context,
  //         type: AppAlertType.WARNING,
  //         title: translate('alert.title.default'),
  //         description: translate('alert.description.check_login_failure'),
  //         textButtonLeft: translate('button.cancel'),
  //         onPressButtonLeft: () {
  //           while (Navigator.canPop(context)) {
  //             Navigator.of(context).pop();
  //           }
  //         },
  //         textButtonRight: translate('button.try_again'),
  //         onPressButtonRight: () async {
  //           Navigator.of(context).pop();
  //           SignInAccountForm signInAccountForm = SignInAccountForm(
  //             username: verifyAccountForm?.username ?? '',
  //             password: verifyAccountForm?.password ?? '',
  //             deviceCode: await Utilities.getDeviceId() ?? '',
  //             notificationToken: token,
  //           );
  //           BlocProvider.of<RegisterCubit>(context)
  //               .fetchLogin(signInAccountForm);
  //         },
  //       );
  //     }
  //   });
  // }

  // void actionLoginSuccess() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (loadingPage) {
  //       currentStep = 3;
  //       setState(() {
  //         loadingPage = false;
  //       });
  //       BlocProvider.of<RegisterCubit>(context).fetchLoadCarMaster();
  //     }
  //   });
  // }

  // void actionGetCarMasterLoading() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (!loadingPage) {
  //       setState(() {
  //         loadingPage = true;
  //       });
  //     }
  //   });
  // }

  // void actionGetCarMasterFailure(state) {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (loadingPage) {
  //       setState(() {
  //         loadingPage = false;
  //       });
  //       BlocProvider.of<RegisterCubit>(context).resetStatetoInital();
  //       Utilities.alertTwoButtonAction(
  //         context: context,
  //         type: AppAlertType.WARNING,
  //         title: translate('alert.title.default'),
  //         description: state.message ?? translate('alert.description.default'),
  //         textButtonLeft: translate('button.close'),
  //         onPressButtonLeft: () {
  //           Navigator.of(context).pop();
  //         },
  //         textButtonRight: translate('button.try_again'),
  //         onPressButtonRight: () {
  //           Navigator.of(context).pop();
  //           BlocProvider.of<RegisterCubit>(context).fetchLoadCarMaster();
  //         },
  //       );
  //     }
  //   });
  // }

  // void actionGetCarMasterSuccess(state) {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (loadingPage) {
  //       setState(() {
  //         loadingPage = false;
  //         listCarFromService =
  //             state.listCarFromService ?? List.empty(growable: true);
  //       });
  //     }
  //   });
  //   BlocProvider.of<RegisterCubit>(context).resetStatetoInital();
  // }

  // void actionAddCarMasterLoading() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (!loadingPage) {
  //       setState(() {
  //         loadingPage = true;
  //       });
  //     }
  //   });
  // }

  // void actionAddCarMasterFailure(state) {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (loadingPage) {
  //       setState(() {
  //         loadingPage = false;
  //       });
  //       BlocProvider.of<RegisterCubit>(context).resetStatetoInital();
  //       Utilities.alertOneButtonAction(
  //         context: context,
  //         type: AppAlertType.DEFAULT,
  //         isForce: true,
  //         title: translate('alert.title.default'),
  //         description: state.message ?? translate('alert.description.default'),
  //         textButton: translate('button.try_again'),
  //         onPressButton: () {
  //           Navigator.of(context).pop();
  //         },
  //       );
  //     }
  //   });
  // }

  // void actionAddCarMasterSuccess() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (loadingPage) {
  //       setState(() {
  //         loadingPage = false;
  //       });
  //       BlocProvider.of<RegisterCubit>(context).resetStatetoInital();
  //       Utilities.alertOneButtonAction(
  //         context: context,
  //         type: AppAlertType.SUCCESS,
  //         isForce: true,
  //         title: translate('alert.title.success'),
  //         description: translate('register_page.add_vehicle.success'),
  //         textButton: translate('button.step_continue'),
  //         onPressButton: () {
  //           while (Navigator.canPop(context)) {
  //             Navigator.of(context).pop();
  //           }
  //           Navigator.pushReplacement(context,
  //               MaterialPageRoute(builder: (context) {
  //             return MainMenuPage(
  //               checkStatusEntity: CheckStatusEntity(
  //                 chargingStatus: false,
  //                 data: null,
  //                 informationCharger: null,
  //               ),
  //             );
  //           }));
  //           Navigator.push(context, MaterialPageRoute(builder: (context) {
  //             return CreatePinCodePage();
  //           }));
  //         },
  //       );
  //     }
  //   });
  // }

  void actionResetInitial() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool value) {
        debugPrint('PopScope : ${value}');
        if (!value) {
          onStepCancel();
        }
      },
      child: UnfocusArea(
        child: BlocBuilder<RegisterCubit, RegisterState>(
          builder: (BuildContext context, state) {
            switch (state.runtimeType) {
              case RegisterLoading:
                actionRegisterLoading();
                break;
              case TermAndConditionAccepted:
                actionTermAndConditionAccepted();
                break;
              case TermAndConditionSuccess:
                actionTermAndConditionSuccess();
                break;
              case TermAndConditionFailure:
                actionTermAndConditionFailure(state);
                break;
              case VerifyAccountSuccess:
                actionVerifyAccountSuccess(state);
                break;
              case VerifyAccountFailure:
                actionVerifyAccountFailure(state);
                break;
              case SignUpSuccess:
                actionSignUpSuccess(state);
                break;
              case SignUpFailure:
                actionSignUpFailure(state);
                break;
              default:
                actionResetInitial();
                break;
            }
            return renderStepPage(state);
          },
        ),
      ),
    );
  }

  Widget renderStepPage(state) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.white,
            bottomOpacity: 0.0,
            elevation: 0.0,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppTheme.blueDark),
                onPressed: onStepCancel),
            centerTitle: true,
            title: TextLabel(
              text: '',
              color: AppTheme.blueDark,
              fontSize: Utilities.sizeFontWithDesityForDisplay(context, 32),
              fontWeight: FontWeight.w700,
            ),
          ),
          body: Stack(
            children: [
              Container(
                color: AppTheme.white,
                height: MediaQuery.of(context).size.height - heightAppbar,
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowIndicator();
                    return true;
                  },
                  child: CustomStepper(
                    physics: currentStep == 0
                        ? NeverScrollableScrollPhysics()
                        : BouncingScrollPhysics(),
                    allwidth: MediaQuery.of(context).size.width * 1.1,
                    currentStep: currentStep,
                    type: StepperType.horizontal,
                    onStepCancel: onStepCancel,
                    onStepContinue: onStepContinue,
                    onStepTapped: onStepTapped,
                    controlsBuilder: (context, details) {
                      return SizedBox();
                    },
                    steps: <Step>[
                      renderStepOne(state),
                      renderStepTwo(),
                      renderStepThree(),
                      // renderStepFour(),
                    ],
                  ),
                ),
              ),
              renderButtonStepOne(),
              renderButtonStepTwo(),
              renderButtonStepThree(),
              // renderButtonStepFour(),
            ],
          ),
        ),
        LoadingPage(visible: loadingPage)
      ],
    );
  }

  Step renderStepOne(state) {
    return new Step(
      title: const Text(''),
      label: TextLabel(
          text: translate('register_page.step.one'),
          fontSize:
              Utilities.sizeFontWithDesityForDisplay(context, AppFontSize.big)),
      isActive: currentStep >= 0,
      content: TermStep(
          termAndConditionEntity: state.termAndConditionEntity,
          scrollController: scrollController,
          isActiveAccept: isActiveAccept,
          scrollControllerListen: scrollControllerListen),
    );
  }

  Step renderStepTwo() {
    return new Step(
      title: const Text(''),
      label: TextLabel(
          text: translate('register_page.step.two'),
          fontSize:
              Utilities.sizeFontWithDesityForDisplay(context, AppFontSize.big)),
      isActive: currentStep >= 1,
      content: RegisterFormStep(
        formKey: formKey,
        emailField: emailField,
        passwordField: passwordField,
        confirmPasswordField: confirmPasswordField,
        firstnameField: firstnameField,
        lastnameField: lastnameField,
        genderField: genderField,
        mobileField: mobileField,
        birthdayField: birthdayField,
        // isErrorEmail: isErrorEmail,
        // isErrorPassword: isErrorPassword,
        // isErrorConfirmPassword: isErrorConfirmPassword,
        // isErrorFirstname: isErrorFirstname,
        // isErrorLastname: isErrorLastname,
        // isErrorMobile: isErrorMobile,
        statusPassword: statusPassword,
        statusConfirmPassword: statusConfirmPassword,
        isOpenKeyboard: MediaQuery.of(context).viewInsets.bottom > 0,
        onChanged: onChangedTextField,
      ),
    );
  }

  Step renderStepThree() {
    return new Step(
      title: const Text(''),
      label: TextLabel(
          text: translate('register_page.step.three'),
          fontSize:
              Utilities.sizeFontWithDesityForDisplay(context, AppFontSize.big)),
      isActive: currentStep >= 2,
      content: OtpStep(
        verifyAccountEntity: verifyAccountEntity,
        verifyAccountForm: verifyAccountForm,
        onContinueStep: onStepContinue,
        onResendOtp: _onSubmitForm,
        onCancelStep: onStepCancel,
        timerOn: timerOn,
      ),
    );
  }

  // Step renderStepFour() {
  //   return new Step(
  //     title: const Text(''),
  //     label: Text(translate('register_page.step.four')),
  //     isActive: currentStep >= 3,
  //     content: VerifySuccessAndAddVehicle(
  //       isOpenKeyboard: MediaQuery.of(context).viewInsets.bottom > 0,
  //       listCarFromService: listCarFromService,
  //       licensePlateController: licensePlateController,
  //       provinceController: provinceController,
  //       brandTxEditController: brandTxEditController,
  //       modelTxEditController: modelTxEditController,
  //       clearBrand: clearBrand,
  //       clearModel: clearModel,
  //     ),
  //   );
  // }

  Widget renderButtonStepOne() {
    return Visibility(
      visible: currentStep == 0,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: AppTheme.white,
          height: MediaQuery.of(context).size.height * 0.18,
          padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(vertical: paddingVerticalButton),
                    elevation: 0.0,
                    shadowColor: Colors.transparent,
                    backgroundColor:
                        isActiveAccept ? AppTheme.blueD : AppTheme.gray9CA3AF,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(200)),
                    ),
                  ),
                  onPressed: isActiveAccept ? onStepContinue : null,
                  child: Text(
                    translate('button.step_accept'),
                    style: TextStyle(
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.large),
                        fontWeight: FontWeight.bold,
                        color: AppTheme.white),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(vertical: paddingVerticalButton),
                    elevation: 0.0,
                    shadowColor: Colors.transparent,
                    backgroundColor: AppTheme.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(200)),
                    ),
                  ),
                  onPressed: onStepCancel,
                  child: Text(
                    translate('button.step_decline'),
                    style: TextStyle(
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                        context,
                        AppFontSize.large,
                      ),
                      color: AppTheme.gray9CA3AF,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderButtonStepTwo() {
    return Visibility(
      visible: currentStep == 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: AppTheme.white,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.11,
              padding: EdgeInsets.symmetric(
                  horizontal: paddingHorizontal, vertical: 20),
              child: Button(
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  shadowColor: Colors.transparent,
                  backgroundColor:
                      enableRegister ? AppTheme.blueD : AppTheme.gray9CA3AF,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(200)),
                  ),
                ),
                text: translate("button.register"),
                onPressed: _onSubmitForm,
                textColor: Colors.white,
              ),
            ),
          ),
          ButtonCloseKeyboard(contextPage: context)
        ],
      ),
    );
  }

  Widget renderButtonStepThree() {
    return Visibility(
      visible: currentStep == 2,
      child: ButtonCloseKeyboard(contextPage: context),
    );
  }

  // Widget renderButtonStepFour() {
  //   return Visibility(
  //     visible: currentStep == 3,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: [
  //         Align(
  //           alignment: Alignment.bottomCenter,
  //           child: Container(
  //             color: AppTheme.white,
  //             width: double.infinity,
  //             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
  //             child: Button(
  //               style: ElevatedButton.styleFrom(
  //                 elevation: 0.0,
  //                 shadowColor: Colors.transparent,
  //                 backgroundColor: AppTheme.blueD,
  //                 shape: const RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.all(Radius.circular(200)),
  //                 ),
  //               ),
  //               text: translate('button.ok2'),
  //               onPressed: onSubmitAddCar,
  //               textColor: Colors.white,
  //             ),
  //           ),
  //         ),
  //         ButtonCloseKeyboard(contextPage: context)
  //       ],
  //     ),
  //   );
  // }
}
