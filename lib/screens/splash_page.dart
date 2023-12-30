import 'package:apay/classes/hex_color.dart';
import 'package:apay/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacityValue = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: AppConst.splashAnimDuration), () {
      setState(() {
        opacityValue = 1.0;
      });
    });

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.popAndPushNamed(context, '/auth');
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppConst.backgroundColor,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      body: Container(
        color: AppConst.backgroundColor,
        child: Center(
          child: AnimatedOpacity(
            opacity: opacityValue,
            duration: Duration(milliseconds: AppConst.splashAnimDuration),
            child: Text(
              "apay",
              style: TextStyle(
                fontFamily: 'jiho',
                color: HexColor(AppConst.splashTextColor),
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}