import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jupiter/src/images_asset.dart';

class BGImage extends StatelessWidget {
  const BGImage({
    super.key,
    required this.hasBgImage,
  });

  final bool hasBgImage;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: hasBgImage,
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 90,
        ),
        child: SvgPicture.asset(
          ImageAsset.bg_receipt_ex,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
