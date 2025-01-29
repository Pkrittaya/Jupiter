import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/config/api/api_firebase.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/pages/notification/widgets/noti_item_news.dart';
import 'package:jupiter/src/presentation/pages/notification/widgets/notification_tab.dart';
import 'package:jupiter/src/presentation/pages/notification_detail/notification_detail.dart';
import 'package:jupiter_api/domain/entities/list_notification_entity.dart';
import 'package:jupiter_api/domain/entities/notification_data_news_entity.dart';
import 'package:jupiter_api/domain/entities/notification_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/home/cubit/notification_home_page_cubit.dart';
import 'package:jupiter/src/presentation/pages/notification/cubit/notification_cubit.dart';
import 'package:jupiter/src/presentation/pages/notification/widgets/modal_bottom_delete_notification.dart';
import 'package:jupiter/src/presentation/pages/notification/widgets/noti_item.dart';

import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/domain/entities/notification_news.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../firebase_log.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  bool loadingPage = false;
  ListNotificationEntity? notificationList;
  NotificationNewsEntity? notificationNewsList;
  List<NotiEntity> listDataSystem = List.empty(growable: true);
  List<NotificationNewsDataEntity> listDataNews = List.empty(growable: true);
  bool notiRead = false;
  late TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    FirebaseLog.logPage(this);
    initialTabController();
    loadNotificationNews();
    super.initState();
  }

  bool countListNoti() {
    if (_selectedTab == 0) {
      return listDataNews.length > 0;
    } else if (_selectedTab == 1) {
      return listDataSystem.length > 0;
    } else {
      return false;
    }
  }

  void initialTabController() {
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _selectedTab = _tabController.index;
        });
        if (_tabController.index == 0) {
          loadNotificationNews();
        } else if (_tabController.index == 1) {
          loadNotificationSystem();
        }
      }
    });
  }

  void loadNotificationSystem() {
    try {
      BlocProvider.of<NotiCubit>(context).loadNotificationList();
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (loadingPage) {
          setState(() {
            loadingPage = false;
          });
          BlocProvider.of<NotiCubit>(context).resetStateInitial();
        }
      });
    }
  }

  void loadNotificationNews() {
    try {
      BlocProvider.of<NotiCubit>(context).loadNotificationNewsList();
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (loadingPage) {
          setState(() {
            loadingPage = false;
          });
          BlocProvider.of<NotiCubit>(context).resetStateInitial();
        }
      });
    }
  }

  void getNotificationListHomePage() {
    BlocProvider.of<NotificationHomePageCubit>(context)
        .loadCountAllNotificaton();
  }

  void onPressedBackButton() {
    getNotificationListHomePage();
    Navigator.of(context).pop();
  }

  void onPressedClearNotification() {
    ApiFirebase().clearAllNotification();
    Navigator.of(context).pop();
    try {
      BlocProvider.of<NotiCubit>(context).deleteNotification(
          notificationOperator: 'All',
          notificationIndex: 18249,
          notificationType: (_selectedTab == 0)
              ? NotificationType.NEWS
              : NotificationType.SYSTEMS);
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (loadingPage) {
          setState(() {
            loadingPage = false;
          });
          BlocProvider.of<NotiCubit>(context).resetStateInitial();
        }
      });
    }
  }

  void onCloseModal() {
    Navigator.of(context).pop();
  }

  void onSlideDelete(int id, String type) {
    ApiFirebase().clearNotificationFromID(id);
    try {
      BlocProvider.of<NotiCubit>(context).deleteNotification(
          notificationOperator: 'Partial',
          notificationIndex: id,
          notificationType: type);
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (loadingPage) {
          setState(() {
            loadingPage = false;
          });
          BlocProvider.of<NotiCubit>(context).resetStateInitial();
        }
      });
    }
  }

  void onPressedNotificationDetail(
      {required int id,
      NotiEntity? data,
      NotificationNewsDataEntity? dataNews}) {
    if (_selectedTab == 0) {
      if (!(dataNews?.statusRead ?? false)) {
        try {
          ApiFirebase().clearNotificationFromID(id);
          BlocProvider.of<NotiCubit>(context).activeNotification(
              notificationIndex: id,
              notificationType: dataNews?.messageType ?? '');
        } catch (e) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (loadingPage) {
              setState(() {
                loadingPage = false;
              });
              BlocProvider.of<NotiCubit>(context).resetStateInitial();
            }
          });
        }
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationDetailPage(
            tapType: NotificationType.NEWS,
            notiType: dataNews?.messageType ?? '',
            notificationId: id,
            dataNews: dataNews,
            couponCode: dataNews?.messageData,
          ),
        ),
      );
    } else {
      if (!(data?.notification.readStatus ?? false)) {
        try {
          ApiFirebase().clearNotificationFromID(id);
          BlocProvider.of<NotiCubit>(context).activeNotification(
              notificationIndex: id,
              notificationType: NotificationType.SYSTEMS);
        } catch (e) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (loadingPage) {
              setState(() {
                loadingPage = false;
              });
              BlocProvider.of<NotiCubit>(context).resetStateInitial();
            }
          });
        }
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationDetailPage(
            tapType: NotificationType.SYSTEMS,
            notiType: NotificationType.SYSTEMS,
            notificationId: id,
            dataSystem: data,
          ),
        ),
      );
    }
  }

  void actionNotiLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingPage) {
        setState(() {
          loadingPage = true;
        });
      }
    });
  }

  void actionNotiSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          notificationList = state.notificationList;
          listDataSystem = notificationList?.dataNotification ?? [];
          loadingPage = false;
        });
        BlocProvider.of<NotiCubit>(context).resetStateInitial();
      }
    });
  }

  void actionNotiFailure(state) {
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

  void actionNotiNewsSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          notificationNewsList = state.notificationNewsList;
          listDataNews = notificationNewsList?.dataNotification ?? [];
          loadingPage = false;
        });
        BlocProvider.of<NotiCubit>(context).resetStateInitial();
      }
    });
  }

  void actionNotiNewsFailure(state) {
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

  void actionDeleteNotiLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingPage) {
        setState(() {
          loadingPage = true;
        });
      }
    });
  }

  void actionDeleteNotiSuccess() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
        });
        if (_selectedTab == 0) {
          loadNotificationNews();
        } else {
          loadNotificationSystem();
        }
      }
    });
  }

  void actionDeleteNotiFailure(state) {
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

  void actionActiveNotiSuccess() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
        });
        if (_selectedTab == 0) {
          loadNotificationNews();
        } else {
          loadNotificationSystem();
        }
      }
    });
  }

  void actionActiveNotiFailure(state) {
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
            onPressed: onPressedBackButton),
        centerTitle: true,
        title: TextLabel(
          text: translate('app_title.notification'),
          color: AppTheme.blueDark,
          fontSize: Utilities.sizeFontWithDesityForDisplay(
              context, AppFontSize.title),
          fontWeight: FontWeight.w700,
        ),
        actions: [
          (_selectedTab == 0)
              ? Container(
                  margin: const EdgeInsets.only(right: 4),
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: countListNoti()
                          ? AppTheme.blueDark
                          : AppTheme.blueDark.withOpacity(0.3),
                    ),
                    onPressed: () {
                      countListNoti()
                          ? showModalBottomSheet(
                              context: context,
                              enableDrag: true,
                              isDismissible: true,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(12))),
                              builder: (BuildContext context) {
                                return ModalBottomDeleteNotification(
                                  onPressedRemove: onPressedClearNotification,
                                  onCloseModal: onCloseModal,
                                );
                              },
                            )
                          : ();
                    },
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
      body: Container(
        child: BlocBuilder<NotiCubit, NotiState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case NotiLoading:
                actionNotiLoading();
                break;
              case NotiSuccess:
                actionNotiSuccess(state);
                break;
              case NotiFailure:
                actionNotiFailure(state);
                break;
              case NotiNewsSuccess:
                actionNotiNewsSuccess(state);
                break;
              case NotiNewsFailure:
                actionNotiNewsFailure(state);
                break;
              case DeleteNotiLoading:
                actionDeleteNotiLoading();
                break;
              case DeleteNotiSuccess:
                actionDeleteNotiSuccess();
                break;
              case DeleteNotiFailure:
                actionDeleteNotiFailure(state);
                break;
              case ActiveNotiSuccess:
                actionActiveNotiSuccess();
                break;
              case ActiveNotiFailure:
                actionActiveNotiFailure(state);
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
                          NotificationTab(
                            title: translate('notification_page.news'),
                            index: 0,
                            selectedTab: _selectedTab,
                            countRead: 0,
                          ),
                          NotificationTab(
                            title: translate('notification_page.systems'),
                            index: 1,
                            selectedTab: _selectedTab,
                            countRead: 0,
                          ),
                        ]),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        renderListNews(),
                        renderListSystem(),
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

  Widget renderListSystem() {
    List<Widget> items = [];
    for (int i = 0; i < listDataSystem.length; i++) {
      items.add(NotiItem(
        data: listDataSystem[i],
        onSlideDelete: onSlideDelete,
        onPressedNotificationDetail: onPressedNotificationDetail,
      ));
    }
    if (items.length > 0 && !loadingPage) {
      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox();
              },
              shrinkWrap: false,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                  ),
                  child: items[index],
                );
              },
            ),
          ),
        ),
      );
    } else if (loadingPage) {
      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox();
              },
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: false,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Skeletonizer(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(24, 10, 24, 18),
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Bone.circle(size: 72),
                          const SizedBox(width: 16),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Bone.text(words: 2),
                                const SizedBox(height: 8),
                                Bone.text(
                                  words: 1,
                                  fontSize:
                                      Utilities.sizeFontWithDesityForDisplay(
                                          context, AppFontSize.supermini),
                                ),
                                const SizedBox(height: 4),
                                Bone.text(
                                  words: 1,
                                  fontSize:
                                      Utilities.sizeFontWithDesityForDisplay(
                                          context, AppFontSize.supermini),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                );
              },
            ),
          ),
        ),
      );
    } else {
      return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageAsset.img_notification_empty,
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 8),
                TextLabel(
                  text: translate('empty.notification'),
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.superlarge),
                  color: AppTheme.black40,
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget renderListNews() {
    List<Widget> items = [];
    for (int i = 0; i < listDataNews.length; i++) {
      items.add(NotiItemNews(
        data: listDataNews[i],
        onSlideDelete: onSlideDelete,
        onPressedNotificationDetail: onPressedNotificationDetail,
      ));
    }
    if (items.length > 0 && !loadingPage) {
      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox();
              },
              shrinkWrap: false,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                  ),
                  child: items[index],
                );
              },
            ),
          ),
        ),
      );
    } else if (loadingPage) {
      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox();
              },
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: false,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Skeletonizer(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(24, 10, 24, 18),
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Bone.circle(size: 72),
                          const SizedBox(width: 16),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Bone.text(words: 2),
                                const SizedBox(height: 8),
                                Bone.text(
                                  words: 1,
                                  fontSize:
                                      Utilities.sizeFontWithDesityForDisplay(
                                          context, AppFontSize.supermini),
                                ),
                                const SizedBox(height: 4),
                                Bone.text(
                                  words: 1,
                                  fontSize:
                                      Utilities.sizeFontWithDesityForDisplay(
                                          context, AppFontSize.supermini),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                );
              },
            ),
          ),
        ),
      );
    } else {
      return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageAsset.img_notification_empty,
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 8),
                TextLabel(
                  text: translate('empty.notification'),
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.superlarge),
                  color: AppTheme.black40,
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
