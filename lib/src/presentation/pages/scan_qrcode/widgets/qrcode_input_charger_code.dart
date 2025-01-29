import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/utilities.dart';

class QrCodeInputChargerCode extends StatefulWidget {
  const QrCodeInputChargerCode({
    super.key,
    required this.indexTab,
    required this.chargerCodeController,
    required this.onSubmitTextField,
  });
  final int indexTab;
  final TextEditingController chargerCodeController;
  final Function(String) onSubmitTextField;
  @override
  _QrCodeInputChargerCodeState createState() => _QrCodeInputChargerCodeState();
}

class _QrCodeInputChargerCodeState extends State<QrCodeInputChargerCode> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    if (widget.indexTab == 1) {
      return Positioned(
        top: height * 0.3,
        child: Container(
          width: width,
          child: Center(
            child: Container(
              width: width * 0.8,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                onFieldSubmitted: widget.indexTab == 1
                    ? (String value) {
                        widget.onSubmitTextField(value);
                      }
                    : (String value) {},
                controller: widget.chargerCodeController,
                decoration: InputDecoration(
                    suffixIcon: renderIconSubmitButton(),
                    border: InputBorder.none,
                    counterText: '',
                    contentPadding: const EdgeInsets.all(6)),
                style: TextStyle(
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.title),
                  color: AppTheme.black40,
                  height: 1.2,
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Widget renderIconSubmitButton() {
    return GestureDetector(
      onTap: () {
        widget.onSubmitTextField(widget.chargerCodeController.text);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.blueD,
          borderRadius: BorderRadius.circular(200),
        ),
        child: SvgPicture.asset(
          ImageAsset.ic_correct_password,
          color: AppTheme.white,
        ),
      ),
    );
  }
}
