import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/scan_qrcode/widgets/qrcode_appbar.dart';
import 'package:jupiter/src/presentation/widgets/button.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class OcrGoToSettingPage extends StatefulWidget {
  const OcrGoToSettingPage({
    Key? key,
    required this.onPressedBackButton,
    required this.onPressedGoToSetting,
  }) : super(key: key);

  final Function() onPressedBackButton;
  final Function() onPressedGoToSetting;
  @override
  _OcrGoToSettingPageState createState() => _OcrGoToSettingPageState();
}

class _OcrGoToSettingPageState extends State<OcrGoToSettingPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: AppTheme.white,
            height: height,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(ImageAsset.ic_permission_camera),
                const SizedBox(height: 24),
                TextLabel(
                  text: translate('qrcode_page.permission.title'),
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.title),
                  color: AppTheme.black,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                TextLabel(
                  text: translate('qrcode_page.permission.description'),
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.large),
                  color: AppTheme.black,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Container(
                  color: AppTheme.white,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.11,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Button(
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      shadowColor: Colors.transparent,
                      backgroundColor: AppTheme.blueD,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(200)),
                      ),
                    ),
                    text: translate('button.setting'),
                    onPressed: widget.onPressedGoToSetting,
                    textColor: Colors.white,
                  ),
                )
              ],
            ),
          ),
          QrCodeAppBar(
            onPressedBackButton: widget.onPressedBackButton,
            isDenied: true,
          ),
        ],
      ),
    );
  }
}
