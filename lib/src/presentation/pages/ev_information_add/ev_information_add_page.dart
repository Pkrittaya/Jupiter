import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/unfocus_area.dart';
import 'package:jupiter_api/domain/entities/car_entity.dart';
import 'package:jupiter/src/presentation/pages/ev_information/cubit/ev_information_cubit.dart';
import 'package:jupiter/src/presentation/pages/ev_information_add/widget/default_vehicle.dart';
import 'package:jupiter/src/presentation/pages/ev_information_add/widget/select_brand_model.dart';
import 'package:jupiter/src/presentation/pages/ev_information_add/widget/vehicle_information.dart';
import 'package:jupiter/src/presentation/widgets/button.dart';
import 'package:jupiter/src/presentation/widgets/button_close_keyboard.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/presentation/widgets/tootip_information.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/domain/entities/car_master_entity.dart';
import '../../../firebase_log.dart';
import '../../../injection.dart';
import 'cubit/ev_information_add_cubit.dart';

class EVInformationAddPageWrapperProvider extends StatelessWidget {
  const EVInformationAddPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EvInformationAddCubit>(),
      child: const EvInformationAddPage(),
    );
  }
}

class EvInformationAddPage extends StatefulWidget {
  const EvInformationAddPage({
    super.key,
    this.carEntity,
    this.fromFleet,
  });

  final CarEntity? carEntity;
  final bool? fromFleet;

  @override
  State<EvInformationAddPage> createState() => _EvInformationAddPageState();
}

class _EvInformationAddPageState extends State<EvInformationAddPage> {
  String appBarText = translate('app_title.ev_information_add_page');
  CarMasterEntity brandSelect = CarMasterEntity(brand: '', model: []);
  TextEditingController brandTxEditController = TextEditingController();
  String? carImage;
  List<CarMasterEntity> carMaster = List.empty(growable: true);
  bool editDefault = false;
  TextEditingController licensePlateController = TextEditingController();
  TextEditingController modelTxEditController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  bool vehicle = false;
  int vehicleOld = -1;
  // FOR FLEET
  bool canEdit = true;
  bool loadAddCar = false;
  bool loadEditCar = false;

  // FOR VALIDATE
  bool validateBrand = false;
  bool validateModel = false;
  bool validateLicensePlate = false;
  bool validateProvince = false;
  bool checkOnPressSaveFirst = false;

  @override
  void initState() {
    FirebaseLog.logPage(this);
    BlocProvider.of<EvInformationAddCubit>(context).loadCarMaster();
    super.initState();
    initEditWidget();
  }

  void initEditWidget() {
    if (widget.carEntity != null) {
      appBarText = widget.fromFleet != true
          ? translate('app_title.ev_information_Edit_page')
          : translate('app_title.ev_info');
      brandTxEditController.text = widget.carEntity!.brand;
      modelTxEditController.text = widget.carEntity!.model;
      carImage = widget.carEntity!.image;
      licensePlateController.text = widget.carEntity!.licensePlate;
      provinceController.text = widget.carEntity!.province;
      vehicle = widget.carEntity!.defalut;
      vehicleOld = widget.carEntity!.vehicleNo;
      editDefault = true;
      canEdit = widget.fromFleet != true;
    }
  }

