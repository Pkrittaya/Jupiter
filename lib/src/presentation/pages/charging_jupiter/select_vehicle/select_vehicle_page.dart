import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/select_vehicle/cubit/select_vehicle_cubit.dart';
import 'package:jupiter/src/presentation/widgets/button_close_keyboard.dart';
import 'package:jupiter/src/presentation/widgets/loading_page.dart';
import 'package:jupiter/src/presentation/widgets/text_input_form.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/presentation/widgets/unfocus_area.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/data/data_models/request/car_select_fleet_form.dart';
import 'package:jupiter_api/domain/entities/car_select_entity.dart';
import 'package:jupiter_api/domain/entities/car_select_fleet_entity.dart';
import 'package:jupiter_api/domain/entities/list_car_select_fleet_entity.dart';

class SelectVehiclePage extends StatefulWidget {
  const SelectVehiclePage(
      {super.key,
      this.fleetType,
      this.fromFleet,
      this.fleetNo,
      this.listCarEntity,
      required this.typePage,
      required this.onSaveVehicle,
      required this.indexSelected,
      required this.qrCodeData});

  final String? fleetType;
  final bool? fromFleet;
  final int? fleetNo;
  final List<CarSelectEntity>? listCarEntity;
  final String typePage;
  final Function(int) onSaveVehicle;
  final int indexSelected;
  final String qrCodeData;

  @override
  State<SelectVehiclePage> createState() => _SelectVehiclePageState();
}

class _SelectVehiclePageState extends State<SelectVehiclePage> {
  bool loadingVisible = false;
  GlobalKey<State<StatefulWidget>> keySearchStation =
      GlobalKey<State<StatefulWidget>>();
  TextEditingController searchControl = TextEditingController();
  FocusNode focusSearchStation = FocusNode();

  ListCarSelectFleetEntity? listcar;
  List<CarSelectFleetEntity> carFleetList = [];

  var carListForSearch = [];
  var selectCar;

  void onPressedClearTextInput() {
    searchControl.text = '';
    switch (widget.typePage) {
      case 'CHECKIN':
        carListForSearch = widget.listCarEntity ?? [];
        break;
      case 'CHARGING':
        carListForSearch = carFleetList;
        break;
      default:
        carListForSearch = [];
        break;
    }
    focusSearchStation.unfocus();
    setState(() {});
  }

  void getListSearch(String text) {
    switch (widget.typePage) {
      case 'CHECKIN':
        carListForSearch = (widget.listCarEntity ?? [])
            .where((item) =>
                ((item.brand ?? '')
                    .toLowerCase()
                    .contains(text.toLowerCase())) ||
                ((item.model ?? '').toLowerCase().contains(text.toLowerCase())))
            .toList();
        break;
      case 'CHARGING':
        carListForSearch = carFleetList
            .where((item) =>
                ((item.brand ?? '')
                    .toLowerCase()
                    .contains(text.toLowerCase())) ||
                ((item.model ?? '').toLowerCase().contains(text.toLowerCase())))
            .toList();
        break;
      default:
        carListForSearch = [];
        break;
    }
    setState(() {});
  }

  void onTapSelectCar(var car) {
    if (selectCar == car) {
      selectCar = null;
    } else {
      selectCar = car;
    }
    setState(() {});
  }

  void onSaveSelectCar(var car) {
    switch (widget.typePage) {
      case 'CHECKIN':
        if (car != null) {
          int search = (widget.listCarEntity ?? []).indexWhere((item) =>
              ((item.licensePlate == car.licensePlate) &&
                  (item.province == car.province)));
          if (search >= 0) {
            widget.onSaveVehicle(search);
          } else {
            widget.onSaveVehicle(-1);
          }
        } else {
          widget.onSaveVehicle(-1);
        }
        onPressedBackButton();
        break;
      case 'CHARGING':
        if (car != null) {
          BlocProvider.of<SelectVehicleCubit>(context).fetchSaveVehicle(
              fleetNo: widget.fleetNo ?? -1,
              qrCodeConnector: widget.qrCodeData,
              carSelect: CarSelectFleetForm(
                  vehicleNo: car.vehicleNo,
                  licensePlate: car.licensePlate,
                  province: car.province));
        }
        break;
      default:
        break;
    }
  }

  void onLoadSelectCar(int index) {
    switch (widget.typePage) {
      case 'CHECKIN':
        try {
          selectCar = (widget.listCarEntity ?? [])[index];
        } catch (e) {
          debugPrint('error $e');
        }
        break;
      case 'CHARGING':
        BlocProvider.of<SelectVehicleCubit>(context)
            .loadingVehicleForFleet(widget.fleetNo ?? -1);
        break;
      default:
        break;
    }
  }

  void onPressedBackButton() {
    Navigator.of(context).pop();
  }

  void checkLoadCarList(String type) {
    switch (type) {
      case 'CHECKIN':
        carListForSearch = widget.listCarEntity ?? [];
        break;
      case 'CHARGING':
        carListForSearch = carFleetList;
        break;
      default:
        carListForSearch = [];
        break;
    }
  }

