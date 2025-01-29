import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/history_booking_list_entity.dart';
import 'package:jupiter_api/domain/entities/history_entity.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/presentation/pages/history/cubit/history_cubit.dart';
import 'package:jupiter/src/presentation/pages/history/widgets/history_list_booking.dart';
import 'package:jupiter/src/presentation/pages/history/widgets/history_list_charging.dart';
import 'package:jupiter/src/presentation/pages/history/widgets/history_tab.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import '../../../firebase_log.dart';

class HistoryPageWrapperProvider extends StatelessWidget {
  const HistoryPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HistoryCubit>(),
      child: const HistoryPage(),
    );
  }
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  HistoryEntity? _historyEntity;
  HistoryBookingListEntity? historyBookingEntity;
  bool loadingPage = true;
  late TabController tabController;
  int selectedTab = 0;

  @override
  void initState() {
    FirebaseLog.logPage(this);
    initialTabController();
    super.initState();
    BlocProvider.of<HistoryCubit>(context).loadHistoryList();
  }

  void initialTabController() {
    tabController = TabController(vsync: this, length: 2);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        setState(() {
          selectedTab = tabController.index;
        });
        onChangeTab(tabController.index);
      }
    });
  }

  void onChangeTab(int index) {
    if (index == 0) {
      BlocProvider.of<HistoryCubit>(context).loadHistoryList();
    }
    if (index == 1) {
      BlocProvider.of<HistoryCubit>(context).fetchHistoryBooking();
    }
  }

  void actionHistoryLoadingStart() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingPage) {
        setState(() {
          loadingPage = true;
        });
      }
    });
  }

  void actionHistoryLoadingFailure() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
        });
      }
    });
  }

  void actionHistoryLoadingSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          _historyEntity = state.historyList;
          loadingPage = false;
          false;
        });
      }
    });
  }

  void actionHistoryBookingLoadingStart() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingPage) {
        setState(() {
          loadingPage = true;
        });
      }
    });
  }

  void actionHistoryBookingLoadingFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
        });
      }
    });
  }

  void actionHistoryBookingLoadingSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          historyBookingEntity = state.historyBookingList;
          loadingPage = false;
        });
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
        leading: const SizedBox(),
        centerTitle: true,
        title: TextLabel(
          text: translate("app_title.history"),
          color: AppTheme.blueDark,
          fontSize: Utilities.sizeFontWithDesityForDisplay(
              context, AppFontSize.title),
          fontWeight: FontWeight.w700,
        ),
      ),
      body: BlocBuilder<HistoryCubit, HistoryState>(builder: (context, state) {
        switch (state.runtimeType) {
          case HistoryLoadingStart:
            actionHistoryLoadingStart();
            break;
          case HistoryLoadingSuccess:
            actionHistoryLoadingSuccess(state);
            break;
          case HistoryLoadingFailure:
            actionHistoryLoadingFailure();
            break;
          case HistoryBookingLoadingStart:
            actionHistoryBookingLoadingStart();
            break;
          case HistoryBookingLoadingSuccess:
            actionHistoryBookingLoadingSuccess(state);
            break;
          case HistoryBookingLoadingFailure:
            actionHistoryBookingLoadingFailure(state);
            break;
        }
        return DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              Material(
                child: TabBar(
                  unselectedLabelColor: AppTheme.white,
                  indicatorColor: AppTheme.blueDark,
                  controller: tabController,
                  labelPadding: const EdgeInsets.all(0.0),
                  tabs: [
                    HistoryTab(
                      title: translate('history_page.type.charging'),
                      index: 0,
                      selectedTab: selectedTab,
                    ),
                    HistoryTab(
                      title: translate('history_page.type.booking'),
                      index: 1,
                      selectedTab: selectedTab,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                    HistoryListCharging(
                      historyEntity: _historyEntity,
                      loading: loadingPage,
                    ),
                    HistoryListBooking(
                      historyBookingEntity: historyBookingEntity,
                      loading: loadingPage,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
