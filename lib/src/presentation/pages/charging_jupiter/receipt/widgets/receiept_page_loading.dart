// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';

class ReceiptPageLoading extends StatelessWidget {
  ReceiptPageLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.grey.withOpacity(0.5),
      child: const Center(
          child: CircularProgressIndicator(
        color: AppTheme.blueDark,
        strokeCap: StrokeCap.round,
      )),
    );
  }
}
