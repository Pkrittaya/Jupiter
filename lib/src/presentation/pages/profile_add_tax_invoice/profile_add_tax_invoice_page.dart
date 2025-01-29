import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/unfocus_area.dart';
import 'package:jupiter_api/data/data_models/request/billing_form.dart';
import 'package:jupiter_api/domain/entities/billing_entity.dart';
import 'package:jupiter_api/domain/entities/profile_entity.dart';
import 'package:jupiter/src/presentation/pages/profile_add_tax_invoice/cubit/profile_add_tax_invoice_cubit.dart';
import 'package:jupiter/src/presentation/pages/profile_add_tax_invoice/widgets/information_type.dart';
import 'package:jupiter/src/presentation/pages/profile_edit/cubit/profile_edit_cubit.dart';
import 'package:jupiter/src/presentation/widgets/button_close_keyboard.dart';
import 'package:jupiter/src/presentation/widgets/loading_page.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import '../../../firebase_log.dart';
import 'widgets/profile_field_add_invoice.dart';

class ProfileAddTaxInVoicePage extends StatefulWidget {
  const ProfileAddTaxInVoicePage({
    super.key,
    this.billingData,
  });
  final BillingEntity? billingData;
  @override
  State<ProfileAddTaxInVoicePage> createState() =>
      _ProfileAddTaxInVoicePageState();
}

