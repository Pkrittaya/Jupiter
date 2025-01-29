import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/check_internet_signal.dart';
import 'package:jupiter_api/domain/entities/advertisement_entity.dart';
import 'package:jupiter_api/domain/entities/get_count_all_notification_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/home/cubit/advertisement_home_page_cubit.dart';
import 'package:jupiter/src/presentation/pages/home/cubit/notification_home_page_cubit.dart';
import 'package:jupiter/src/presentation/pages/home/widgets/page_image_indicator.dart';
import 'package:jupiter/src/presentation/pages/home/widgets/page_view_image.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:shimmer/shimmer.dart';

class AppBarHomePage extends StatefulWidget {
  AppBarHomePage({
    super.key,
    required this.activePage,
    required this.pageController,
    required this.onPageChanged,
    required this.onPressButtonNoti,
  });

  final int activePage;
  final PageController pageController;
  final Function(int) onPageChanged;
  final Function() onPressButtonNoti;

  @override
  State<AppBarHomePage> createState() => _AppBarHomePageState();
}

class _AppBarHomePageState extends State<AppBarHomePage> {
  CountAllNotificationEntity? notificationList;
  AdvertisementEntity? advertisementEntity;
  bool isLoadingNotification = false;
  bool isLoadingAdvertisement = false;

  @override
  void initState() {
    super.initState();
  }

  void actionNotificationHomePageLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isLoadingNotification) {
        setState(() {
          isLoadingNotification = true;
        });
      }
    });
  }

  void actionNotificationHomePageFailure() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoadingNotification) {
        setState(() {
          isLoadingNotification = false;
        });
      }
    });
  }

  void actionNotificationHomePageSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoadingNotification) {
        setState(() {
          notificationList = state.notificationList;
          isLoadingNotification = false;
        });
      }
    });
  }

  void actionAdvertisementHomePageLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isLoadingAdvertisement) {
        setState(() {
          isLoadingAdvertisement = true;
        });
      }
    });
  }

  void actionAdvertisementHomePageFailure() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoadingAdvertisement) {
        setState(() {
          isLoadingAdvertisement = false;
        });
      }
    });
  }

  void actionAdvertisementHomePageSuccess(state) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoadingAdvertisement) {
        setState(() {
          advertisementEntity = state.advertisementEntity;
        });
        isLoadingAdvertisement = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeMedia = MediaQuery.of(context).size;
    return Container(
      height: sizeMedia.height * 0.26,
      child: Stack(
        children: [
          Container(
            height: sizeMedia.height * 0.18,
            child: SvgPicture.asset(
              ImageAsset.bg_homepage,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.values.first,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 50, right: 16, left: 16),
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      ImageAsset.logo_jupiter,
                      width: 30,
                      height: 30,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      child: CheckInternetSignal(
                        sizeCircle: 30,
                        colorCircle: AppTheme.white.withOpacity(0.5),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    SizedBox.fromSize(
                      size: const Size(30, 30),
                      child: InkWell(
                        onTap: !isLoadingNotification
                            ? widget.onPressButtonNoti
                            : () {},
                        child: Stack(
                          children: [
                            ClipOval(
                              child: Material(
                                color: !isLoadingNotification
                                    ? AppTheme.white
                                    : AppTheme.black40,
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: SvgPicture.asset(
                                    ImageAsset.ic_notification,
                                    colorFilter: ColorFilter.mode(
                                        AppTheme.black, BlendMode.srcIn),
                                  ),
                                ),
                              ),
                            ),
                            BlocBuilder<NotificationHomePageCubit,
                                NotificationHomePageState>(
                              builder: (context, state) {
                                switch (state.runtimeType) {
                                  case NotificationHomePageLoading:
                                    actionNotificationHomePageLoading();
                                    break;
                                  case NotificationHomePageFailure:
                                    actionNotificationHomePageFailure();
                                    break;
                                  case NotificationHomePageSuccess:
                                    actionNotificationHomePageSuccess(state);
                                    break;
                                }
                                return ((notificationList?.numberReadStatus ??
                                                0) >
                                            0 &&
                                        !isLoadingNotification)
                                    ? Align(
                                        alignment: Alignment.topRight,
                                        child: CircleAvatar(
                                          backgroundColor: AppTheme.red80,
                                          radius: 9,
                                          child: TextLabel(
                                            text: ((notificationList
                                                            ?.numberReadStatus ??
                                                        0) >
                                                    99)
                                                ? '99+'
                                                : (notificationList
                                                            ?.numberReadStatus ??
                                                        0)
                                                    .toString(),
                                            color: AppTheme.white,
                                            fontSize: Utilities
                                                .sizeFontWithDesityForDisplay(
                                                    context, AppFontSize.mini),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    : SizedBox.shrink();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          BlocBuilder<AdvertisementHomePageCubit, AdvertisementHomePageState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case AdvertisementHomePageLoading:
                  actionAdvertisementHomePageLoading();
                  break;
                case AdvertisementHomePageFailure:
                  actionAdvertisementHomePageFailure();
                  break;
                case AdvertisementHomePageSuccess:
                  actionAdvertisementHomePageSuccess(state);
                  break;
              }
              return Align(
                alignment: Alignment.bottomCenter,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: !isLoadingAdvertisement
                          ? PageViewImage(
                              pageController: widget.pageController,
                              onPageChanged: widget.onPageChanged,
                              activePage: widget.activePage,
                              imageList: advertisementEntity?.announcement ??
                                  List.empty(growable: true),
                            )
                          : Container(
                              padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                height: sizeMedia.height * 0.13,
                                child: Shimmer.fromColors(
                                  baseColor: AppTheme.grayF1F5F9,
                                  highlightColor: AppTheme.borderGray,
                                  child: Container(
                                    height: 20,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: !isLoadingAdvertisement
                          ? Container(
                              color: AppTheme.transparent,
                              padding: const EdgeInsets.fromLTRB(24, 0, 0, 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  PageImageIndicator(
                                    imageList:
                                        advertisementEntity?.announcement ??
                                            List.empty(growable: true),
                                    pageController: widget.pageController,
                                    activePage: widget.activePage,
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
