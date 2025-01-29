import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/fleet_card_item_entity.dart';
import 'package:jupiter_api/domain/entities/fleet_operation_item_entity.dart';
import 'package:jupiter/src/presentation/pages/fleet/cubit/fleet_cubit.dart';
import 'package:jupiter/src/presentation/pages/fleet/fleet_detail/fleet_detail_page.dart';
import 'package:jupiter/src/presentation/pages/fleet/fleet_home/widgets/button_add_card.dart';
import 'package:jupiter/src/presentation/pages/fleet/fleet_card_add/fleet_card_add_page.dart';
import 'package:jupiter/src/presentation/pages/fleet/fleet_home/widgets/list_fleet_card.dart';
import 'package:jupiter/src/presentation/pages/fleet/fleet_home/widgets/list_fleet_operation.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';
import '../../../../firebase_log.dart';

class FleetPage extends StatefulWidget {
  const FleetPage({
    super.key,
    required this.fleetType,
  });

  final String fleetType;

  @override
  State<FleetPage> createState() => _FleetPageState();
}

class _FleetPageState extends State<FleetPage> {
  bool loadingPage = true;
  List<FleetCardItemEntity>? listFleetCardEntity;
  List<FleetOperationItemEntity>? listfleetOperationEntity;
  List<FleetCardItemEntity>? listFleetCardForFilter;
  String selectFilter = 'all';

  @override
  void initState() {
    FirebaseLog.logPage(this);
    loadFleetData();
    super.initState();
  }

  void loadFleetData() {
    switch (widget.fleetType) {
      case FleetType.CARD:
        BlocProvider.of<FleetCubit>(context).fetchListFleetCard();
        break;
      case FleetType.OPERATION:
        BlocProvider.of<FleetCubit>(context).fetchListFleetOperation();
        break;
      default:
        Future.delayed(const Duration(milliseconds: 1000), () {
          setState(() {
            loadingPage = false;
          });
        });
        break;
    }
  }

  void onPressedBackButton() {
    Navigator.of(context).pop();
  }

  String getTitlePageFromFleetType() {
    switch (widget.fleetType) {
      case FleetType.CARD:
        return translate('app_title.fleet_card');
      case FleetType.OPERATION:
        return translate('app_title.fleet_operation');
      default:
        return '';
    }
  }

  Future<void> onTapFleetOperationItem(FleetOperationItemEntity item) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FleetDetailPage(
          fleetType: widget.fleetType,
          fleetNo: item.fleetNo,
        ),
      ),
    );
    loadFleetData();
  }

  Future<void> onTapFleetCardItem(FleetCardItemEntity item) async {
    if (item.statusCharging) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FleetDetailPage(
            fleetType: widget.fleetType,
            fleetNo: item.fleetNo,
            fleetCardNo: item.fleetCardNo,
            fleetCardType: item.fleetCardType,
          ),
        ),
      );
      loadFleetData();
    } else {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FleetDetailPage(
            fleetType: widget.fleetType,
            fleetNo: item.fleetNo,
            fleetCardNo: item.fleetCardNo,
            fleetCardType: item.fleetCardType,
          ),
        ),
      );
      loadFleetData();
    }
  }

  Future<void> onPressedAddFleetCards() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return FleetCardAddPage();
    }));
    loadFleetData();
  }

  void onTapFilter(String key) {
    try {
      selectFilter = key;
      switch (key) {
        case FleetCardType.FLEET:
          listFleetCardForFilter = (listFleetCardEntity ?? [])
              .where((item) => (item.fleetCardType == FleetCardType.FLEET))
              .toList();
        case FleetCardType.RFID:
          listFleetCardForFilter = (listFleetCardEntity ?? [])
              .where((item) => (item.fleetCardType == FleetCardType.RFID))
              .toList();
        case FleetCardType.AUTOCHARGE:
          listFleetCardForFilter = (listFleetCardEntity ?? [])
              .where((item) => (item.fleetCardType == FleetCardType.AUTOCHARGE))
              .toList();
        default:
          listFleetCardForFilter = listFleetCardEntity;
      }
    } catch (e) {
      listFleetCardForFilter = [];
    }
    setState(() {});
  }

  void actionFleetLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingPage) {
        setState(() {
          loadingPage = true;
        });
      }
    });
  }

  void actionFleetCardListLoadingSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          listFleetCardEntity = state.listFleetCardEntity;
          listFleetCardForFilter = state.listFleetCardEntity;
          loadingPage = false;
          selectFilter = 'all';
        });
      }
    });
  }

  void actionFleetCardListLoadingFailure(state) {
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

  void actionFleetOperationListLoadingSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          listfleetOperationEntity = state.listFleetOperationEntity;
          loadingPage = false;
        });
      }
    });
  }

  void actionFleetOperationListLoadingFailure(state) {
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

  void actionDefault() {
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
    return RefreshIndicator(
      onRefresh: () async {
        loadFleetData();
      },
      child: Scaffold(
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
            onPressed: onPressedBackButton,
          ),
          centerTitle: true,
          title: TextLabel(
            text: getTitlePageFromFleetType(),
            color: AppTheme.blueDark,
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.title),
            fontWeight: FontWeight.w700,
          ),
        ),
        body: BlocBuilder<FleetCubit, FleetState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case FleetLoading:
                actionFleetLoading();
                break;
              case FleetCardListLoadingSuccess:
                actionFleetCardListLoadingSuccess(state);
                break;
              case FleetCardListLoadingFailure:
                actionFleetCardListLoadingFailure(state);
                break;
              case FleetOperationListLoadingSuccess:
                actionFleetOperationListLoadingSuccess(state);
                break;
              case FleetOperationListLoadingFailure:
                actionFleetOperationListLoadingFailure(state);
                break;
              default:
                actionDefault();
                break;
            }
            return renderListFleetFromType();
          },
        ),
      ),
    );
  }

  Widget renderListFleetFromType() {
    switch (widget.fleetType) {
      case FleetType.CARD:
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ListFleetCard(
              listfleetCard: listFleetCardForFilter ?? [],
              onTapFleetCardItem: onTapFleetCardItem,
              loading: loadingPage,
              onTapFilter: onTapFilter,
              selectFilter: selectFilter,
            ),
            ButtonAddCard(
              onPressedButton: onPressedAddFleetCards,
            ),
          ],
        );
      case FleetType.OPERATION:
        return ListFleetOperation(
          listfleetOperation: listfleetOperationEntity ?? [],
          onTapFleetOperationItem: onTapFleetOperationItem,
          loading: loadingPage,
        );
      default:
        return Container();
    }
  }
}
