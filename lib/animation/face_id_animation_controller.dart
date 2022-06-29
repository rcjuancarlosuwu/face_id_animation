import 'package:flutter/material.dart';

/// [FaceIDAnimationController] is responsible for controlling the animation.
class FaceIDAnimationController {
  FaceIDAnimationController({
    required this.animationController,
    this.width = 200,
  })  : moveR1 = Tween<double>(
          begin: 0,
          end: 20,
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0, 0.2, curve: fastOutSlowInCurve),
          ),
        ),
        moveL1 = Tween<double>(
          begin: 0,
          end: -35,
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.2, 0.4, curve: fastOutSlowInCurve),
          ),
        ),
        moveU1 = Tween<double>(
          begin: 0,
          end: -10,
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.2, 0.3, curve: fastOutSlowInCurve),
          ),
        ),
        moveD1 = Tween<double>(
          begin: 0,
          end: 15,
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.3, 0.4, curve: fastOutSlowInCurve),
          ),
        ),
        moveR2 = Tween<double>(
          begin: 0,
          end: 15,
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.4, 0.6, curve: fastOutSlowInCurve),
          ),
        ),
        moveU2 = Tween<double>(
          begin: 0,
          end: -5,
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.4, 0.6, curve: fastOutSlowInCurve),
          ),
        ),
        closeRRect = Tween<double>(
          begin: 0,
          end: 0.5,
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.4, 0.6, curve: fastOutSlowInCurve),
          ),
        ),
        borderRadiusRRect = Tween<double>(
          begin: 50,
          end: 100,
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.45, 0.6, curve: fastOutSlowInCurve),
          ),
        ),
        faceOpacity = Tween<double>(
          begin: 1,
          end: 0,
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.825, 0.875, curve: fastOutSlowInCurve),
          ),
        ),
        check1X = Tween<double>(
          begin: width * .275,
          end: width * 0.5,
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.9, 0.95, curve: fastOutSlowInCurve),
          ),
        ),
        check1Y = Tween<double>(
          begin: width * 0.5,
          end: width * 0.7,
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.9, 0.95, curve: fastOutSlowInCurve),
          ),
        ),
        check2X = Tween<double>(
          begin: width * 0.5,
          end: width * 0.75,
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.95, 1, curve: bounceOutCurve),
          ),
        ),
        check2Y = Tween<double>(
          begin: width * 0.7,
          end: width * 0.3,
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.95, 1, curve: bounceOutCurve),
          ),
        );

  /// Curves for animations.
  static const fastOutSlowInCurve = Curves.fastOutSlowIn;
  static const bounceOutCurve = Curves.bounceOut;

  /// The animation controller that is used to drive the animation.
  final AnimationController animationController;

  /// The width of the animation.
  final double width;

  /// 1st move right animation.
  final Animation<double> moveR1;

  /// 1st move left animation.
  final Animation<double> moveL1;

  /// 2nd move right animation.
  final Animation<double> moveR2;

  /// 1st move up animation.
  final Animation<double> moveU1;

  /// 1st move down animation.
  final Animation<double> moveD1;

  /// 2nd move up animation.
  final Animation<double> moveU2;

  /// Close RRect animation.
  final Animation<double> closeRRect;

  /// Border radius RRect animation.
  final Animation<double> borderRadiusRRect;

  /// Face opacity animation.
  final Animation<double> faceOpacity;

  /// 1st check X axis animation.
  final Animation<double> check1X;

  /// 1st check Y axis animation.
  final Animation<double> check1Y;

  /// 2nd check X axis animation.
  final Animation<double> check2X;

  /// 2nd check Y axis animation.
  final Animation<double> check2Y;

  TickerFuture fordward() => animationController.forward();

  void reset() => animationController.reset();

  void dispose() => animationController.dispose();
}
