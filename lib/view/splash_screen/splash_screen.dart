import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz/utils/animation_constants.dart';
import 'package:quiz/utils/color_constants.dart';
import 'package:quiz/view/category_screen/category_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then(
      (value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryScreen(),
            ));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.mainBlack,
      body: Center(
        child: Lottie.asset(AnimationConstants.logo, repeat: false),
      ),
    );
  }
}
