import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/coupon_entity.dart';
import 'package:jupiter_api/domain/entities/search_coupon_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/coupon/coupon_list/cubit/coupon_cubit.dart';
import 'package:jupiter/src/presentation/pages/coupon/coupon_list/widgets/coupon_list_active.dart';
import 'package:jupiter/src/presentation/pages/coupon/coupon_list/widgets/coupon_list_used.dart';
import 'package:jupiter/src/presentation/pages/coupon/coupon_list/widgets/coupon_tab.dart';
import 'package:jupiter/src/presentation/pages/coupon/coupon_search/coupon_search_page.dart';
import 'package:jupiter/src/presentation/pages/coupon/coupon_list/widgets/coupon_scan_qrcode_page.dart';
import 'package:jupiter/src/presentation/pages/coupon_detail/coupon_detail_page.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';
import '../../../../firebase_log.dart';
class CouponPage extends StatefulWidget {
  const CouponPage({super.key});
  @override
  State<CouponPage> createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage>
    with SingleTickerProviderStateMixin {
  List<CouponItemEntity>? myCoupon = List.empty(growable: true);
  List<CouponItemEntity>? usedCoupon = List.empty(growable: true);
  List<SearchCouponItemEntity>? searchCoupon = List.empty(growable: true);
  late TabController _tabController;
  int _selectedTab = 0;
  bool loadingVisible = true;

  @override
  void initState() {
    FirebaseLog.logPage(this);
    initialTabController();
    super.initState();
    BlocProvider.of<CouponCubit>(context).loadMyCoupon();
  }

  void initialTabController() {
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _selectedTab = _tabController.index;
        });
      }
    });
  }

  void onPressedBackButton() {
    Navigator.of(context).pop();
  }

  getDateFormat(DateTime date) {
    date = date.toLocal();
    return '${translate("check_in_page.modal_offers.expire_date")} ${DateFormat('d').format(date)} ${DateFormat('yMMM').format(date)}';
  }

  void onClickScanQR() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ScanQRCodeCouponPage(listItemCollect: searchCoupon!)),
    );
  }

  Future<void> onPressedCouponSearch(context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CouponSearchPage()),
    );
    myCoupon!.clear();
    usedCoupon!.clear();
    BlocProvider.of<CouponCubit>(context).loadMyCoupon();
  }

  void onTapCouponDetail(context, CouponItemEntity data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CouponDetailPage(
          couponID: data.couponCode,
        ),
      ),
    );
  }

  void actionCouponLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingVisible) {
        setState(() {
          loadingVisible = true;
        });
      }
    });
  }

  void actionMyCouponFailure() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingVisible) {
        setState(() {
          loadingVisible = false;
        });
      }
    });
  }

  void actionMyCouponSuccess(couponEntity) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingVisible) {
        setState(() {
          myCoupon = couponEntity;
        });
      }
    });
    BlocProvider.of<CouponCubit>(context).loadUsedCoupon();
  }

  void actionUsedCouponSuccess(couponEntity) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingVisible) {
        setState(() {
          usedCoupon = couponEntity;
        });
      }
    });
    BlocProvider.of<CouponCubit>(context).loadCouponSearch();
  }

  void actionUsedCouponFailure() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingVisible) {
        setState(() {
          loadingVisible = false;
        });
      }
    });
  }

  void actionCouponSearchLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingVisible) {
        setState(() {
          loadingVisible = true;
        });
      }
    });
  }

  void actionCouponSearchSuccess(couponEntity) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingVisible) {
        setState(() {
          searchCoupon = couponEntity;
          loadingVisible = false;
        });
      }
    });
  }

  void actionCouponSearchFailure() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingVisible) {
        setState(() {
          loadingVisible = false;
        });
      }
    });
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
          text: translate('app_title.coupon'),
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
                onClickScanQR();
              },
              child: Container(
                child: SvgPicture.asset(
                  ImageAsset.ic_qr_code,
                  width: 20,
                  colorFilter:
                      ColorFilter.mode(AppTheme.blueDark, BlendMode.srcIn),
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: BlocBuilder<CouponCubit, CouponState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case CouponLoading:
                actionCouponLoading();
                break;
              case MyCouponSuccess:
                actionMyCouponSuccess(state.couponEntity);
                break;
              case MyCouponFailure:
                actionMyCouponFailure();
                break;
              case UsedCouponSuccess:
                actionUsedCouponSuccess(state.couponEntity);
                break;
              case UsedCouponFailure:
                actionUsedCouponFailure();
                break;
              case CouponSearchLoading:
                actionCouponSearchLoading();
                break;
              case CouponSearchSuccess:
                actionCouponSearchSuccess(state.couponSearch);
                break;
              case CouponSearchFailure:
                actionCouponSearchFailure();
                break;
              default:
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
                      controller: _tabController,
                      labelPadding: const EdgeInsets.all(0.0),
                      tabs: [
                        CouponTab(
                          title: translate('coupon.coupon_list.active_coupon'),
                          index: 0,
                          selectedTab: _selectedTab,
                        ),
                        CouponTab(
                          title: translate('coupon.coupon_list.used_coupon'),
                          index: 1,
                          selectedTab: _selectedTab,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        CouponListActive(
                          myCoupon: myCoupon,
                          onPressedCouponSearch: onPressedCouponSearch,
                          onTapCouponDetail: onTapCouponDetail,
                          getDateFormat: getDateFormat,
                          loading: loadingVisible,
                        ),
                        CouponListUsed(
                          usedCoupon: usedCoupon,
                          getDateFormat: getDateFormat,
                          loading: loadingVisible,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
