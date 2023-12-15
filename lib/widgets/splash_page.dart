import 'package:apay/classes/hex_color.dart';
import 'package:apay/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

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
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: HexColor(AppConst.backgroundColor),
        statusBarIconBrightness: Brightness.light));

    return Scaffold(
      body: Container(
        color: HexColor(AppConst.backgroundColor),
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
                fontWeight: FontWeight.bold),
          ),
        )),
      ),
    );
  }
}