  void actionSelectVehicleLoading() {
    if (!loadingVisible) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          loadingVisible = true;
        });
      });
    }
  }

  void actionSaveVehicleFailure(state) {
    if (loadingVisible) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          loadingVisible = false;
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

  void actionSaveVehicleSuccess() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingVisible) {
        setState(() {
          loadingVisible = false;
        });
        onPressedBackButton();
      }
    });
  }

  void actionLoadVehicleFailure(state) {
    if (loadingVisible) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          loadingVisible = false;
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

  void actionLoadVehicleSuccess(state) {
    if (loadingVisible) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          loadingVisible = false;
          listcar = state.carList;
          carFleetList = listcar?.carSelect ?? [];
          carListForSearch = carFleetList;
          debugPrint('carFleetList ${carFleetList[0].brand}');
        });
      });
    }
  }

  @override
  void initState() {
    checkLoadCarList(widget.typePage);
    onLoadSelectCar(widget.indexSelected);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var heightKeyboard = MediaQuery.of(context).viewInsets.bottom > 0
        ? MediaQuery.of(context).viewInsets.bottom + 17
        : 0;
    var appBarHeight = AppBar().preferredSize.height;
    var heightDevice = MediaQuery.of(context).size.height;
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
                text: translate("charging_page.select_vehicle.title"),
                color: AppTheme.blueDark,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.title),
                fontWeight: FontWeight.w700,
              ),
              actions: [
                Container(
                  padding: EdgeInsets.only(right: 20),
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      onSaveSelectCar(selectCar);
                    },
                    child: TextLabel(
                      text: translate("charging_page.select_vehicle.save"),
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.large),
                      fontWeight: FontWeight.w700,
                      color: AppTheme.blueD,
                    ),
                  ),
                )
              ],
            ),
            body: Container(
              child: BlocBuilder<SelectVehicleCubit, SelectVehicleState>(
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case SelectVehicleLoading:
                      actionSelectVehicleLoading();
                      break;
                    case SaveVehicleSuccess:
                      actionSaveVehicleSuccess();
                      break;
                    case SaveVehicleFailure:
                      actionSaveVehicleFailure(state);
                      break;
                    case LoadVehicleSuccess:
                      actionLoadVehicleSuccess(state);
                      break;
                    case LoadVehicleFailure:
                      actionLoadVehicleFailure(state);
                      break;
                  }
                  return Column(
                    children: [
                      Container(
                        color: AppTheme.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                          child: Container(
                            child: TextInputForm(
                              key: keySearchStation,
                              contentPadding: const EdgeInsets.all(0),
                              borderRadius: 200,
                              borderColor: AppTheme.grayD4A50,
                              style: const TextStyle(color: AppTheme.black60),
                              icon: Icon(
                                Icons.search,
                                color: AppTheme.gray9CA3AF,
                              ),
                              fillColor: AppTheme.white,
                              controller: searchControl,
                              hintText: translate(
                                  "charging_page.select_vehicle.search_vehicle"),
                              hintStyle: TextStyle(
                                color: AppTheme.black60,
                                fontSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                        context, AppFontSize.large),
                              ),
                              obscureText: false,
                              suffixIcon: focusSearchStation.hasFocus
                                  ? IconButton(
                                      splashColor: AppTheme.transparent,
                                      icon: Icon(Icons.close),
                                      color: AppTheme.gray9CA3AF,
                                      onPressed: onPressedClearTextInput,
                                    )
                                  : const SizedBox(),
                              keyboardType: TextInputType.text,
                              onChanged: (text) {
                                getListSearch(text ?? '');
                              },
                              focusNode: focusSearchStation,
                              onFieldSubmitted: (text) {
                                getListSearch(text ?? '');
                              },
                              onTap: () {
                                Utilities.ensureVisibleOnTextInput(
                                    textfieldKey: keySearchStation);
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(color: AppTheme.grayF1F5F9, height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.white,
                        ),
                        height: ((heightDevice - appBarHeight) * 0.8) -
                            heightKeyboard,
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
                          onNotification:
                              (OverscrollIndicatorNotification overscroll) {
                            overscroll.disallowIndicator();
                            return true;
                          },
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return SizedBox();
                            },
                            shrinkWrap: true,
                            itemCount: carListForSearch.length,
                            itemBuilder: (context, index) {
                              var carEntity = carListForSearch[index];
                              return Column(
                                children: [
                                  renderRowListCar(carEntity),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    height: 1,
                                    color: AppTheme.borderGray,
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      ButtonCloseKeyboard(contextPage: context)
                    ],
                  );
                },
              ),
            ),
          ),
          LoadingPage(visible: loadingVisible)
        ],
      ),
    );
  }

  Widget renderRowListCar(var carEntity) {
    return Material(
      color: AppTheme.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          onTapSelectCar(carEntity);
        },
        child: Container(
          padding: const EdgeInsets.only(top: 4, bottom: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Container(
                width: 70,
                height: 70,
                child: carEntity.image != null && carEntity.image!.isNotEmpty
                    ? Image.network(
                        carEntity.image!,
                      )
                    : SvgPicture.asset(
                        ImageAsset.vehicle_non_img,
                      ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextLabel(
                      text: '${carEntity.brand} ${carEntity.model}',
                      color: AppTheme.blueDark,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.big),
                      fontWeight: FontWeight.bold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    TextLabel(
                      text: '${carEntity.licensePlate} ${carEntity.province}',
                      color: AppTheme.gray9CA3AF,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.little),
                    ),
                  ],
                ),
              ),
              renderButtonSelectVehicle(carEntity),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderButtonSelectVehicle(var carEntity) {
    return Container(
        padding: EdgeInsets.only(left: 32),
        child: SizedBox.fromSize(
          size: const Size(24, 24),
          child: (selectCar == carEntity)
              ? Icon(Icons.check_circle, color: AppTheme.blueD, size: 24)
              : Icon(Icons.circle_outlined,
                  color: AppTheme.gray9CA3AF, size: 24),
        ));
  }
}
