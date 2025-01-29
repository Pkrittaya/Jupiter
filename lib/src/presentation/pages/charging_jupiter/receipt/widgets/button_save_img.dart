import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';

class ButtonSaveImg extends StatefulWidget {
  const ButtonSaveImg({
    Key? key,
    required this.text,
    required this.onClickButton,
    this.fleetType,
  }) : super(key: key);

  final String text;
  final Function() onClickButton;
  final String? fleetType;
  @override
  _ButtonSaveImgState createState() => _ButtonSaveImgState();
}

class _ButtonSaveImgState extends State<ButtonSaveImg> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(200),
        child: InkWell(
          borderRadius: BorderRadius.circular(200),
          onTap: widget.onClickButton,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: widget.fleetType != FleetType.OPERATION ? 20 : 12,
            ),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppTheme.borderGray),
              borderRadius: BorderRadius.circular(200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  ImageAsset.ic_home_active,
                  width: 20,
                  height: 20,
                  color: AppTheme.blueDark,
                ),
                const SizedBox(width: 8),
                TextLabel(
                  text: widget.text,
                  color: AppTheme.blueDark,
                ),
              ],
            ),
          ),
        ));
  }
}
