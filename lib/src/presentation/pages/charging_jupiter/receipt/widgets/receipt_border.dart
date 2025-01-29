import 'package:flutter/material.dart';

import '../../../../../apptheme.dart';
import 'dart:math' as math;

class ReceiptBorder extends ShapeBorder {
  final double radius;
  final double pathWidth;
  final double dashWidth;
  final Color borderColor;
  final Color bottomBorderColor;
  final Color topBorderColor;
  final bool topDash;
  final bool topVisible;
  final bool bottomDash;
  final bool bottonVisible;

  final bool leftTopReverse;
  final bool rightTopReverse;
  final bool leftBotReverse;
  final bool rightBotReverse;

  const ReceiptBorder({
    required this.radius,
    this.pathWidth = 1,
    this.dashWidth = 5,
    this.borderColor = AppTheme.black,
    this.topVisible = true,
    this.bottonVisible = true,
    this.topDash = false,
    this.bottomDash = false,
    this.leftBotReverse = false,
    this.leftTopReverse = false,
    this.rightBotReverse = false,
    this.rightTopReverse = false,
    this.bottomBorderColor = AppTheme.black,
    this.topBorderColor = AppTheme.black,
  });
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    // this is inner color  border color with paint
    Path path = Path();
    RRect rRect = RRect.fromRectAndCorners(
      rect,
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
      bottomLeft: Radius.circular(radius),
      bottomRight: Radius.circular(radius),
    );

    double left = rRect.left + pathWidth;
    double right = rRect.right - pathWidth;
    double top = rRect.top + pathWidth;
    double bot = rRect.bottom - pathWidth;

    double leftR = left + radius;
    double rightR = right - radius;
    double topR = top + radius;
    double botR = bot - radius;

    path.moveTo(leftR, top);
    path.lineTo(rightR, top);

    //Right Top
    if (rightTopReverse) {
      path.arcToPoint(
        Offset(
          rightR + radius / 3,
          top + radius / 2,
        ),
        radius: Radius.circular(radius),
        clockwise: false,
      );
      path.arcToPoint(
        Offset(
          right,
          topR,
        ),
        radius: Radius.circular(radius),
        clockwise: true,
      );
    } else {
      path.arcToPoint(
        Offset(
          right,
          topR,
        ),
        radius: Radius.circular(radius),
        clockwise: true,
      );
    }
    // Right Bot
    path.lineTo(right, botR);
    if (rightBotReverse) {
      path.arcToPoint(
        Offset(
          rightR + radius / 3,
          bot - radius / 2,
        ),
        radius: Radius.circular(radius),
        clockwise: true,
      );
      path.arcToPoint(
        Offset(
          rightR,
          bot,
        ),
        radius: Radius.circular(radius),
        clockwise: false,
      );
    } else {
      path.arcToPoint(
        Offset(
          rightR,
          bot,
        ),
        radius: Radius.circular(radius),
        clockwise: true,
      );
    }
    // Left Bot
    path.lineTo(leftR, bot);
    if (leftBotReverse) {
      path.arcToPoint(
        Offset(
          leftR - radius / 3,
          bot - radius / 2,
        ),
        radius: Radius.circular(radius),
        clockwise: false,
      );
      path.arcToPoint(
        Offset(
          left,
          botR,
        ),
        radius: Radius.circular(radius),
        clockwise: true,
      );
    } else {
      path.arcToPoint(
        Offset(
          left,
          botR,
        ),
        radius: Radius.circular(radius),
        clockwise: true,
      );
    }
    // Left Top
    path.lineTo(left, topR);
    if (leftTopReverse) {
      path.arcToPoint(
        Offset(
          left + radius / 3,
          topR - radius / 2,
        ),
        radius: Radius.circular(radius),
        clockwise: true,
      );
      path.arcToPoint(
        Offset(
          leftR,
          top,
        ),
        radius: Radius.circular(radius),
        clockwise: false,
      );
    } else {
      path.arcToPoint(
        Offset(
          leftR,
          top,
        ),
        radius: Radius.circular(radius),
        clockwise: true,
      );
    }

