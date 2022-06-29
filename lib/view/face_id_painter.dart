import 'dart:math' as math;

import 'package:face_id_animation/animation/face_id_animation_controller.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

class FaceIDPainter extends CustomPainter {
  FaceIDPainter({
    required this.controller,
  }) : super(repaint: controller.animationController);
  final FaceIDAnimationController controller;

  @override
  void paint(Canvas canvas, Size size) {
    //* Layout
    assert(
      size.width == size.height,
      'FaceIDPainter only works with square sized widgets.',
    );

    const color = Color(0xFF006BF3);

    final s = size.height; // side
    final oneHalf = s / 2;
    final oneThird = s / 3;
    final twoThirds = 2 * oneThird;
    final center = Offset(oneHalf, oneHalf);
    final radius = math.min(oneHalf, oneHalf);

    //* Animations
    // Left, Right, Up, Down
    final moveR1 = controller.moveR1.value;
    final moveL1 = controller.moveL1.value;
    final moveR2 = controller.moveR2.value;
    final moveU1 = controller.moveU1.value;
    final moveD1 = controller.moveD1.value;
    final moveU2 = controller.moveU2.value;

    // X and Y axis from Left, Right, Up, Down
    final moveX = moveR1 + moveL1 + moveR2;
    final moveY = moveU1 + moveD1 + moveU2;

    // Conditional animations
    final canBlink = controller.animationController.value >= .6 &&
        controller.animationController.value <= .65;
    final canShowCheck1 = controller.animationController.value >= .9;
    final canShowCheck2 = controller.animationController.value >= .93;

    // X and Y axis
    final check1X = controller.check1X.value;
    final check1Y = controller.check1Y.value;
    final check2X = controller.check2X.value;
    final check2Y = controller.check2Y.value;
    final closeRRect = controller.closeRRect.value;
    final borderRadiusRRect = controller.borderRadiusRRect.value;
    final faceOpacity = controller.faceOpacity.value;

    //* General Paint
    final strokeWidth = s * 0.06;
    final facePaint = Paint()
      ..strokeWidth = strokeWidth
      ..color = color.withOpacity(faceOpacity)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    //* Eyes
    final eyeLength = s * .1;
    final eyeBlinkPaint = Paint()
      ..strokeWidth = strokeWidth
      ..color = canBlink ? Colors.transparent : color.withOpacity(faceOpacity)
      ..strokeCap = StrokeCap.round;
    final leftEyeP1 = Offset(oneThird + moveX, oneThird + moveY);
    final leftEyeP2 = Offset(oneThird + moveX, oneThird + eyeLength + moveY);
    canvas.drawLine(leftEyeP1, leftEyeP2, facePaint);
    final rightEyeP1 = Offset(twoThirds + moveX, oneThird + moveY);
    final rightEyeP2 = Offset(twoThirds + moveX, oneThird + eyeLength + moveY);
    canvas.drawLine(rightEyeP1, rightEyeP2, eyeBlinkPaint);

    //* Smyle
    final rect = Rect.fromCircle(
      center: Offset(center.dx + moveX, center.dy + moveY),
      radius: s * .225,
    );
    final startAngle = vector.radians(130);
    final endAngle = vector.radians(-90);
    canvas.drawArc(rect, startAngle, endAngle, false, facePaint);

    //* Nose
    final offsetFactor = s * 0.006;
    final noseOffsetX = s * 0.015;
    final noseOffsetY = s * 0.175;
    final noseHeight = s * 0.225;
    final noseWidth = s * 0.05;
    final nosePath = Path()
      ..moveTo(
        (oneHalf + noseOffsetX) + moveX * offsetFactor,
        oneThird + moveY,
      )
      ..lineTo(
        (oneHalf + noseOffsetX) + moveX * offsetFactor,
        oneThird + moveY + noseOffsetY,
      )
      ..quadraticBezierTo(
        (oneHalf + noseOffsetX) + moveX * offsetFactor,
        oneThird + noseHeight + moveY,
        (oneHalf - noseWidth) + moveX * offsetFactor,
        oneThird + noseHeight + moveY,
      );
    canvas.drawPath(nosePath, facePaint);

    //* Borders
    final paintBorders = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    final rRect = RRect.fromRectAndRadius(
      Rect.fromCircle(center: center, radius: radius),
      Radius.circular(borderRadiusRRect),
    );
    canvas.drawRRect(rRect, paintBorders);

    //* Border Separator
    final lines = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white
      ..strokeWidth = s * 0.07;
    final closeOffsetYP1 = oneThird * (1 + closeRRect);
    final closeOffsetYP2 = oneThird * (2 - closeRRect);
    canvas
      ..drawLine(
        Offset(0, closeOffsetYP1),
        Offset(0, closeOffsetYP2),
        lines,
      )
      ..drawLine(
        Offset(s, closeOffsetYP1),
        Offset(s, closeOffsetYP2),
        lines,
      )
      ..drawLine(
        Offset(closeOffsetYP1, 0),
        Offset(closeOffsetYP2, 0),
        lines,
      )
      ..drawLine(
        Offset(closeOffsetYP1, s),
        Offset(closeOffsetYP2, s),
        lines,
      );

    //* Borders Caps
    final circle = Paint()
      ..style = PaintingStyle.fill
      ..color = color
      ..strokeWidth = s * 0.025;
    final capRadius = s * .03;
    canvas
      ..drawCircle(Offset(0, closeOffsetYP1), capRadius, circle)
      ..drawCircle(Offset(0, closeOffsetYP2), capRadius, circle)
      ..drawCircle(Offset(s, closeOffsetYP1), capRadius, circle)
      ..drawCircle(Offset(s, closeOffsetYP2), capRadius, circle)
      ..drawCircle(Offset(closeOffsetYP1, 0), capRadius, circle)
      ..drawCircle(Offset(closeOffsetYP2, 0), capRadius, circle)
      ..drawCircle(Offset(closeOffsetYP1, s), capRadius, circle)
      ..drawCircle(Offset(closeOffsetYP2, s), capRadius, circle);

    //* Check
    final check1 = Paint()
      ..strokeCap = StrokeCap.round
      ..color = canShowCheck1 ? color : Colors.transparent
      ..strokeWidth = strokeWidth;
    canvas.drawLine(
      Offset(s * .275, oneHalf),
      Offset(check1X, check1Y),
      check1,
    );
    final check2 = Paint()
      ..strokeCap = StrokeCap.round
      ..color = canShowCheck2 ? color : Colors.transparent
      ..strokeWidth = strokeWidth;
    canvas.drawLine(
      Offset(oneHalf, s * .7),
      Offset(check2X, check2Y),
      check2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
