// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';

class CheckInPageLoading extends StatelessWidget {
  CheckInPageLoading({
    super.key,
  });

  double heightAppbar = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height - heightAppbar,
      child: const Center(
        child: CircularProgressIndicator(
          color: AppTheme.lightBlueProgress,
          strokeCap: StrokeCap.round,
        ),
      ),
    );
  }
}
