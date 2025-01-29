import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter_api/domain/entities/profile_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/main_menu/cubit/main_menu_cubit.dart';
import 'package:jupiter/src/presentation/pages/more/widgets/more_list_all_item.dart';
import 'package:jupiter/src/presentation/pages/more/widgets/more_page_appbar.dart';
import 'package:jupiter/src/presentation/pages/more/widgets/more_title_menu.dart';

import '../../../firebase_log.dart';
import '../../../route_names.dart';

class MoreMenuItemData {
  MoreMenuItemData(
    this.leadingIconAsset,
    this.name,
    this.trailingIcon,
    this.pageName,
  );
  final String leadingIconAsset;
  final String name;
  final IconData trailingIcon;
  final String pageName;
}

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  ProfileEntity? profileEntity;
  List<MoreMenuItemData> menuDatasAccount = [
    MoreMenuItemData(
      ImageAsset.ic_vehicle_more,
      translate('more_page.menu.vehicle'),
      Icons.arrow_forward_ios,
      RouteNames.ev_information,
    ),
    MoreMenuItemData(
      ImageAsset.ic_favorite_more,
      translate('more_page.menu.favorite'),
      Icons.arrow_forward_ios,
      RouteNames.favorite,
    ),
    MoreMenuItemData(
      ImageAsset.ic_payment_more,
      translate('more_page.menu.payment'),
      Icons.arrow_forward_ios,
      RouteNames.payment,
    ),
    MoreMenuItemData(
      ImageAsset.ic_coupon_more,
      translate('more_page.menu.coupon'),
      Icons.arrow_forward_ios,
      RouteNames.coupon,
    )
  ];

  List<MoreMenuItemData> menuDatasGeneral = [
    MoreMenuItemData(
      ImageAsset.ic_update_pin,
      translate('more_page.menu.update_pin'),
      Icons.arrow_forward_ios,
      RouteNames.update_pincode,
    ),
    MoreMenuItemData(
      ImageAsset.ic_security_more,
      translate('more_page.menu.security'),
      Icons.arrow_forward_ios,
      RouteNames.setting_privacy,
    ),
  ];

  @override
  void initState() {
    FirebaseLog.logPage(this);
    super.initState();
  }

  void initValue() async {
    setState(() {
      menuDatasAccount = [
        MoreMenuItemData(
          ImageAsset.ic_vehicle_more,
          translate('more_page.menu.vehicle'),
          Icons.arrow_forward_ios,
          RouteNames.ev_information,
        ),
        MoreMenuItemData(
          ImageAsset.ic_favorite_more,
          translate('more_page.menu.favorite'),
          Icons.arrow_forward_ios,
          RouteNames.favorite,
        ),
        MoreMenuItemData(
          ImageAsset.ic_payment_more,
          translate('more_page.menu.payment'),
          Icons.arrow_forward_ios,
          RouteNames.payment,
        ),
        MoreMenuItemData(
          ImageAsset.ic_coupon_more,
          translate('more_page.menu.coupon'),
          Icons.arrow_forward_ios,
          RouteNames.coupon,
        )
      ];

      menuDatasGeneral = [
        MoreMenuItemData(
          ImageAsset.ic_update_pin,
          translate('more_page.menu.update_pin'),
          Icons.arrow_forward_ios,
          RouteNames.update_pincode,
        ),
        MoreMenuItemData(
          ImageAsset.ic_security_more,
          translate('more_page.menu.security'),
          Icons.arrow_forward_ios,
          RouteNames.setting_privacy,
        ),
      ];
    });
  }

  void onClickProfile() {
    Navigator.pushNamed(context, RouteNames.profile_edit);
  }

  Future<void> onPressedItemMenu(String namePage) async {
    if (namePage.isNotEmpty && namePage != '') {
      await Navigator.pushNamed(context, namePage);
      if (namePage == RouteNames.setting_privacy) {
        initValue();
        BlocProvider.of<MainMenuCubit>(context).setStateForChangeLanguage();
      }
    } else {
      debugPrint('ERROR');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Column(
        children: [
          MorePageAppBar(
            onClickProfile: onClickProfile,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 280,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MoreTitleMenu(
                      text: translate('more_page.title.account'),
                      paddingTop: true,
                    ),
                    MoreListAllItem(
                      data: menuDatasAccount,
                      onPressedItemMenu: onPressedItemMenu,
                    ),
                    MoreTitleMenu(
                      text: translate('more_page.title.general'),
                      paddingTop: true,
                    ),
                    MoreListAllItem(
                      data: menuDatasGeneral,
                      onPressedItemMenu: onPressedItemMenu,
                    ),
                    const SizedBox(height: 40),
                    // TextButton(
                    //   onPressed: () => throw Exception(),
                    //   child: const Text("Throw Test Exception"),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
