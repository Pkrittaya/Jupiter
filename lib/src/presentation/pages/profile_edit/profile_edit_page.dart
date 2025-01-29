import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter/src/presentation/pages/profile_edit/widgets/picker_image_for_limited.dart';
import 'package:jupiter/src/presentation/widgets/unfocus_area.dart';
import 'package:jupiter_api/data/data_models/request/profile_form.dart';
import 'package:jupiter_api/data/data_models/request/signout_account_form.dart';
import 'package:jupiter_api/domain/entities/billing_entity.dart';
import 'package:jupiter_api/domain/entities/profile_entity.dart';
import 'package:jupiter_api/domain/usecase/user_management_usecase.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/presentation/pages/profile/cubit/profile_cubit.dart';
import 'package:jupiter/src/presentation/pages/profile_add_tax_invoice/profile_add_tax_invoice_page.dart';
import 'package:jupiter/src/presentation/pages/profile_edit/cubit/profile_edit_cubit.dart';
import 'package:jupiter/src/presentation/pages/profile_edit/widgets/profile_add_tax_invoice.dart';
import 'package:jupiter/src/presentation/pages/profile_edit/widgets/profile_bottom_logout.dart';
import 'package:jupiter/src/presentation/pages/profile_edit/widgets/profile_change_image.dart';
import 'package:jupiter/src/presentation/widgets/button_close_keyboard.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../firebase_log.dart';
import 'widgets/profile_field_edit.dart';

