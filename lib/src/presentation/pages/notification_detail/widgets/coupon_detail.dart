import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/pages/notification/cubit/notification_cubit.dart';
import 'package:jupiter/src/presentation/pages/notification_detail/cubit/notification_detail_cubit.dart';
import 'package:jupiter/src/presentation/widgets/button.dart';
import 'package:jupiter/src/presentation/widgets/image_network_jupiter.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/domain/entities/coupon_detail_entity.dart';

class CouponDetail extends StatefulWidget {
  const CouponDetail({super.key});

  @override
  State<CouponDetail> createState() => _CouponDetailState();
}

class _CouponDetailState extends State<CouponDetail> {
  bool loadingPage = true;
  CouponDetailEntity? couponData;
  bool isCollect = false;
  bool isUse = false;

  String getDateFormat(String dateFromApi) {
    try {
      if (dateFromApi != '') {
        // DateFormat inputFormat = DateFormat('yyyy/MM/dd HH:mm:ss');
        DateTime dateTime = DateTime.parse(dateFromApi);
        DateFormat outputFormat = DateFormat('dd MMM yyyy HH:mm');
        String outputDate = outputFormat.format(dateTime.toLocal());
        return outputDate; // Output: 20 Jun 2023
      }
      return dateFromApi;
    } catch (e) {
      return dateFromApi;
    }
  }

  String getDateExpireCouponFormat(
      {required String dateEnd, required int expiredDate}) {
    String day = '';
    String yMMM = '';
    if (dateEnd != "") {
      DateTime date = DateTime.parse(dateEnd).toLocal();
      day = DateFormat('d').format(date);
      yMMM = DateFormat('yMMM').format(date);
    } else {
      day =
          '${expiredDate} ${translate("check_in_page.modal_offers.day_after_collected")}';
    }
    return '${translate("check_in_page.modal_offers.expire_date")} $day $yMMM';
  }

  void onPressedActionCoupon(String code) {
    if (!isCollect) {
      BlocProvider.of<NotificationDetailCubit>(context)
          .collectCoupon(couponCode: code);

      /// test
      // setState(() {
      //   loadingPage = false;
      //   isCollect = true;
      // });
      // Utilities.alertAfterSaveAction(
      //     context: context,
      //     type: AppAlertType.SUCCESS,
      //     text: translate('alert_after_save.save_success.coupon'));
    }
  }

  void actionCouponDetailLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingPage) {
        setState(() {
          loadingPage = true;
        });
      }
    });
  }

  void actionCouponDetailSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        couponData = state.couponDetailEntity;
        isCollect = (couponData?.dateAdd != '') ? true : false;
        isUse = couponData?.statusUsedCoupon ?? false;
        setState(() {
          loadingPage = false;
        });
      }
    });
  }

  void actionCouponDetailFailure(state) {
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
        BlocProvider.of<NotiCubit>(context).resetStateInitial();
      }
    });
  }

  void actionCollectCouponSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
          isCollect = true;
        });
        Utilities.alertAfterSaveAction(
            context: context,
            type: AppAlertType.SUCCESS,
            text: translate('alert_after_save.save_success.coupon'));
      }
    });
  }

  void actionCollectCouponFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
        });
        Utilities.alertAfterSaveAction(
            context: context,
            type: AppAlertType.WARNING,
            time: 5,
            text: state.message ??
                translate('alert_after_save.save_failure.coupon'));
        BlocProvider.of<NotiCubit>(context).resetStateInitial();
      }
    });
  }

  void actionHomeResetCubit() {
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
    return BlocBuilder<NotificationDetailCubit, NotificationDetailState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case CouponDetailLoading:
            actionCouponDetailLoading();
            break;
          case CouponDetailSuccess:
            actionCouponDetailSuccess(state);
            break;
          case CouponDetailFailure:
            actionCouponDetailFailure(state);
            break;
          case CollectCouponSuccess:
            actionCollectCouponSuccess(state);
            break;
          case CollectCouponFailure:
            actionCollectCouponFailure(state);
            break;
          case CouponDetailInitial:
            actionHomeResetCubit();
            break;
        }
        return Stack(
          children: [
            NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageNetworkJupiter(
                      url: couponData?.couponImage ?? '',
                      width: MediaQuery.of(context).size.width,
                      heightLoading: MediaQuery.of(context).size.height * 0.35,
                      fit: BoxFit.cover,
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextLabel(
                              text: couponData?.couponName ?? '',
                              color: AppTheme.blueDark,
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.title),
                              fontWeight: FontWeight.w700,
                              // maxLines: 1,
                              // overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // TextLabel(
                            //   text: getDateFormat(''),
                            //   color: AppTheme.gray9CA3AF,
                            //   fontSize: Utilities.sizeFontWithDesityForDisplay(
                            //       context, AppFontSize.normal),
                            //   maxLines: 1,
                            //   overflow: TextOverflow.ellipsis,
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: TextLabel(
                                text:
                                    '${getDateExpireCouponFormat(dateEnd: couponData?.dateEnd ?? '', expiredDate: couponData?.expiredDate ?? 0)}',
                                fontSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                  context,
                                  AppFontSize.normal,
                                ),
                                color: AppTheme.blueDark,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextLabel(
                              text: couponData?.description ?? '',
                              color: AppTheme.gray9CA3AF,
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.big),
                              // maxLines: 1,
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.11,
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: (couponData != null),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: AppTheme.white,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.11,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Button(
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      shadowColor: Colors.transparent,
                      backgroundColor:
                          isCollect ? AppTheme.grayD1D5DB : AppTheme.blueD,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(200)),
                      ),
                    ),
                    text: isCollect
                        ? isUse
                            ? translate(
                                'notification_page.notification_detail.use_coupon')
                            : translate('coupon_detail.button.collected')
                        : translate('coupon_detail.button.collect'),
                    onPressed: () =>
                        onPressedActionCoupon(couponData?.couponCode ?? ''),
                    textColor: isCollect ? AppTheme.black : AppTheme.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
