import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/navigation_service.dart';
import 'package:jupiter/src/utilities.dart';
import '../../apptheme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
    this.showPopupInternet,
  }) : super(key: key);

  final bool? showPopupInternet;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static final GlobalKey<NavigatorState> _navigatorKey =
      getIt<NavigationService>().navigatorKey;

  bool isShow = false;

  @override
  void initState() {
    super.initState();
    showInternetPopupError();
  }

  void showInternetPopupError() {
    BuildContext context = _navigatorKey.currentContext!;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isShow) {
        setState(() {
          isShow = true;
        });
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.DEFAULT,
          isForce: true,
          title: translate('alert.title.default'),
          description: translate('alert.description.internet'),
          textButton: translate('button.Ok'),
          onPressButton: () {
            Navigator.of(context).pop();
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else if (Platform.isIOS) {
              exit(0);
            }
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: AppTheme.white,
      child: Image.asset(
        ImageAsset.splash_screen_gif,
        fit: BoxFit.cover,
      ),
    );
  }
}
