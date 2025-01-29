import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';
import '../../../firebase_log.dart';
import '../../../route_names.dart';
import '../../widgets/pincode/pin_code.dart';

class LockScreen extends StatefulWidget {
  LockScreen({super.key});
  // final GlobalKey<NavigatorState> navigatorKey =
  //     getIt<NavigationService>().navigatorKey;
  @override
  State<LockScreen> createState() => _LockScreenState();
}

// String pinCode = '';

class _LockScreenState extends State<LockScreen> {
  @override
  void initState() {
    FirebaseLog.logPage(this);
    initValue();
    super.initState();
  }

  Future<void> initValue() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var sizeMedia = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, sizeMedia.height * 0.03),
        width: sizeMedia.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.white,
              AppTheme.blueLight,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: sizeMedia.height * 0.15,
            ),
            SizedBox(
                child: SvgPicture.asset(
              ImageAsset.logo_color,
              width: sizeMedia.width * .4,
            )),
            SizedBox(
              height: sizeMedia.height * 0.07,
            ),
            PinCode(
              pinCodeMode: PinCodeMode.pin,
            ),
            Expanded(child: SizedBox()),
            TextButton(
              child: TextLabel(
                text: translate('pin_code.forgot_pin'),
                color: AppTheme.blueDark,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.superlarge),
                fontWeight: FontWeight.w700,
              ),
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.forgot_pincode);
              },
            ),
          ],
        ),
      ),
    );
  }
}
