import 'package:face_id_animation/animation/face_id_animation_controller.dart';
import 'package:face_id_animation/view/face_id_painter.dart';
import 'package:flutter/material.dart';

class FaceIDView extends StatefulWidget {
  const FaceIDView({super.key});

  @override
  State<FaceIDView> createState() => _FaceIDView();
}

class _FaceIDView extends State<FaceIDView>
    with SingleTickerProviderStateMixin {
  late final FaceIDAnimationController _faceIDAnimationController;

  @override
  void initState() {
    _faceIDAnimationController = FaceIDAnimationController(
      animationController: AnimationController(
        duration: const Duration(seconds: 4),
        vsync: this,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _faceIDAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _faceIDAnimationController
        ..reset()
        ..fordward(),
      child: Scaffold(
        body: Center(
          child: CustomPaint(
            size: const Size(200, 200),
            painter: FaceIDPainter(
              controller: _faceIDAnimationController,
            ),
          ),
        ),
      ),
    );
  }
}
