import 'package:flutter/material.dart';
import 'package:jupiter/src/images_asset.dart';
import '../../apptheme.dart';

class SplashScreenAnimation extends StatefulWidget {
  const SplashScreenAnimation({
    Key? key,
  }) : super(key: key);

  @override
  _SplashScreenAnimationState createState() => _SplashScreenAnimationState();
}

class _SplashScreenAnimationState extends State<SplashScreenAnimation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: AppTheme.white,
      child: Image.asset(
        ImageAsset.splash_screen_gif,
        fit: BoxFit.cover,
      ),
    );
  }
}
