import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kgkdiamonds/core/constant/app_images.dart';

import '../../filter/presentation/filter.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Filter()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF344444),
      body: Center(
        child: Image.asset(
          AppImages.APPLGOG,
        ),
      ),
    );
  }
}
