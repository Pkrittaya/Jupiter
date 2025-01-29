import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../../apptheme.dart';
import '../../../constant_value.dart';
import '../../../firebase_log.dart';
import '../../../utilities.dart';
import '../../widgets/pincode/pin_code.dart';
import '../../widgets/text_label.dart';

class UpdatePinCodePage extends StatefulWidget {
  const UpdatePinCodePage({super.key});

  @override
  State<UpdatePinCodePage> createState() => _UpdatePinCodePageState();
}

class _UpdatePinCodePageState extends State<UpdatePinCodePage> {
  @override
  void initState() {
    FirebaseLog.logPage(this);
    super.initState();
  }

  void onPressedBackButton() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var sizeMedia = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.white,
        iconTheme: const IconThemeData(
          color: AppTheme.blueDark, //change your color here
        ),
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppTheme.blueDark),
            onPressed: onPressedBackButton),
        title: TextLabel(
          text: translate('app_title.update_pin'),
          color: AppTheme.blueDark,
          fontSize: Utilities.sizeFontWithDesityForDisplay(
              context, AppFontSize.title),
          fontWeight: FontWeight.bold,
        ),
      ),
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: sizeMedia.height * 0.07,
            ),
            SizedBox(
              height: sizeMedia.height * 0.07,
            ),
            PinCode(
              pinCodeMode: PinCodeMode.update,
            ),
          ],
        ),
      ),
    );
  }
}
