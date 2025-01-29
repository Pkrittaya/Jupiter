import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/config/api/api_firebase.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/firebase_log.dart';
import 'package:jupiter/src/presentation/pages/notification/cubit/notification_cubit.dart';
import 'package:jupiter/src/presentation/pages/notification_detail/cubit/notification_detail_cubit.dart';
import 'package:jupiter/src/presentation/pages/notification_detail/widgets/coupon_detail.dart';
import 'package:jupiter/src/presentation/pages/notification_detail/widgets/news_detail.dart';
import 'package:jupiter/src/presentation/pages/notification_detail/widgets/system_detail.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/domain/entities/coupon_detail_entity.dart';
import 'package:jupiter_api/domain/entities/notification_data_news_entity.dart';
import 'package:jupiter_api/domain/entities/notification_entity.dart';

class NotificationDetailPage extends StatefulWidget {
  const NotificationDetailPage(
      {super.key,
      required this.tapType,
      required this.notiType,
      required this.notificationId,
      this.dataSystem,
      this.dataNews,
      this.couponCode});

  final String tapType;
  final String notiType;
  final int notificationId;
  final NotiEntity? dataSystem;
  final NotificationNewsDataEntity? dataNews;
  final String? couponCode;

  @override
  State<NotificationDetailPage> createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
  bool loadingPage = true;
  CouponDetailEntity? couponData;

  @override
  void initState() {
    FirebaseLog.logPage(this);
    initialTabController();
    super.initState();
  }

  void initialTabController() {
    switch (widget.notiType) {
      case NotificationType.SYSTEMS:
        break;
      case NotificationType.NEWS:
        break;
      case NotificationType.PROMOTION:
        onloadCouponDetail();
        break;
      default:
        break;
    }
  }

  void onloadCouponDetail() {
    BlocProvider.of<NotificationDetailCubit>(context)
        .loadCouponDetail(couponCode: widget.couponCode ?? '');
  }

  void onPressedDeleteButton(int id) {
    ApiFirebase().clearNotificationFromID(id);
    try {
      BlocProvider.of<NotiCubit>(context).deleteNotification(
          notificationOperator: 'Partial',
          notificationIndex: id,
          notificationType: widget.notiType);
      onPressedBackButton(context);
    } catch (e) {
      BlocProvider.of<NotiCubit>(context).resetStateInitial();
    }
  }

  void onPressedBackButton(BuildContext context) {
    Navigator.of(context).pop();
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
            color: AppTheme.blueDark,
          ),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppTheme.blueDark),
              onPressed: () {
                onPressedBackButton(context);
              }),
          centerTitle: true,
          title: TextLabel(
            text: widget.notiType == NotificationType.SYSTEMS
                ? translate('notification_page.systems')
                : translate('notification_page.news'),
            color: AppTheme.blueDark,
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.title),
            fontWeight: FontWeight.w700,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // actions: [
          //   Container(
          //       margin: const EdgeInsets.only(right: 15),
          //       child: SizedBox(
          //         height: 35,
          //         width: 35,
          //         child: ElevatedButton(
          //           onPressed: () =>
          //               onPressedDeleteButton(widget.notificationId),
          //           style: ElevatedButton.styleFrom(
          //             shape: CircleBorder(),
          //             backgroundColor: AppTheme.red,
          //             padding: EdgeInsets.all(5),
          //           ),
          //           child: const Icon(
          //             Icons.delete,
          //             color: AppTheme.white,
          //             size: 18,
          //           ),
          //         ),
          //       )),
          // ],
        ),
        body: renderDetail(context));
  }

  Widget renderDetail(BuildContext context) {
    switch (widget.notiType) {
      case NotificationType.SYSTEMS:
        return SystemDetail(
          data: widget.dataSystem,
        );
      case NotificationType.NEWS:
        return NewsDetail(
          data: widget.dataNews,
        );
      case NotificationType.PROMOTION:
        return CouponDetail();
      default:
        return const SizedBox.shrink();
    }
  }
}