  void onPressdSaveAddVehicle(
    BuildContext widgetContext,
  ) {
    if (brandTxEditController.text.isNotEmpty &&
        modelTxEditController.text.isNotEmpty &&
        licensePlateController.text.trim().isNotEmpty &&
        provinceController.text.isNotEmpty) {
      validateBrand = false;
      validateModel = false;
      validateLicensePlate = false;
      validateProvince = false;
      if (editDefault) {
        debugPrint(
            'VEHICLE NO : ${getVehicleID(brand: brandTxEditController.text, model: modelTxEditController.text)}');
        BlocProvider.of<EvInformationAddCubit>(widgetContext).editCar(
          vehicleNoCurrent: vehicleOld,
          vehicleNo: getVehicleID(
              brand: brandTxEditController.text,
              model: modelTxEditController.text),
          licensePlateCurrent: widget.carEntity!.licensePlate,
          licensePlate: licensePlateController.text.trim(),
          provinceCurrent: widget.carEntity!.province,
          province: provinceController.text,
          defalut: vehicle,
        );
      } else {
        BlocProvider.of<EvInformationAddCubit>(widgetContext).addCar(
          vehicleNo: getVehicleID(
              brand: brandTxEditController.text,
              model: modelTxEditController.text),
          licensePlate: licensePlateController.text.trim(),
          province: provinceController.text,
          defalut: vehicle,
        );
      }
    } else {
      checkOnPressSaveFirst = true;
      onCheckValidate();
    }
  }

  int getVehicleID({required String brand, required String model}) {
    if (carMaster.length > 0) {
      for (int i = 0; i < carMaster.length; i++) {
        for (int j = 0; j < carMaster[i].model.length; j++) {
          if (brandTxEditController.text == carMaster[i].brand &&
              modelTxEditController.text == carMaster[i].model[j].name) {
            debugPrint(
                'NAME : ${carMaster[i].brand} ${carMaster[i].model[j].name}');
            debugPrint('ID : ${carMaster[i].model[j].vehicleNo}');
            return carMaster[i].model[j].vehicleNo ?? -1;
          }
        }
      }
    }
    return -1;
  }

  void onChangeDefault(bool value) {
    if (!editDefault || !widget.carEntity!.defalut) {
      vehicle = value;
      setState(() {});
    }
  }

  void onCheckValidate() {
    if (checkOnPressSaveFirst) {
      // Brand
      if (brandTxEditController.text.isEmpty) {
        validateBrand = true;
      } else {
        validateBrand = false;
      }

      // Model
      if (modelTxEditController.text.isEmpty) {
        validateModel = true;
      } else {
        validateModel = false;
      }

      // License Plate
      if (licensePlateController.text.trim().isEmpty) {
        validateLicensePlate = true;
      } else {
        validateLicensePlate = false;
      }

      // Province
      if (provinceController.text.isEmpty) {
        validateProvince = true;
      } else {
        validateProvince = false;
      }
    }

    setState(() {});
  }

  void onPressedBackButton() {
    Navigator.of(context).pop();
  }

  void actionEvInformationAddLoading() {
    loadAddCar = true;
  }

