
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../apptheme.dart';

class PinImage extends StatelessWidget {
  const PinImage({
    super.key,
    required this.imageAsset,
    required this.onTap,
  });
  final String imageAsset;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var sizeMedia = MediaQuery.of(context).size;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: AppTheme.blueSplashPin,
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all((sizeMedia.width * 0.05).toDouble()),
          child: SvgPicture.asset(
            imageAsset,
            width: 32,
            height: 32,
          ),
        ),
      ),
    );
  }
}
