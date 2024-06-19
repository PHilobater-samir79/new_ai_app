import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yab_yab_ai/core/local_data/catch_helper.dart';
import 'package:yab_yab_ai/core/local_data/services_locator.dart';
import 'package:yab_yab_ai/core/utils/assets.dart';
import 'package:yab_yab_ai/features/screens/home/home_screen.dart';
import 'package:yab_yab_ai/features/screens/splash_screen/onBoarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  late AnimationController _controller;
  late Animation<double> animation1;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });
    _controller.forward();
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _fontSize = 1.06;
      });
    });
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });
    Timer(const Duration(seconds: 2), () {
      setState(() {
        navigator();
      });
    });
  }

  void navigator() {
    bool isVisited = getIt<CacheHelper>().getData(key: 'isVisited') ?? false;
    Future.delayed(const Duration(seconds: 3), () {
      isVisited
          ? Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return const HomeScreen();
              },
            ))
          : Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return const OnBoardingScreen();
              },
            ));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 1000),
          curve: Curves.fastLinearToSlowEaseIn,
          opacity: _containerOpacity,
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 2000),
              curve: Curves.fastLinearToSlowEaseIn,
              height: width / _containerSize,
              width: width / _containerSize,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: SvgPicture.asset(AppAssets.appIcon)),
        ),
      ),
    );
  }
}

class PageTransition extends PageRouteBuilder {
  final Widget page;

  PageTransition(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 2000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
            );
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: 0,
                child: page,
              ),
            );
          },
        );
}
