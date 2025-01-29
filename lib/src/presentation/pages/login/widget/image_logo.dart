import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jupiter/src/images_asset.dart';

class ImageLogo extends StatelessWidget {
  const ImageLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const ColorFiltered(
    //   colorFilter: ColorFilter.mode(
    //     Colors.white,
    //     BlendMode.srcIn,
    //   ),
    //   child: Image(width: 200, image: AssetImage('assets/images/logo.png')),
    // );
    return SvgPicture.asset(
      ImageAsset.logo_color,
      width: 250,
    );
  }
}
