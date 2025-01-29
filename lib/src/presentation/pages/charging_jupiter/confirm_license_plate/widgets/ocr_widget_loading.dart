import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';

class OcrWidgetLoading extends StatefulWidget {
  const OcrWidgetLoading({
    Key? key,
  }) : super(key: key);

  @override
  _OcrWidgetLoadingState createState() => _OcrWidgetLoadingState();
}

class _OcrWidgetLoadingState extends State<OcrWidgetLoading> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Stack(
        children: [
          Container(
            color: AppTheme.white,
            height: height,
            width: width,
            child: Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  color: AppTheme.lightBlue,
                  strokeCap: StrokeCap.round,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
