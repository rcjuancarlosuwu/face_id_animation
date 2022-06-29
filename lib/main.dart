import 'package:face_id_animation/view/view.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Face ID Animation',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const FaceIDView(),
    );
  }
}
