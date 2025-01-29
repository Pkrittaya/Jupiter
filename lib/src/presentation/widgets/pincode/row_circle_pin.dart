import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';

class RowCirclePin extends StatefulWidget {
  const RowCirclePin({
    super.key,
    required this.pinCode,
  });
  final String pinCode;

  @override
  State<RowCirclePin> createState() => _RowCirclePinState();
}

class _RowCirclePinState extends State<RowCirclePin> {
  double circleSize = 24;
  double spaceSize = 16;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.circle,
          color: widget.pinCode.length >= 1 ? AppTheme.blueD : AppTheme.black40,
          size: circleSize,
        ),
        SizedBox(
          width: spaceSize,
        ),
        Icon(
          Icons.circle,
          color: widget.pinCode.length >= 2 ? AppTheme.blueD : AppTheme.black40,
          size: circleSize,
        ),
        SizedBox(
          width: spaceSize,
        ),
        Icon(
          Icons.circle,
          color: widget.pinCode.length >= 3 ? AppTheme.blueD : AppTheme.black40,
          size: circleSize,
        ),
        SizedBox(
          width: spaceSize,
        ),
        Icon(
          Icons.circle,
          color: widget.pinCode.length >= 4 ? AppTheme.blueD : AppTheme.black40,
          size: circleSize,
        ),
        SizedBox(
          width: spaceSize,
        ),
        Icon(
          Icons.circle,
          color: widget.pinCode.length >= 5 ? AppTheme.blueD : AppTheme.black40,
          size: circleSize,
        ),
        SizedBox(
          width: spaceSize,
        ),
        Icon(
          Icons.circle,
          color: widget.pinCode.length >= 6 ? AppTheme.blueD : AppTheme.black40,
          size: circleSize,
        ),
      ],
    );
  }
}
