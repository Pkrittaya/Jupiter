// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CheckInPageTextError extends StatelessWidget {
  CheckInPageTextError({
    super.key,
  });

  double heightAppbar = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(16),
      height: height - heightAppbar,
      // child: Center(child: TextLabel(text: translate('${state.message}'))),
    );
  }
}