    path.lineTo(rightR, top);

    return path;
  }

  @override
  ShapeBorder scale(double t) => ReceiptBorder(radius: radius);
  Path getDashedPath({
    required math.Point<double> a,
    required math.Point<double> b,
    @required gap,
  }) {
    Size size = Size(b.x - a.x, b.y - a.y);
    Path path = Path();
    path.moveTo(a.x, a.y);
    bool shouldDraw = true;
    math.Point currentPoint = math.Point(a.x, a.y);

    num radians = math.atan(size.height / size.width);

    num dx = math.cos(radians) * gap < 0
        ? math.cos(radians) * gap * -1
        : math.cos(radians) * gap;

    num dy = math.sin(radians) * gap < 0
        ? math.sin(radians) * gap * -1
        : math.sin(radians) * gap;

    while (currentPoint.x <= b.x && currentPoint.y <= b.y) {
      shouldDraw
          ? path.lineTo(currentPoint.x.toDouble(), currentPoint.y.toDouble())
          : path.moveTo(currentPoint.x.toDouble(), currentPoint.y.toDouble());
      shouldDraw = !shouldDraw;
      currentPoint = math.Point(
        currentPoint.x + dx,
        currentPoint.y + dy,
      );
    }
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    double gap = dashWidth;
    Paint dashedPaint = Paint()
      ..color = borderColor
      ..strokeWidth = pathWidth
      ..style = PaintingStyle.stroke;

    Paint topPaint = Paint()
      ..color = topBorderColor
      ..strokeWidth = pathWidth
      ..style = PaintingStyle.stroke;

    Paint bottomPaint = Paint()
      ..color = bottomBorderColor
      ..strokeWidth = pathWidth
      ..style = PaintingStyle.stroke;

    RRect rRect = RRect.fromRectAndCorners(
      rect,
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
      bottomLeft: Radius.circular(radius),
      bottomRight: Radius.circular(radius),
    );
    double left = rRect.left;
    double right = rRect.right;
    double top = rRect.top;
    double bot = rRect.bottom;

    double leftR = left + radius;
    double rightR = right - radius;
    double topR = top + radius;
    double botR = bot - radius;

    Path topPathDash = getDashedPath(
      a: math.Point(leftR, top),
      b: math.Point(rightR, top),
      gap: gap,
    );
    Path topPathSolid = Path();
    topPathSolid.moveTo(leftR, top);
    topPathSolid.lineTo(rightR, top);

    // Path _rightPath = getDashedPath(
    //   a: math.Point(rRect.right, rRect.top),
    //   b: math.Point(rRect.right, rRect.bottom - radius),
    //   gap: gap,
    // );
    Path rightPath = Path();
    rightPath.moveTo(right, topR);
    rightPath.lineTo(right, botR);

    Path bottomPathDash = getDashedPath(
      a: math.Point(rRect.left + radius, rRect.bottom),
      b: math.Point(rRect.right - radius, rRect.bottom),
      gap: gap,
    );
    Path bottomPathSolid = Path();
    bottomPathSolid.moveTo(leftR, bot);
    bottomPathSolid.lineTo(rightR, bot);

    // Path _leftPath = getDashedPath(
    //   a: math.Point(rRect.left, rRect.top + radius),
    //   b: math.Point(rRect.left, rRect.bottom - radius),
    //   gap: gap,
    // );
    Path leftPath = Path();
    leftPath.moveTo(left, topR);
    leftPath.lineTo(left, botR);

    Path arcRightTopReverse = createArcCorner(rightR, top, right, topR);

    arcRightTopReverse = Path();
    arcRightTopReverse.moveTo(rightR, top);
    arcRightTopReverse.arcToPoint(
      Offset(
        rightR + radius / 3,
        top + radius / 2,
      ),
      radius: Radius.circular(radius),
      clockwise: false,
    );
    arcRightTopReverse.arcToPoint(
      Offset(
        right,
        topR,
      ),
      radius: Radius.circular(radius),
      clockwise: true,
    );

    Path arcLeftTopReverse = createArcCorner(left, topR, leftR, top);

    arcLeftTopReverse = Path();
    arcLeftTopReverse.moveTo(left, topR);
    arcLeftTopReverse.arcToPoint(
      Offset(
        left + radius / 3,
        topR - radius / 2,
      ),
      radius: Radius.circular(radius),
      clockwise: true,
    );
    arcLeftTopReverse.arcToPoint(
      Offset(
        leftR,
        top,
      ),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    Path arcRightBotReverse = createArcCorner(right, botR, rightR, bot);

    arcRightBotReverse = Path();
    arcRightBotReverse.moveTo(right, botR);
    arcRightBotReverse.arcToPoint(
      Offset(
        right - radius / 3,
        botR + radius / 2,
      ),
      radius: Radius.circular(radius),
      clockwise: true,
    );
    arcRightBotReverse.arcToPoint(
      Offset(
        rightR,
        bot,
      ),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    Path arcLeftBotReverse = createArcCorner(leftR, bot, left, botR);

    arcLeftBotReverse = Path();
    arcLeftBotReverse.moveTo(leftR, bot);
    arcLeftBotReverse.arcToPoint(
      Offset(
        leftR - radius / 3,
        bot - radius / 2,
      ),
      radius: Radius.circular(radius),
      clockwise: false,
    );
    arcLeftBotReverse.arcToPoint(
      Offset(
        left,
        botR,
      ),
      radius: Radius.circular(radius),
      clockwise: true,
    );

    Path arcLeftTop = createArcCorner(leftR, top, left, topR);

    Path arcRightTop = createArcCorner(right, topR, rightR, top);

    Path arcRightBot = createArcCorner(rightR, bot, right, botR);
    Path arcLeftBot = createArcCorner(left, botR, leftR, bot);

    Paint useTPaint = Paint();
    if (topBorderColor != AppTheme.black) {
      useTPaint = topPaint;
    } else {
      useTPaint = dashedPaint;
    }

    if (topVisible) {
      if (topDash) {
        canvas.drawPath(topPathDash, useTPaint);
      } else {
        canvas.drawPath(topPathSolid, useTPaint);
      }
    }

    if (bottomBorderColor != AppTheme.black) {
      useTPaint = bottomPaint;
    } else {
      useTPaint = dashedPaint;
    }
    if (bottonVisible) {
      if (bottomDash) {
        canvas.drawPath(bottomPathDash, useTPaint);
      } else {
        canvas.drawPath(bottomPathSolid, useTPaint);
      }
    }

    canvas.drawPath(leftPath, dashedPaint);
    canvas.drawPath(rightPath, dashedPaint);

    leftTopReverse
        ? canvas.drawPath(arcLeftTopReverse, dashedPaint)
        : canvas.drawPath(arcLeftTop, dashedPaint);

    leftBotReverse
        ? canvas.drawPath(arcLeftBotReverse, dashedPaint)
        : canvas.drawPath(arcLeftBot, dashedPaint);

    rightTopReverse
        ? canvas.drawPath(arcRightTopReverse, dashedPaint)
        : canvas.drawPath(arcRightTop, dashedPaint);
    rightBotReverse
        ? canvas.drawPath(arcRightBotReverse, dashedPaint)
        : canvas.drawPath(arcRightBot, dashedPaint);
  }

  Path createArcCorner(
      double moveX, double moveY, double arcDesX, double arcDesY) {
    Path path = Path();

    path.moveTo(moveX, moveY);
    path.arcToPoint(
      Offset(
        arcDesX,
        arcDesY,
      ),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    return path;
  }
}
