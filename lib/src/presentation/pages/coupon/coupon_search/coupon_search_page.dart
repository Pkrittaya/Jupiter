import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/unfocus_area.dart';
import 'package:jupiter_api/domain/entities/search_coupon_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/coupon/coupon_search/cubit/coupon_search_cubit.dart';
import 'package:jupiter/src/presentation/pages/coupon/coupon_search/widgets/coupon_item.dart';
import 'package:jupiter/src/presentation/pages/coupon/coupon_search/widgets/coupon_search_appbar.dart';
import 'package:jupiter/src/presentation/pages/coupon_detail/coupon_detail_page.dart';
import 'package:jupiter/src/presentation/widgets/button_close_keyboard.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import '../../../../firebase_log.dart';

class CouponSearchPage extends StatefulWidget {
  const CouponSearchPage({super.key});

  @override
  State<CouponSearchPage> createState() => _CouponSearchPageState();
}

class _CouponSearchPageState extends State<CouponSearchPage> {
  TextEditingController controllerTextSearch = TextEditingController();
  SearchCouponItemEntity? couponItem;
  bool isCollect = false;
  FocusNode focus = FocusNode();
  DateTime? datenull;
  bool loadingData = false;
  bool loadingVisible = true;
  List<SearchCouponItemEntity> listCoupon = List.empty(growable: true);
  Timer? _debounce;

  @override
  void initState() {
    FirebaseLog.logPage(this);
    super.initState();
    BlocProvider.of<CouponSearchCubit>(context).loadCouponSearch();
  }

  getDateFormat(SearchCouponItemEntity data) {
    String day = '';
    String yMMM = '';
    if (data.dateEnd != "") {
      DateTime date = DateTime.parse(data.dateEnd).toLocal();
      day = DateFormat('d').format(date);
      yMMM = DateFormat('yMMM').format(date);
    } else {
      day =
          '${data.expiredDate} ${translate("check_in_page.modal_offers.day_after_collected")}';
    }
    return '${translate("check_in_page.modal_offers.expire_date")} $day $yMMM';
  }

  void onPressedBackButton() {
    Navigator.of(context).pop();
  }

  void onPressedClearTextInput() {
    controllerTextSearch.text = '';
    couponItem = null;
    focus.unfocus();

    setState(() {});
  }

  void getListSearch(String text) {
    int searchCoupon = listCoupon.indexWhere(
        (item) => item.couponCode.toLowerCase() == text.toLowerCase());
    if (searchCoupon >= 0) {
      couponItem = listCoupon[searchCoupon];
      isCollect = (couponItem!.dateAdd != '') ? true : false;
    } else {
      couponItem = null;
    }
  }

  void onChangTextInput(String text) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      BlocProvider.of<CouponSearchCubit>(context).loadCouponSearch();
    });
  }

  void onTapIsCollect(SearchCouponItemEntity? data) {
    if (data != null) {
      BlocProvider.of<CouponSearchCubit>(context)
          .collectCoupon(couponCode: data.couponCode);
    }
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
          listCoupon = couponEntity;
          loadingVisible = false;
        });
        getListSearch(controllerTextSearch.text);
      }
    });

    // onChangTextInput(controllerTextSearch.text);
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

  void actionCollectCouponLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingVisible) {
        setState(() {
          loadingVisible = true;
        });
      }
    });
  }

  void actionCollectCouponFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingVisible) {
        // Utilities.alertOneButtonAction(
        //   context: context,
        //   type: AppAlertType.DEFAULT,
        //   isForce: true,
        //   title: translate('check_in_page.modal_offers.title_alert'),
        //   description: state.message ?? '',
        //   textButton: translate('button.try_again'),
        //   onPressButton: () {
        //     Navigator.of(context).pop();
        //   },
        // );
        Utilities.alertAfterSaveAction(
            context: context,
            type: AppAlertType.WARNING,
            time: 5,
            text: state.message ??
                translate('alert_after_save.save_failure.coupon'));
        setState(() {
          loadingVisible = false;
        });
      }
    });
  }

  void actionCollectCouponSuccess() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingVisible) {
        Utilities.alertAfterSaveAction(
            context: context,
            type: AppAlertType.SUCCESS,
            text: translate('alert_after_save.save_success.coupon'));
        FocusScope.of(context).unfocus();
        Navigator.of(context).pop();
        setState(() {
          isCollect = true;
          loadingVisible = false;
        });
      }
    });
  }

  Future<void> onTapCouponItem(context, SearchCouponItemEntity? data) async {
    if (data != null) {
      FocusScope.of(context).unfocus();
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CouponDetailPage(
            couponID: data.couponCode,
          ),
        ),
      );
      listCoupon.clear();
      BlocProvider.of<CouponSearchCubit>(context).loadCouponSearch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return UnfocusArea(
      child: Stack(
        children: [
          Scaffold(
            body: Stack(
              children: [
                NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowIndicator();
                    return true;
                  },
                  child: SingleChildScrollView(
                    child: Container(
                      child: BlocBuilder<CouponSearchCubit, CouponSearchState>(
                        builder: (context, state) {
                          switch (state.runtimeType) {
                            case CouponSearchLoading:
                              actionCouponSearchLoading();
                              break;
                            case CouponSearchSuccess:
                              actionCouponSearchSuccess(state.couponSearch);
                              break;
                            case CouponSearchFailure:
                              actionCouponSearchFailure();
                              break;
                            case CollectCouponLoading:
                              actionCollectCouponLoading();
                              break;
                            case CollectCouponSuccess:
                              actionCollectCouponSuccess();
                              break;
                            case CollectCouponFailure:
                              actionCollectCouponFailure(state);
                              break;
                            default:
                              break;
                          }
                          return Column(
                            children: [
                              CouponSearchAppbar(
                                focus: focus,
                                onPressedBackButton: onPressedBackButton,
                                controllerTextSearch: controllerTextSearch,
                                onPressedClearTextInput:
                                    onPressedClearTextInput,
                                onChangTextInput: onChangTextInput,
                              ),
                              Container(color: AppTheme.grayF1F5F9, height: 12),
                              renderListCouponSearch(),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).viewInsets.bottom > 0
                                        ? 40
                                        : 0,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                ButtonCloseKeyboard(contextPage: context),
              ],
            ),
          ),
          // LoadingPage(visible: loadingVisible)
        ],
      ),
    );
  }

  Widget renderListCouponSearch() {
    if (couponItem != null && !loadingVisible) {
      return Container(
        padding:
            const EdgeInsets.only(top: 16, left: 12, right: 12, bottom: 16),
        color: AppTheme.white,
        child: CouponItem(
          data: couponItem,
          isCollect: isCollect,
          onTapCouponItem: onTapCouponItem,
          onTapIsCollect: onTapIsCollect,
        ),
      );
    } else if (loadingVisible) {
      return Container();
    } else {
      return Container(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageAsset.img_coupon_empty,
              width: 130,
              height: 130,
            ),
            SizedBox(height: 8),
            TextLabel(
              text: translate('empty.coupon'),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.superlarge),
              color: AppTheme.black40,
            )
          ],
        ),
      );
    }
  }
}