  void actionEvInformationAddSuccess(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadAddCar) {
        setState(() {
          loadAddCar = false;
        });
        BlocProvider.of<EvInformationCubit>(context).loadCarList();
        Navigator.of(context).pop();
      }
    });
  }

  void actionEvInformationAddFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadAddCar) {
        setState(() {
          loadAddCar = false;
        });
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.DEFAULT,
          isForce: true,
          title: translate('alert.title.default'),
          description: state.message ?? translate('alert.description.default'),
          textButton: translate('button.try_again'),
          onPressButton: () {
            BlocProvider.of<EvInformationAddCubit>(context).resetState();
            Navigator.of(context).pop();
          },
        );
      }
    });
  }

  void actionEvLoadCarMasterLoading() {}

  void actionEvLoadCarMasterSuccess(state) {
    setState(() {
      carMaster = state.carMaster ?? List.empty(growable: true);
    });
    try {
      setState(() {
        brandSelect = state.carMaster!.firstWhere((option) =>
            option.brand.toLowerCase() ==
            brandTxEditController.text.toLowerCase());
      });
    } catch (e) {}
  }

  void actionEvLoadCarMasterFailure() {}

  void actionEvInformationEditLoading() {
    loadEditCar = true;
  }

  void actionEvInformationEditSuccess(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadEditCar) {
        setState(() {
          loadEditCar = false;
        });
        BlocProvider.of<EvInformationCubit>(context).loadCarList();
        Navigator.of(context).pop();
      }
    });
  }

  void actionEvInformationEditFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadEditCar) {
        setState(() {
          loadEditCar = false;
        });
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.DEFAULT,
          isForce: true,
          title: translate('alert.title.default'),
          description: state.message ?? translate('alert.description.default'),
          textButton: translate('button.try_again'),
          onPressButton: () {
            BlocProvider.of<EvInformationAddCubit>(context).resetState();
            Navigator.of(context).pop();
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var widgetContext = context;
    return UnfocusArea(
      child: Scaffold(
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
            text: appBarText,
            color: AppTheme.blueDark,
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.title),
            fontWeight: FontWeight.bold,
          ),
          actions: [
            TooltipInformation(
              message: translate('ev_information_add_page.information'),
              iconSize: 20,
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.9,
              padding: const EdgeInsets.all(16),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: SingleChildScrollView(
                  child: MultiBlocListener(
                    listeners: [
                      BlocListener<EvInformationAddCubit,
                          EvInformationAddState>(
                        listener: (context, state) {
                          switch (state.runtimeType) {
                            case EvInformationAddLoading:
                              actionEvInformationAddLoading();
                              break;
                            case EvInformationAddSuccess:
                              actionEvInformationAddSuccess(context);
                              break;
                            case EvInformationAddFailure:
                              actionEvInformationAddFailure(state);
                              break;
                            case EvLoadCarMasterLoading:
                              actionEvLoadCarMasterLoading();
                              break;
                            case EvLoadCarMasterSuccess:
                              actionEvLoadCarMasterSuccess(state);
                              break;
                            case EvLoadCarMasterFailure:
                              actionEvLoadCarMasterFailure();
                              break;
                            case EvInformationEditLoading:
                              actionEvInformationEditLoading();
                              break;
                            case EvInformationEditSuccess:
                              actionEvInformationEditSuccess(context);
                              break;
                            case EvInformationEditFailure:
                              actionEvInformationEditFailure(state);
                              break;
                          }
                        },
                      ),
                    ],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectBrandModel(
                            carMaster: carMaster,
                            brandSelect: brandSelect,
                            brandTxEditController: brandTxEditController,
                            modelTxEditController: modelTxEditController,
                            carImage: carImage,
                            canEdit: canEdit,
                            validateBrand: validateBrand,
                            validateModel: validateModel,
                            onValidate: onCheckValidate),
                        const SizedBox(height: 16),
                        VehicleInform(
                            licensePlateController: licensePlateController,
                            provinceController: provinceController,
                            canEdit: canEdit,
                            validateLicensePlate: validateLicensePlate,
                            validateProvince: validateProvince,
                            onValidate: onCheckValidate),
                        (validateBrand ||
                                validateModel ||
                                validateLicensePlate ||
                                validateProvince)
                            ? Container(
                                padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
                                child: TextLabel(
                                  text: translate(
                                      'ev_information_add_page.validate.empty_field'),
                                  color: AppTheme.red,
                                  fontSize:
                                      Utilities.sizeFontWithDesityForDisplay(
                                          context, AppFontSize.normal),
                                ),
                              )
                            : SizedBox.shrink(),
                        const SizedBox(height: 16),
                        Visibility(
                          visible: canEdit,
                          child: DefaultInformation(
                            setdefault: vehicle,
                            editDefault: editDefault,
                            onChanged: onChangeDefault,
                          ),
                        ),
                        SizedBox(
                          height: (MediaQuery.of(context).size.height * 0.11) +
                              (MediaQuery.of(context).viewInsets.bottom > 0
                                  ? 40
                                  : 0),
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: canEdit,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: AppTheme.white,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.11,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: Button(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        shadowColor: Colors.transparent,
                        backgroundColor: AppTheme.blueD,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(200)),
                        ),
                      ),
                      text: translate('ev_information_add_page.button_save'),
                      onPressed: () {
                        onPressdSaveAddVehicle(widgetContext);
                      },
                      textColor: Colors.white,
                    ),
                  ),
                  ButtonCloseKeyboard(contextPage: context)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
