import 'package:jupiter/src/images_asset.dart';
import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';
// import 'package:jupiter/src/presentation/pages/forgot_password/forgot_password_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonChangeLanguage extends StatefulWidget {
  const ButtonChangeLanguage({
    Key? key,
    required this.onPressedButton,
    required this.language,
  }) : super(key: key);

  final Function() onPressedButton;
  final bool language;

  @override
  _ButtonChangeLanguageState createState() => _ButtonChangeLanguageState();
}

class _ButtonChangeLanguageState extends State<ButtonChangeLanguage> {
  @override
  Widget build(BuildContext context) {
    debugPrint('language : ${widget.language}');
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: widget.onPressedButton,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppTheme.grayD1D5DB,
                ),
                height: 35,
                width: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: !widget.language
                            ? AppTheme.blueD.withOpacity(0.85)
                            : AppTheme.transparent,
                      ),
                      alignment: Alignment.center,
                      width: 32.5,
                      height: 28,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: SvgPicture.asset(
                          ImageAsset.ic_th,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: widget.language
                            ? AppTheme.blueD.withOpacity(0.85)
                            : AppTheme.transparent,
                      ),
                      alignment: Alignment.center,
                      width: 32.5,
                      height: 28,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: SvgPicture.asset(
                          ImageAsset.ic_en,
                        ),
                      ),
                    ),
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
