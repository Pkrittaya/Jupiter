import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/utilities.dart';

class TooltipInformation extends StatefulWidget {
  const TooltipInformation({Key? key, required this.message, this.iconSize})
      : super(key: key);
  final String message;
  final double? iconSize;

  @override
  _TooltipInformationState createState() => _TooltipInformationState();
}

class _TooltipInformationState extends State<TooltipInformation> {
  double px = 0;
  double py = 0;

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<State<Tooltip>>();

    return Visibility(
      visible: false,
      child: Tooltip(
        key: key,
        preferBelow: false,
        decoration: ShapeDecoration(
          color: AppTheme.pttBlue,
          shape: TooltipInformState(key: key, dx: px, dy: py, context: context),
        ),
        message: widget.message,
        textStyle: TextStyle(
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.small),
            color: AppTheme.white),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onTap(key),
          child: Icon(
            Icons.info_outline,
            size: widget.iconSize ?? 12,
            color: AppTheme.blueDark,
          ),
        ),
      ),
    );
  }

  void _onTap(GlobalKey key) {
    final dynamic tooltip = key.currentState;
    tooltip?.ensureTooltipVisible();
  }
}

// ignore: must_be_immutable
class TooltipInformState extends ShapeBorder {
  bool usePadding;
  double dx;
  double dy;
  GlobalKey key;
  BuildContext context;

  TooltipInformState(
      {required this.key,
      this.usePadding = true,
      required this.dx,
      required this.dy,
      required this.context});

  genXY(GlobalKey key) {
    final dynamic tooltip = key.currentState;
    tooltip?.ensureTooltipVisible();

    RenderBox renderbox = key.currentContext!.findRenderObject() as RenderBox;
    Offset position = renderbox.localToGlobal(Offset.zero);
    dx = position.dx;
    dy = position.dy;
  }

  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.only(bottom: usePadding ? 5 : 0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect = Rect.fromPoints(rect.topLeft, rect.bottomRight);

    genXY(key);

    double? relativeA;
    double? relativeB;

    double widthWidgetTooltip = MediaQuery.of(context).size.width;

    double widthOverTooltip = (widthWidgetTooltip - 40) - dx;
    double widthTooltip = rect.width / 2;

    if (dx > 100) {
      if (widthOverTooltip < widthTooltip) {
        dx = rect.width - (((widthWidgetTooltip - 40) - dx) + 16);
      } else {
        dx = rect.width / 2 + 5;
      }
    }

    if (dy < 30) {
      dy = rect.topCenter.dy;
      relativeA = -15;
      relativeB = 15;
    } else {
      dy = rect.bottomCenter.dy;
      relativeA = 15;
      relativeB = -15;
    }

    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(5)))
      ..moveTo(dx - 10, dy)
      ..relativeLineTo(5, relativeA)
      ..relativeLineTo(5, relativeB)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
