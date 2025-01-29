import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/image_network_jupiter.dart';
import 'package:jupiter_api/domain/entities/coupon_detail_entity.dart';
import 'package:jupiter/src/presentation/pages/coupon/coupon_list/cubit/coupon_cubit.dart';
import 'package:jupiter/src/presentation/pages/coupon_detail/cubit/coupon_detail_cubit.dart';
import 'package:jupiter/src/presentation/widgets/button.dart';
import 'package:jupiter/src/presentation/widgets/loading_page.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import '../../../firebase_log.dart';

// ignore: must_be_immutable
class CouponDetailPage extends StatefulWidget {
  CouponDetailPage({
    Key? key,
    required this.couponID,
    this.bottomBar = '',
    this.onSelectCouponOffer,
    this.selectCoupon = '',
  }) : super(key: key);

  final String couponID;
  final String bottomBar;
  final Function(String, bool)? onSelectCouponOffer;
  String selectCoupon;

  @override
  State<CouponDetailPage> createState() => _CouponDetailPageState();
}

class _CouponDetailPageState extends State<CouponDetailPage> {
  CouponDetailEntity? couponItem;
  bool isCollect = false;
  bool isUse = false;
  bool loadingData = false;
  bool loadingVisible = true;
  bool loadingPage = true;

  getDateFormat(CouponDetailEntity data) {
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

  void onTapIsCollect(CouponDetailEntity data) {
    // isCollect = true;
    // setState(() {});
    BlocProvider.of<CouponDetailCubit>(context)
        .collectCoupon(couponCode: data.couponCode);
  }

  void onTapIsuse(CouponDetailEntity data) {
    if (isUse == false) {
      // isUse = true;
      widget.onSelectCouponOffer!(data.couponCode, true);
      widget.selectCoupon = data.couponCode;
    } else {
      // isUse = false;
      widget.onSelectCouponOffer!(data.couponCode, false);
      widget.selectCoupon = '';
    }
    Navigator.of(context).pop();
    setState(() {});
  }

  void actionCouponDetailLoading() {}

  void actionCouponDetailSuccess(couponDetailEntity) {
    couponItem = couponDetailEntity;
    if (couponItem!.dateAdd == '') {
      isCollect = false;
    } else {
      isCollect = true;
    }
    loadingData = true;
    loadingVisible = false;
    if (couponItem!.couponCode == widget.selectCoupon) {
      isUse = true;
    }
  }

  void actionCouponDetailFailure() {}

  void actionCollectCouponLoading() {}

  void actionCollectCouponFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
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
        BlocProvider.of<CouponCubit>(context).loadMyCoupon();
        setState(() {
          loadingPage = false;
        });
      }
    });
    BlocProvider.of<CouponCubit>(context).loadMyCoupon();
  }

  void actionCollectCouponSuccess(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        isCollect = true;
        Utilities.alertAfterSaveAction(
            context: context,
            type: AppAlertType.SUCCESS,
            text: translate('alert_after_save.save_success.coupon'));
        BlocProvider.of<CouponCubit>(context).loadMyCoupon();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        setState(() {
          loadingPage = false;
        });
      }
    });
  }

  @override
  void initState() {
    FirebaseLog.logPage(this);
    super.initState();
    BlocProvider.of<CouponDetailCubit>(context)
        .loadCouponDetail(couponCode: widget.couponID);
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
            onPressed: () {
              Navigator.of(context).pop();
            }),
        centerTitle: true,
        title: TextLabel(
          text: translate('app_title.coupon'),
          color: AppTheme.blueDark,
          fontSize: Utilities.sizeFontWithDesityForDisplay(
              context, AppFontSize.title),
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Container(child: BlocBuilder<CouponDetailCubit, CouponDetailState>(
          builder: (context, state) {
        switch (state.runtimeType) {
          case CouponDetailLoading:
            actionCouponDetailLoading();
            break;
          case CouponDetailSuccess:
            actionCouponDetailSuccess(state.couponDetailEntity);
            break;
          case CouponDetailFailure:
            actionCouponDetailFailure();
            break;
          case CollectCouponLoading:
            actionCollectCouponLoading();
            break;
          case CollectCouponSuccess:
            actionCollectCouponSuccess(context);
            break;
          case CollectCouponFailure:
            actionCollectCouponFailure(state);
            break;
          default:
            break;
        }
        return loadingData
            ? Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ImageNetworkJupiter(
                          url: couponItem!.couponImage,
                          width: MediaQuery.of(context).size.width,
                          heightLoading:
                              MediaQuery.of(context).size.height * 0.35,
                          fit: BoxFit.values.first,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: TextLabel(
                                  text: '${couponItem!.couponName}',
                                  fontSize:
                                      Utilities.sizeFontWithDesityForDisplay(
                                    context,
                                    AppFontSize.large,
                                  ),
                                  color: AppTheme.blueDark,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: TextLabel(
                                  text: '${getDateFormat(couponItem!)}',
                                  fontSize:
                                      Utilities.sizeFontWithDesityForDisplay(
                                    context,
                                    AppFontSize.normal,
                                  ),
                                  color: AppTheme.blueDark,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: TextLabel(
                                  text: couponItem!.description,
                                  fontSize:
                                      Utilities.sizeFontWithDesityForDisplay(
                                    context,
                                    AppFontSize.small,
                                  ),
                                  color: AppTheme.gray9CA3AF,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                  (couponItem!.statusUsedCoupon == false &&
                          widget.bottomBar == '')
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            color: AppTheme.white,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.11,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 20),
                            child: Button(
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                shadowColor: Colors.transparent,
                                backgroundColor: isCollect
                                    ? AppTheme.grayD1D5DB
                                    : AppTheme.blueD,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(200)),
                                ),
                              ),
                              text: isCollect
                                  ? translate('coupon_detail.button.collected')
                                  : translate('coupon_detail.button.collect'),
                              onPressed: () {
                                if (!isCollect) {
                                  onTapIsCollect(couponItem!);
                                }
                              },
                              textColor:
                                  isCollect ? AppTheme.black : AppTheme.white,
                            ),
                          ),
                        )
                      : SizedBox(),
                  (widget.bottomBar != '')
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            color: AppTheme.white,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.11,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 20),
                            child: Button(
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                shadowColor: Colors.transparent,
                                backgroundColor:
                                    isUse ? AppTheme.red : AppTheme.blueD,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(200)),
                                ),
                              ),
                              text: isUse
                                  ? translate('coupon_detail.button.use_later')
                                  : translate('coupon_detail.button.use_now'),
                              onPressed: () {
                                onTapIsuse(couponItem!);
                              },
                              textColor: AppTheme.white,
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              )
            : LoadingPage(visible: loadingVisible);
      })),
    );
  }
}