class ProfileEditWrapperProvider extends StatelessWidget {
  const ProfileEditWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>(
          create: (BuildContext context) => getIt<ProfileCubit>(),
        ),
        BlocProvider<ProfileEditCubit>(
          create: (BuildContext context) => getIt<ProfileEditCubit>(),
        ),
      ],
      child: const ProfileEditPage(),
    );
  }
}

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});
  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  ProfileEntity? profileEntity;
  List<BillingEntity> listBilling = List.empty(growable: true);
  // FIELD CONTROLLER
  final formKey = GlobalKey<FormState>();
  bool setDefaultGender = false;
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerFirstName = TextEditingController();
  final TextEditingController controllerLastName = TextEditingController();
  final TextEditingController controllerBirthDay = TextEditingController();
  final TextEditingController controllerPhoneNumber = TextEditingController();
  final TextEditingController controllerGender = TextEditingController();
  // OTHER
  bool hasEdit = false;
  double heightBottom = 100;
  UserManagementUseCase useCase = getIt();
  String loadProfile = 'TEXTPROFILE';
  String versionApp = 'V1.0.0';
  bool isLogoutProcess = false;

  @override
  void initState() {
    FirebaseLog.logPage(this);
    initVersionApp();
    BlocProvider.of<ProfileCubit>(context).loadProfile();
    BlocProvider.of<ProfileEditCubit>(context).fetchTaxInvoice();
    super.initState();
  }

  void setInitialDropdownGender() {
    if (!setDefaultGender) {
      controllerGender.text =
          translate('input_form.register.gender_list.male.value');
      setDefaultGender = true;
    }
  }

  Future<void> initVersionApp() async {
    versionApp = await Utilities.getVersionApp();
  }

  void initValueProfile() {
    if (loadProfile == 'TEXTPROFILE') {
      controllerGender.text = profileEntity?.gender ??
          translate('input_form.register.gender_list.male.value');
      controllerUsername.text = profileEntity?.username ?? 'username';
      controllerFirstName.text = profileEntity?.name ?? 'name';
      controllerLastName.text = profileEntity?.lastname ?? 'lastname';
      controllerBirthDay.text =
          formatDateFormApi(profileEntity?.dateofbirth ?? '');
      controllerPhoneNumber.text = profileEntity?.telphonenumber != null
          ? formatPhoneNumber(profileEntity!.telphonenumber)
          : 'phone Number';
    }
    setState(() {});
  }

  String formatPhoneNumber(String text) {
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
  }

  String formatDateFormApi(String dateFromApi) {
    try {
      if (dateFromApi != '') {
        List subDate = dateFromApi.split('-');
        // DateTime date = DateTime.parse(dateFromApi);
        return subDate[2] + '/' + subDate[1] + '/' + subDate[0];
      } else {
        DateTime date = DateTime.parse(DateTime.now().toString());
        String formattedDate = DateFormat('dd/MM/yyyy').format(date);
        return formattedDate;
      }
    } catch (e) {
      DateTime date = DateTime.parse(DateTime.now().toString());
      String formattedDate = DateFormat('dd/MM/yyyy').format(date);
      return formattedDate;
    }
  }

  void onPressedBackButton() {
    Navigator.of(context).pop();
  }

  void onPressedSaveButton() {
    if (hasEdit) {
      final profileForm = ProfileForm(
        orgCode: ConstValue.orgCode,
        username: controllerUsername.text.trim(),
        name: controllerFirstName.text.trim(),
        lastname: controllerLastName.text.trim(),
        gender: controllerGender.text.trim(),
        dateofbirth: controllerBirthDay.text.trim(),
        telphonenumber: controllerPhoneNumber.text.trim().replaceAll('-', ''),
      );
      BlocProvider.of<ProfileEditCubit>(context).updateProfile(profileForm);
    }
  }

  void onPressedLogout() async {
    if (!isLogoutProcess) {
      setState(() {
        isLogoutProcess = true;
      });
      JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
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
          isLogoutProcess = false;
          Utilities.logout(context);
        },
        (data) {
          debugPrint('SignOut Success');
          isLogoutProcess = false;
          Utilities.logout(context);
        },
      );
    }
  }

  void onChangeSetHasEditTrue(String? text) {
    if (controllerFirstName.text != '' &&
        controllerLastName.text != '' &&
        controllerBirthDay.text != '' &&
        controllerGender.text != '' &&
        (controllerPhoneNumber.text != '' &&
            controllerPhoneNumber.text.length == 12)) {
      if (!hasEdit) {
        setState(() {
          hasEdit = true;
        });
      }
    } else {
      if (hasEdit) {
        setState(() {
          hasEdit = false;
        });
      }
    }
  }

  Future<void> onPressedGoToSetting() async {
    try {
      await AppSettings.openAppSettings(
        type: AppSettingsType.settings,
        asAnotherTask: true,
      );
    } catch (e) {
      debugPrint('ERROR TO OPEN APP SETTING');
    }
  }

  Future<void> showImagePickerForlimited() async {
    var pickerImageForLimited = PickerImageForLimited();
    var resultImage = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => pickerImageForLimited),
    );
    debugPrint("ImageFile ${resultImage}");
    if (resultImage != null) {
      BlocProvider.of<ProfileEditCubit>(context)
          .updateProfilePicture(resultImage);
    }
  }

  Future<void> onSelectChangeImageProfile() async {
    bool canSelectImage = false;
    bool status = false;
    bool statusiOSGranted = false;
    bool statusiOSLimited = false;
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? iosVersion;
    List<String> v = [];
    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      iosVersion = iosInfo.systemVersion;
      v = iosVersion.split(".");
    }
    PermissionStatus newStatus;
    debugPrint("OSVersionDeviceInfo $iosVersion");
    debugPrint("OSVersionDeviceInfo $v");
    try {
      if (Platform.isAndroid) {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        if (androidInfo.version.sdkInt >= 33) {
          status = await Permission.photos.isGranted;
        } else {
          status = await Permission.storage.isGranted;
        }
      } else {
        // iOS
        statusiOSGranted = await Permission.photos.isGranted;
        statusiOSLimited = await Permission.photos.isLimited;
        debugPrint("Status1 $statusiOSGranted");
        debugPrint("Status2 $statusiOSLimited");
        status = statusiOSGranted || statusiOSLimited;
      }
      if (!status) {
        if (Platform.isAndroid) {
          DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          if (androidInfo.version.sdkInt >= 33) {
            newStatus = await Permission.photos.request();
          } else {
            newStatus = await Permission.storage.request();
          }
        } else {
          // iOS
          newStatus = await Permission.photos.request();
          statusiOSGranted = await Permission.photos.isGranted;
          statusiOSLimited = await Permission.photos.isLimited;
          debugPrint("NewStatus $newStatus");
          debugPrint("NewStatus1 $statusiOSGranted");
          debugPrint("NewStatus2 $statusiOSLimited");
        }
        if (newStatus.isGranted || newStatus.isLimited) {
          canSelectImage = true;
        } else {
          canSelectImage = false;
        }
      } else {
        debugPrint("Status1 $statusiOSGranted");
        debugPrint("Status2 $statusiOSLimited");
        canSelectImage = true;
      }
    } catch (e) {}
    final ImagePicker picker = ImagePicker();
    // final XFile? image =
    if (canSelectImage) {
      int iosV = 0;
      if (v.length > 0) {
        try {
          iosV = int.parse(v[0]);
        } catch (e) {
          iosV = 0;
        }
      }
      if (statusiOSLimited && (iosV > 13)) {
        showImagePickerForlimited();
      } else {
        await picker.pickImage(source: ImageSource.gallery).then(
          (value) {
            File imagesFile = File(value?.path ?? '');
            BlocProvider.of<ProfileEditCubit>(context)
                .updateProfilePicture(imagesFile);
            // final multipartFile = await MultipartFile.fromFile(
            //   imagesFile.path,
            //   filename: imagesFile.path.split('/').last,
            // ).then(
            //   (imgMulti) {

            //   },
            // );
            return value;
          },
        );
      }
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.DEFAULT,
          isForce: false,
          title: translate('alert_permission_photos.request_permission'),
          description: translate(
              'alert_permission_photos.request_permission_description'),
          textButton: translate('button.setting'),
          onPressButton: () {
            Navigator.of(context).pop();
            onPressedGoToSetting();
          },
        );
      });
    }
  }

  void onPressedAddTaxInvoice() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfileAddTaxInVoicePage();
    }));
  }

  Future<void> onPressedItemTaxInvoice(int index) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfileAddTaxInVoicePage(
        billingData: listBilling[index],
      );
    }));
    BlocProvider.of<ProfileEditCubit>(context).fetchTaxInvoice();
  }

  void onSlideDeleteBilling(BillingEntity item) {
    Utilities.alertTwoButtonAction(
      context: context,
      type: AppAlertType.WARNING,
      title: translate('alert.title.warning'),
      description:
          '${translate('alert.description.delete_tax_confirm')}\n(${item.billingName}/${item.billingId})',
      textButtonLeft: translate('button.cancel'),
      textButtonRight: translate('button.confirm'),
      onPressButtonLeft: () {
        Navigator.of(context).pop();
      },
      onPressButtonRight: () {
        BlocProvider.of<ProfileEditCubit>(context).fetchDeleteTaxInvoice(item);
        Navigator.of(context).pop();
      },
    );
  }

  void actionProfileLoading() {}

  void actionProfileSuccess(state) {
    setState(() {
      profileEntity = state.profileEntity;
    });
    initValueProfile();
  }

  void actionProfileFailure() {}

  void actionProfileEditImageLoading() {
    loadProfile = 'IMAGE';
  }

  void actionProfileEditImageSuccess() {
    BlocProvider.of<ProfileCubit>(context).loadProfile();
    Utilities.alertAfterSaveAction(
      context: context,
      type: AppAlertType.SUCCESS,
      text: translate('alert_after_save.save_success.profile'),
    );
  }

  void actionProfileEditImageFailure() {
    Utilities.alertAfterSaveAction(
      context: context,
      type: AppAlertType.WARNING,
      time: 5,
      text: translate('alert_after_save.save_failure.profile'),
    );
  }

  void actionProfileEditSaveLoading() {
    loadProfile = 'TEXTPROFILE';
  }

  void actionProfileEditSaveSuccess() {
    BlocProvider.of<ProfileCubit>(context).loadProfile();
    Navigator.of(context).pop();
  }

  void actionProfileEditSaveFailure() {}

  void actionProfileEditGetTaxInvoiceLoading() {}

  void actionProfileEditGetTaxInvoiceSuccess(state) {
    listBilling = state.listBilling.billing ?? [];
    setState(() {});
    BlocProvider.of<ProfileEditCubit>(context).resetStateProfileEdit();
  }

  void actionProfileEditGetTaxInvoiceFailure(state) {
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

  void actionProfileEditDeleteTaxInvoiceLoading() {}

  void actionProfileEditDeleteTaxInvoiceSuccess() {
    BlocProvider.of<ProfileEditCubit>(context).fetchTaxInvoice();
  }

  void actionProfileEditDeleteTaxInvoiceFailure(state) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          text: translate('app_title.profile'),
          color: AppTheme.blueDark,
          fontSize: Utilities.sizeFontWithDesityForDisplay(
              context, AppFontSize.title),
          fontWeight: FontWeight.w700,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 4),
            child: InkWell(
              highlightColor: AppTheme.black5,
              borderRadius: BorderRadius.circular(200),
              onTap: onPressedSaveButton,
              child: Ink(
                  padding: const EdgeInsets.all(16),
                  child: TextLabel(
                    text: translate('profile_edit_page.button.save'),
                    color: hasEdit ? AppTheme.blueD : AppTheme.gray9CA3AF,
                    fontSize: Utilities.sizeFontWithDesityForDisplay(
                        context, AppFontSize.big),
                  )),
            ),
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ProfileCubit, ProfileState>(
            listener: (context, state) {
              switch (state.runtimeType) {
                case ProfileLoading:
                  actionProfileLoading();
                  break;
                case ProfileSuccess:
                  actionProfileSuccess(state);
                  break;
                case ProfileFailure:
                  actionProfileFailure();
                  break;
              }
            },
          ),
          BlocListener<ProfileEditCubit, ProfileEditState>(
            listener: (context, state) {
              switch (state.runtimeType) {
                case ProfileEditImageLoading:
                  actionProfileEditImageLoading();
                  break;
                case ProfileEditImageSuccess:
                  actionProfileEditImageSuccess();
                  break;
                case ProfileEditImageFailure:
                  actionProfileEditImageFailure();
                  break;
                case ProfileEditSaveLoading:
                  actionProfileEditSaveLoading();
                  break;
                case ProfileEditSaveSuccess:
                  actionProfileEditSaveSuccess();
                  break;
                case ProfileEditSaveFailure:
                  actionProfileEditSaveFailure();
                  break;
                case ProfileEditGetTaxInvoiceLoading:
                  actionProfileEditGetTaxInvoiceLoading();
                  break;
                case ProfileEditGetTaxInvoiceSuccess:
                  actionProfileEditGetTaxInvoiceSuccess(state);
                  break;
                case ProfileEditGetTaxInvoiceFailure:
                  actionProfileEditGetTaxInvoiceFailure(state);
                  break;
                case ProfileEditDeleteTaxInvoiceLoading:
                  actionProfileEditDeleteTaxInvoiceLoading();
                  break;
                case ProfileEditDeleteTaxInvoiceSuccess:
                  actionProfileEditDeleteTaxInvoiceSuccess();
                  break;
                case ProfileEditDeleteTaxInvoiceFailure:
                  actionProfileEditDeleteTaxInvoiceFailure(state);
                  break;
              }
            },
          ),
        ],
        child: renderProfieEditField(),
      ),
    );
  }

  Widget renderProfieEditField() {
    return UnfocusArea(
      child: Stack(
        children: [
          Container(
            height: (MediaQuery.of(context).size.height * 0.9),
            color: AppTheme.white,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileChangeImage(
                      profileEntity: profileEntity,
                      onSelectChangeImageProfile: onSelectChangeImageProfile,
                    ),
                    const SizedBox(height: 16),
                    ProfileFieldEdit(
                      onChangeSetHasEditTrue: onChangeSetHasEditTrue,
                      controllerUsername: controllerUsername,
                      controllerFirstName: controllerFirstName,
                      controllerLastName: controllerLastName,
                      controllerBirthDay: controllerBirthDay,
                      controllerPhoneNumber: controllerPhoneNumber,
                      controllerGender: controllerGender,
                    ),
                    const SizedBox(height: 16),
                    ProfileAddTaxInvoice(
                      listItem: listBilling,
                      onSlide: onSlideDeleteBilling,
                      onPressedAddTaxInvoice: onPressedAddTaxInvoice,
                      onPressedItemTaxInvoice: onPressedItemTaxInvoice,
                    ),
                    Container(color: AppTheme.white, height: 70),
                    ProfileBottomLogout(
                      heightBottom: heightBottom,
                      onPressedLogout: onPressedLogout,
                      versionApp: "V$versionApp",
                      isLogoutProcess: isLogoutProcess,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom > 0
                            ? 40
                            : 0)
                  ],
                ),
              ),
            ),
          ),
          ButtonCloseKeyboard(contextPage: context)
        ],
      ),
    );
  }
}
