import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SvgPicture.asset(
            imageAsset,
            width: 40,
            height: 40,
          ),
        ),
      ),
    );
  }
}
