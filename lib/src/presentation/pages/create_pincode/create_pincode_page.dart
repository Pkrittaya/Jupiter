import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/images_asset.dart';

import '../../../firebase_log.dart';
import '../../widgets/pincode/pin_code.dart';

class CreatePinCodePage extends StatefulWidget {
  const CreatePinCodePage({super.key});

  @override
  State<CreatePinCodePage> createState() => _CreatePinCodePageState();
}

class _CreatePinCodePageState extends State<CreatePinCodePage> {
  bool enableBioMetrics = false;
  @override
  void initState() {
    FirebaseLog.logPage(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sizeMedia = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
        padding: EdgeInsets.fromLTRB(0, 20, 0, 53),
        width: sizeMedia.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: sizeMedia.height * 0.2,
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
              pinCodeMode: PinCodeMode.create,
            ),
          ],
        ),
      ),
    );
  }
}
