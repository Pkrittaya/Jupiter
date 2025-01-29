import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';

class DividerForStation extends StatelessWidget {
  const DividerForStation({
    super.key,
    required this.top,
    required this.bottom,
  });

  final double top;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: EdgeInsets.only(top: top, bottom: bottom),
      color: AppTheme.borderGray,
    );
  }
}
