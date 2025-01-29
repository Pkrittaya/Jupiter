import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/car_entity.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/presentation/pages/ev_information/cubit/ev_information_cubit.dart';
import 'package:jupiter/src/presentation/pages/ev_information/widgets/button_add_vehicle.dart';
import 'package:jupiter/src/presentation/pages/ev_information/widgets/list_vehicle.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';
import '../../../firebase_log.dart';

class EVInformationPageWrapperProvider extends StatelessWidget {
  const EVInformationPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EvInformationCubit>(),
      child: const EvInformationPage(),
    );
  }
}

class EvInformationPage extends StatefulWidget {
  const EvInformationPage({
    super.key,
    this.fromFleet,
    this.listCarEntity,
  });

  final bool? fromFleet;
  final List<CarEntity>? listCarEntity;

  @override
  State<EvInformationPage> createState() => _EvInformationPageState();
}

class _EvInformationPageState extends State<EvInformationPage> {
  List<CarEntity> carList = List.empty(growable: true);
  bool loadingPage = false;

  @override
  void initState() {
    FirebaseLog.logPage(this);
    checkLoadCarList();
    super.initState();
  }

  void checkLoadCarList() {
    if (widget.fromFleet == true) {
      BlocProvider.of<EvInformationCubit>(context).resetCarCubit();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          carList = widget.listCarEntity ?? List.empty(growable: true);
        });
      });
    } else {
      BlocProvider.of<EvInformationCubit>(context).loadCarList();
    }
  }

  void onPressedBackButton() {
    Navigator.of(context).pop();
  }

  void confirmDelete(BuildContext context, {required CarEntity carEntity}) {
    if (widget.fromFleet != true) {
      Utilities.alertTwoButtonAction(
        context: context,
        type: AppAlertType.WARNING,
        title: translate("ev_information_page.alert_confirm_delete_title"),
        description:
            translate("ev_information_page.alert_confirm_delete_message"),
        textButtonLeft: translate("button.cancel"),
        textButtonRight: translate("button.confirm"),
        onPressButtonLeft: () {
          Navigator.of(context).pop();
          debugPrint('${carEntity.vehicleNo}');
        },
        onPressButtonRight: () {
          debugPrint('${carEntity.vehicleNo}');
          BlocProvider.of<EvInformationCubit>(context).deleteCar(carEntity);
          Navigator.of(context).pop();
        },
      );
    }
  }

  void actionEvInformationCarLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingPage) {
        setState(() {
          loadingPage = true;
        });
      }
    });
  }

  void actionEvInformationCarLoadingSuccess(state) {
    carList.clear();
    carList.addAll(state.carList ?? List.empty(growable: true));
    carList.sort((a, b) {
      int nameComp = -'${a.defalut}'.compareTo('${b.defalut}');
      if (nameComp == 0) {
        return a.brand.compareTo(b.brand);
      }
      return nameComp;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          carList = carList;
          loadingPage = false;
        });
        BlocProvider.of<EvInformationCubit>(context).resetCarCubit();
      }
    });
  }

  void actionEvInformationCarLoadingFailure() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
        });
        BlocProvider.of<EvInformationCubit>(context).resetCarCubit();
      }
    });
  }

  void actionEvInformationCarDeleteStart() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingPage) {
        setState(() {
          loadingPage = true;
        });
      }
    });
  }

  void actionEvInformationCarDeleteSuccess() {
    BlocProvider.of<EvInformationCubit>(context).loadCarList();
  }

  void actionEvInformationCarDeleteFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
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
        title: TextLabel(
          text: translate('app_title.ev_info'),
          color: AppTheme.blueDark,
          fontSize: Utilities.sizeFontWithDesityForDisplay(
              context, AppFontSize.title),
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BlocBuilder<EvInformationCubit, EvInformationState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case EvInformationCarLoading:
                  actionEvInformationCarLoading();
                  break;
                case EvInformationCarLoadingSuccess:
                  actionEvInformationCarLoadingSuccess(state);
                  break;
                case EvInformationCarLoadingFailure:
                  actionEvInformationCarLoadingFailure();
                  break;
                case EvInformationCarDeleteStart:
                  actionEvInformationCarDeleteStart();
                  break;
                case EvInformationCarDeleteSuccess:
                  actionEvInformationCarDeleteSuccess();
                  break;
                case EvInformationCarDeleteFailure:
                  actionEvInformationCarDeleteFailure(state);
                  break;
              }
              return ListVehicle(
                carList: carList,
                onSlide: confirmDelete,
                loading: loadingPage,
                fromFleet: widget.fromFleet,
              );
            },
          ),
          Visibility(
            visible: widget.fromFleet != true,
            child: ButtonAddVehicle(),
          ),
        ],
      ),
    );
  }
}
