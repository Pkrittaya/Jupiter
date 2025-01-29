import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key, required this.visible}) : super(key: key);

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: AppTheme.black80.withOpacity(0.2)),
          child: const Center(
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
      ),
    );
  }
}