class _ProfileAddTaxInVoicePageState extends State<ProfileAddTaxInVoicePage>
    with TickerProviderStateMixin {
  ProfileEntity? profileEntity;
  // TITLE APP BAR
  String titleAppbar = translate('app_title.tax_invoice');
  // FIELD CONTROLLER
  final formKey = GlobalKey<FormState>();
  bool setDefaultGender = false;
  TextEditingController controllerBillingName = TextEditingController();
  TextEditingController controllerTaxIdNationalId = TextEditingController();
  TextEditingController controllerBranchName = TextEditingController();
  TextEditingController controllerBranchCode = TextEditingController();
  TextEditingController controllerAddress = TextEditingController();
  TextEditingController controllerProvince = TextEditingController();
  TextEditingController controllerDistrict = TextEditingController();
  TextEditingController controllerSubdistrict = TextEditingController();
  TextEditingController controllerPostalCode = TextEditingController();
  bool isDefault = false;
  List<String> idField = [
    'BILLING_TYPE',
    'BILLING_NAME',
    'BILLING_TAX_ID',
    'BRANCH_NAME',
    'BRANCH_CODE',
    'ADDRESS',
    'PROVINCE',
    'DISTRICT',
    'SUB_DISTRICT',
    'POSTAL_CODE',
    'DEFAULT'
  ];

  // set color validaet field -- default , success , error
  List<String> colorValidateField = [
    'default', // BILLING_TYPE
    'default', // BILLING_NAME
    'default', // BILLING_TAX_ID
    'default', // BRANCH_NAME
    'default', // BRANCH_CODE
    'default', // ADDRESS
    'default', // PROVINCE
    'default', // DISTRICT
    'default', // SUB_DISTRICT
    'default', // POSTAL_CODE
    'default' // DEFAULT
  ];

  // TAB CONTROLLER
  late TabController tabController;
  int indexType = 0;
  // OTHER
  bool hasEdit = false;
  bool isLoadingPage = false;
  double heightBottom = 100;

  @override
  void initState() {
    FirebaseLog.logPage(this);
    initialBillingData();
    super.initState();
  }

  void initialBillingData() {
    if (widget.billingData != null) {
      titleAppbar = translate('app_title.update_tax_invoice');
      if (widget.billingData!.billingType == 'corporate')
        initTabOptionController(1);
      else
        initTabOptionController(0);
      controllerBillingName.text = '${widget.billingData!.billingName}';
      controllerTaxIdNationalId.text =
          '${formatIDCard(widget.billingData!.billingId)}';
      controllerBranchName.text = '${widget.billingData!.billingBranchName}';
      controllerBranchCode.text = '${widget.billingData!.billingBranchCode}';
      controllerAddress.text = '${widget.billingData!.billingAddress}';
      controllerProvince.text = '${widget.billingData!.billingProvince}';
      controllerDistrict.text = '${widget.billingData!.billingDistrict}';
      controllerSubdistrict.text = '${widget.billingData!.billingSubdistrict}';
      controllerPostalCode.text = '${widget.billingData!.billingPostalCode}';
      isDefault = widget.billingData?.billingDefault ?? false;
    } else {
      initTabOptionController(0);
    }
    setState(() {});
  }

  void initTabOptionController(int initialIndex) {
    setState(() {
      indexType = initialIndex;
    });
    tabController =
        TabController(length: 2, vsync: this, initialIndex: initialIndex);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        onChangeSetHasEditTrue('', idField[0]);
        setState(() {});
      }
    });
  }

  void onPressedSaveButton() {
    if (hasEdit) {
      FocusScope.of(context).unfocus();
      if (widget.billingData != null) {
        fecthApiUpdateTaxInvoice();
      } else {
        fecthApiAddTaxInvoice();
      }
    }
  }

  void onPressedBackButton() {
    Navigator.of(context).pop();
  }

  void fecthApiUpdateTaxInvoice() {
    BlocProvider.of<ProfileAddTaxInvoiceCubit>(context).fetchUpdateTaxInvoice(
      BillingForm(
        billingType: getBillingType(),
        billingBranchName:
            indexType == 0 ? '' : controllerBranchName.text.trim(),
        billingBranchCode:
            indexType == 0 ? '' : controllerBranchCode.text.trim(),
        billingName: controllerBillingName.text.trim(),
        billingId: controllerTaxIdNationalId.text.trim().replaceAll('-', ''),
        billingAddress: controllerAddress.text.trim(),
        billingProvince: controllerProvince.text.trim(),
        billingDistrict: controllerDistrict.text.trim(),
        billingSubdistrict: controllerSubdistrict.text.trim(),
        billingPostalCode: controllerPostalCode.text.trim(),
        billingDefault: isDefault,
      ),
    );
  }

  void fecthApiAddTaxInvoice() {
    BlocProvider.of<ProfileAddTaxInvoiceCubit>(context).fetchAddTaxInvoice(
      BillingForm(
        billingType: getBillingType(),
        billingBranchName:
            indexType == 0 ? '' : controllerBranchName.text.trim(),
        billingBranchCode:
            indexType == 0 ? '' : controllerBranchCode.text.trim(),
        billingName: controllerBillingName.text.trim(),
        billingId: controllerTaxIdNationalId.text.trim().replaceAll('-', ''),
        billingAddress: controllerAddress.text.trim(),
        billingProvince: controllerProvince.text.trim(),
        billingDistrict: controllerDistrict.text.trim(),
        billingSubdistrict: controllerSubdistrict.text.trim(),
        billingPostalCode: controllerPostalCode.text.trim(),
        billingDefault: isDefault,
      ),
    );
  }

  void onPressedLogout() {
    Utilities.logout(context);
  }

  void onChangeSetHasEditTrue(String? text, String id) {
    // if (id == idField[0]) {
    //   if (indexType == 1 &&
    //       controllerBranchName.text != '' &&
    //       controllerBranchCode.text != '') {
    //     setState(() {
    //       hasEdit = true;
    //     });
    //   }
    //   if (indexType == 0) {
    //     setState(() {
    //       hasEdit = true;
    //     });
    //   }
    // }
    if (id == idField[1]) {
      if (controllerBillingName.text == '') {
        colorValidateField[1] = 'error';
      } else {
        colorValidateField[1] = 'default';
      }
      setState(() {
        hasEdit = false;
      });
    }
    if (id == idField[2]) {
      if (controllerTaxIdNationalId.text == '' ||
          controllerTaxIdNationalId.text.length < 17) {
        colorValidateField[2] = 'error';
      } else {
        colorValidateField[2] = 'default';
      }
      setState(() {
        hasEdit = false;
      });
    }
    if (id == idField[3]) {
      if (controllerBranchName.text == '' && indexType == 1) {
        colorValidateField[3] = 'error';
      } else {
        colorValidateField[3] = 'default';
      }
      setState(() {
        hasEdit = false;
      });
    }
    if (id == idField[4]) {
      if ((controllerBranchCode.text == '' ||
              controllerBranchCode.text.length < 5) &&
          indexType == 1) {
        colorValidateField[4] = 'error';
      } else {
        colorValidateField[4] = 'default';
      }
      setState(() {
        hasEdit = false;
      });
    }
    if (id == idField[5]) {
      if (controllerAddress.text == '') {
        colorValidateField[5] = 'error';
      } else {
        colorValidateField[5] = 'default';
      }
      setState(() {
        hasEdit = false;
      });
    }
    if (id == idField[6]) {
      if (controllerProvince.text == '') {
        colorValidateField[6] = 'error';
      } else {
        colorValidateField[6] = 'default';
      }
      setState(() {
        hasEdit = false;
      });
    }
    if (id == idField[7]) {
      if (controllerDistrict.text == '') {
        colorValidateField[7] = 'error';
      } else {
        colorValidateField[7] = 'default';
      }
      setState(() {
        hasEdit = false;
      });
    }
    if (id == idField[8]) {
      if (controllerSubdistrict.text == '') {
        colorValidateField[8] = 'error';
      } else {
        colorValidateField[8] = 'default';
      }
      setState(() {
        hasEdit = false;
      });
    }
    if (id == idField[9]) {
      if (controllerPostalCode.text == '') {
        colorValidateField[9] = 'error';
      } else {
        colorValidateField[9] = 'default';
      }
      setState(() {
        hasEdit = false;
      });
    }
    // if (id == idField[10]) {
    //   setState(() {
    //     hasEdit = true;
    //   });
    // }
    if (indexType == 0 &&
        controllerBillingName.text != '' &&
        controllerTaxIdNationalId.text != '' &&
        controllerTaxIdNationalId.text.length == 17 &&
        controllerAddress.text != '' &&
        controllerProvince.text != '' &&
        controllerDistrict.text != '' &&
        controllerSubdistrict.text != '' &&
        controllerPostalCode.text != '') {
      setState(() {
        hasEdit = true;
      });
    }
    if (indexType == 1 &&
        controllerBillingName.text != '' &&
        controllerTaxIdNationalId.text.length == 17 &&
        controllerBranchName.text != '' &&
        controllerBranchCode.text.length == 5 &&
        controllerAddress.text != '' &&
        controllerProvince.text != '' &&
        controllerDistrict.text != '' &&
        controllerSubdistrict.text != '' &&
        controllerPostalCode.text != '') {
      setState(() {
        hasEdit = true;
      });
    }
  }

  void onPressedChangeType(int index) {
    setState(() {
      hasEdit = false;
    });
    if (widget.billingData == null) {
      indexType = index;
    }
  }

  void onChangeSwitchDefault(bool value) {
    if (!(widget.billingData?.billingDefault ?? false)) {
      setState(() {
        isDefault = value;
      });
      onChangeSetHasEditTrue('', idField[10]);
    }
  }

  String getBillingType() {
    if (indexType == 0) {
      return 'personal';
    } else {
      return 'corporate';
    }
  }

  String formatIDCard(String text) {
    final List<String> parts = [];

    for (int i = 0; i < text.length; i++) {
      final String char = text[i];
      if (i == 1 || i == 5 || i == 10 || i == 12) {
        parts.add('-');
      }
      if (char != '-') {
        parts.add(char);
      }
    }

    final String formattedText = parts.join('');
    return formattedText;
  }

  void actionProfileAddTaxInvoiceLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isLoadingPage) {
        setState(() {
          isLoadingPage = true;
        });
      }
    });
  }

  void actionProfileAddTaxInvoiceFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoadingPage) {
        setState(() {
          isLoadingPage = false;
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
  }

  void actionProfileAddTaxInvoiceSuccess() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoadingPage) {
        setState(() {
          isLoadingPage = false;
        });
        BlocProvider.of<ProfileEditCubit>(context).fetchTaxInvoice();
        Navigator.of(context).pop();
      }
    });
  }

  void actionProfileUpdateTaxInvoiceLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isLoadingPage) {
        setState(() {
          isLoadingPage = true;
        });
      }
    });
  }

  void actionProfileUpdateTaxInvoiceFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoadingPage) {
        setState(() {
          isLoadingPage = false;
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
  }

  void actionProfileUpdateTaxInvoiceSuccess() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoadingPage) {
        setState(() {
          isLoadingPage = false;
        });
        BlocProvider.of<ProfileEditCubit>(context).fetchTaxInvoice();
        Navigator.of(context).pop();
      }
    });
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
                text: titleAppbar,
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
            body: BlocListener<ProfileAddTaxInvoiceCubit,
                ProfileAddTaxInvoiceState>(
              listener: (context, state) {
                switch (state.runtimeType) {
                  case ProfileAddTaxInvoiceLoading:
                    actionProfileAddTaxInvoiceLoading();
                    break;
                  case ProfileAddTaxInvoiceFailure:
                    actionProfileAddTaxInvoiceFailure(state);
                    break;
                  case ProfileAddTaxInvoiceSuccess:
                    actionProfileAddTaxInvoiceSuccess();
                    break;
                  case ProfileUpdateTaxInvoiceLoading:
                    actionProfileUpdateTaxInvoiceLoading();
                    break;
                  case ProfileUpdateTaxInvoiceFailure:
                    actionProfileUpdateTaxInvoiceFailure(state);
                    break;
                  case ProfileUpdateTaxInvoiceSuccess:
                    actionProfileUpdateTaxInvoiceSuccess();
                    break;
                }
              },
              child: renderAddTaxInvoiceField(),
            ),
          ),
          LoadingPage(visible: isLoadingPage)
        ],
      ),
    );
  }

  Widget renderAddTaxInvoiceField() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 16),
          height: MediaQuery.of(context).size.height * 0.9,
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
                  InformationType(
                    isEdit: widget.billingData != null,
                    indexType: indexType,
                    tabController: tabController,
                    onPressedChangeType: onPressedChangeType,
                  ),
                  const SizedBox(height: 16),
                  ProfileFieldAddTaxInVoice(
                    billingData: widget.billingData,
                    formKey: formKey,
                    indexType: indexType,
                    onChangeSetHasEditTrue: onChangeSetHasEditTrue,
                    controllerBillingName: controllerBillingName,
                    controllerTaxIdNationalId: controllerTaxIdNationalId,
                    controllerBranchName: controllerBranchName,
                    controllerBranchCode: controllerBranchCode,
                    controllerAddress: controllerAddress,
                    controllerProvince: controllerProvince,
                    controllerDistrict: controllerDistrict,
                    controllerSubdistrict: controllerSubdistrict,
                    controllerPostalCode: controllerPostalCode,
                    isDefault: isDefault,
                    onChangeSwitchDefault: onChangeSwitchDefault,
                    colorValidateField: colorValidateField,
                  ),
                  SizedBox(height: indexType == 1 ? 50 : 30),
                  SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom > 0
                          ? 40
                          : 0),
                ],
              ),
            ),
          ),
        ),
        ButtonCloseKeyboard(contextPage: context),
      ],
    );
  }
}
